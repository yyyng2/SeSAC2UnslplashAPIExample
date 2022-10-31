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
        mainView.vcStoryboardBaseButton.addTarget(self, action: #selector(vcStoryboardButtonTapped), for: .touchUpInside)
        
        mainView.rxButton.addTarget(self, action: #selector(rxButtonTapped), for: .touchUpInside)
    }
    
    @objc func vcStoryboardButtonTapped() {
        let storyBoard = UIStoryboard(name: "StoryboardBaseVC", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "StoryboardBaseVCViewController") as? StoryboardBaseVCViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func rxButtonTapped() {
        setView(RxUnsplashViewController())
    }
    
    func setView<T: UIViewController>(_ viewController: T) {
        let view = viewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
