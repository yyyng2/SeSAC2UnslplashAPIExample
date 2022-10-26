//
//  UnsplashView.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/26.
//

import UIKit

class UnsplashView: BaseView {

    let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())

        return collectionView
    }()
    
    override func configure() {
        super.configure()
        [collectionView, searchBar].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
    
}
