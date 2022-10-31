//
//  APIManager.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/28.
//

import Foundation

class UnsplashURLSessionAPIManager {
    
    static func searchPhoto(query: String, completionHandler: @escaping (SearchPhoto?, APIError?) -> Void){
        
        let scheme = "https"
        let host = "api.unsplash.com"
        let path = "/search/photos"

        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "client_id", value: APIKey.apiKey)
        ]

        guard let url = component.url else { return }
        
        var request = URLRequest(url: url)
        
        //header 설정
//        request.setValue(APIKey.authorization, forHTTPHeaderField: "Authorization")

//        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(query)?client_id=\(APIKey.apiKey)")!
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
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
                
                guard (200...299).contains(response.statusCode) else {
                    print("Failed Response")
                    completionHandler(nil, .failedRequest)
                    return
                }

                do{
                    let result = try JSONDecoder().decode(SearchPhoto.self, from: data)
                    print(result)
                    completionHandler(result, nil)
                } catch{
                    print(error)
                    completionHandler(nil, .invalidData)
                }
                
            }
            
          
            
            //.resume() 재개
        }.resume()
        
    }
   
    
}
