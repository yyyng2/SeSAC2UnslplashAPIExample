//
//  MainViewController.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/28.
//

import UIKit

class MainViewController: BaseViewController {
    let mainView = MainView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
        
    }
    
    func setButton() {
        
        
        mainView.rxButton.addTarget(self, action: #selector(rxButtonTapped), for: .touchUpInside)
    }
    
    @objc func rxButtonTapped() {
        setView(RxUnsplashViewController())
    }
    
    func setView<T: UIViewController>(_ viewController: T) {
        let view = viewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
