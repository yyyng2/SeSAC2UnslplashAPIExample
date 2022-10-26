//
//  BaseView.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/26.
//

import UIKit

import SnapKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
    
    func setConstraints() {
        
    }
}
