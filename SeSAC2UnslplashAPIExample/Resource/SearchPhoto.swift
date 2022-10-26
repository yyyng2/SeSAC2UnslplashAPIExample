//
//  SearchPhoto.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/26.
//

import Foundation

struct SearchPhoto: Codable, Hashable {
     
    let total, totalPages: Int
    let results: [SearchResult]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
