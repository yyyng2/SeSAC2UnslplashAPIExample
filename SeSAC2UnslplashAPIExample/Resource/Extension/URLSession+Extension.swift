//
//  URLSession+Extension.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/28.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult func customDataTask(_ endpoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask{
        let task = dataTask(with: endpoint, completionHandler: completionHandler)
        task.resume()
        return task
    }
    
    static func request<T: Codable>(_ session: URLSession = .shared, endpoint: URLRequest, completionHandler: @escaping (T?, APIError?) -> Void){
        
        session.customDataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("Failed Request")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No data returned")
                    completionHandler(nil, .noData)
                    return
                }
                
                //statusCode 확인을 위해서 타입캐스팅
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completionHandler(nil, .failedRequest)
                    return
                }

                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    print(result)
                    completionHandler(result, nil)
                } catch{
                    print(error)
                    completionHandler(nil, .invalidData)
                }
                
            }
        }
        
    
    }
}
