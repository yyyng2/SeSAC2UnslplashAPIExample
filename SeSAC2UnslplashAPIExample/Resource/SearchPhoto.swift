//
//  SearchPhoto.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/26.
//

import Foundation

struct SearchPhoto: Codable, Hashable {
     
    var total, totalPages: Int
    var results: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct SearchResult: Codable, Hashable {
     
    var id: String
    var urls: Urls
    var likes: Int

    enum CodingKeys: String, CodingKey {
        case id
        case urls, likes
    }
}

struct Urls: Codable, Hashable {
    var raw, full, regular, small: String
    var thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
