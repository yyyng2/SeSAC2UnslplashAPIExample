//
//  MainCustomButtom.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/28.
//

import UIKit

class MainCustomButton: UIButton {
    var config = UIButton.Configuration.plain()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        config.baseForegroundColor = .black
        configuration = config
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setBackgroundColor(string: String, color: UIColor) {
        var titleAttr = AttributedString.init(string)
            titleAttr.font = .systemFont(ofSize: 26.0, weight: .heavy)
        
        config.attributedTitle = titleAttr
        
        config.baseBackgroundColor = color
        
        configuration = config
    }
}
