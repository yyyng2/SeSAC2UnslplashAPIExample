//
//  MainView.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/28.
//

import UIKit

class MainView: BaseView {
    let vcStoryboardBaseButton: MainCustomButton = {
        let button = MainCustomButton ()
      
        button.setBackgroundColor(string: "StoryboardBaseVC", color: .white)
        
        return button
    }()
    
    let vcCodeBaseButton: MainCustomButton = {
        let button = MainCustomButton ()
        
        button.setBackgroundColor(string: "CodeBaseVC", color: .systemCyan)
        
        return button
    }()
    
    let mvcStoryboardBaseButton: MainCustomButton = {
        let button = MainCustomButton ()
      
        button.setBackgroundColor(string: "StoryboardBaseMVC", color: .white)
        
        return button
    }()
    
    let mvcCodeBaseButton: MainCustomButton = {
        let button = MainCustomButton ()
        
        button.setBackgroundColor(string: "CodeBaseMVC", color: .systemCyan)
        
        return button
    }()
    
    let mvvmButton: MainCustomButton = {
        let button = MainCustomButton ()
        button.setBackgroundColor(string: "MVVM", color: .magenta)
        return button
    }()
    
    let rxButton: MainCustomButton = {
        let button = MainCustomButton ()

        button.setBackgroundColor(string: "Rx", color: .systemMint)
        
        return button
    }()
    
    override func configure() {
        super.configure()
        backgroundColor = .white
        [vcStoryboardBaseButton, vcCodeBaseButton, mvcStoryboardBaseButton, mvcCodeBaseButton, mvvmButton, rxButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        NSLayoutConstraint.activate([
            vcStoryboardBaseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            vcStoryboardBaseButton.widthAnchor.constraint(equalToConstant: 300),
            vcStoryboardBaseButton.heightAnchor.constraint(equalToConstant: 50),
            vcStoryboardBaseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            vcCodeBaseButton.topAnchor.constraint(equalTo: vcStoryboardBaseButton.bottomAnchor),
            vcCodeBaseButton.widthAnchor.constraint(equalToConstant: 300),
            vcCodeBaseButton.heightAnchor.constraint(equalToConstant: 50),
            vcCodeBaseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mvcStoryboardBaseButton.topAnchor.constraint(equalTo: vcCodeBaseButton.bottomAnchor),
            mvcStoryboardBaseButton.widthAnchor.constraint(equalToConstant: 300),
            mvcStoryboardBaseButton.heightAnchor.constraint(equalToConstant: 50),
            mvcStoryboardBaseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mvcCodeBaseButton.topAnchor.constraint(equalTo: mvcStoryboardBaseButton.bottomAnchor),
            mvcCodeBaseButton.widthAnchor.constraint(equalToConstant: 300),
            mvcCodeBaseButton.heightAnchor.constraint(equalToConstant: 50),
            mvcCodeBaseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mvvmButton.topAnchor.constraint(equalTo: mvcCodeBaseButton.bottomAnchor),
            mvvmButton.widthAnchor.constraint(equalToConstant: 300),
            mvvmButton.heightAnchor.constraint(equalToConstant: 50),
            mvvmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rxButton.topAnchor.constraint(equalTo: mvvmButton.bottomAnchor),
            rxButton.widthAnchor.constraint(equalToConstant: 300),
            rxButton.heightAnchor.constraint(equalToConstant: 50),
            rxButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}
