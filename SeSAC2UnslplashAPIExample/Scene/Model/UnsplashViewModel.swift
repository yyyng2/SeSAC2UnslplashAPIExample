//
//  UnsplashViewModel.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/26.
//

import Foundation

import RxSwift
import RxCocoa

enum SearchError: Error {
    case noPhoto
    case ServerError
}

class UnsplashViewModel {
    
    var photoList = PublishSubject<SearchPhoto>()
    
    //Relay는 accept가능 error처리 불가능
    // var photoList = PublishRelay<SearchPhoto>()
    
    func requestSearchPhoto(query: String) {
        APIService.searchPhoto(query: query) { [weak self] photo, statusCode, error in
            
            guard let statusCode = statusCode, statusCode == 200 else {
                self?.photoList.onError(SearchError.ServerError)
                return
            }
            guard let photo = photo else {
                self?.photoList.onError(SearchError.noPhoto)
                return
            }
            
            self?.photoList.onNext(photo)
        }
    }
}
