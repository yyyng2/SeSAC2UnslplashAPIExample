//
//  StoryboardBaseVCViewController.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/28.
//

import UIKit

final class StoryboardBaseVCViewController: UIViewController {

    var photoList: [String] = []
    
    var convertPhoto: [Any] = []
    
    var timer: Timer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        searchBar.delegate = self
    }

}

extension StoryboardBaseVCViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryboardVCCollectionViewCell().description, for: indexPath) as? StoryboardVCCollectionViewCell else { return UICollectionViewCell() }
        
//        let url = URL(string: photoList[indexPath.row])
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url!) {
//                data.forEach {
//                    self?.convertPhoto.append($0)
//                }
//                if let image = UIImage(data: self!.convertPhoto[indexPath.row] as! Data) {
//                    DispatchQueue.main.async {
//                        cell.imageView.image = image
//                    }
//                }
//            }
//        }

        if let url = URL(string: photoList[indexPath.row]) {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents {
                    cell.imageView.image = UIImage(data: imageData)
                    collectionView.reloadData()
                }
            }
        }

       
        
        return cell
    }
}

extension StoryboardBaseVCViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StoryboardBaseVCViewController.searchImage), userInfo: searchText, repeats: false)
    }
    
    @objc func searchImage() {
        guard let text = searchBar.text else { return }
        UnsplashURLSessionAPIManager.searchPhoto(query: text) { photo, error in
            guard let data = photo else { return }
            data.results.forEach {
                self.photoList.append($0.urls.thumb)
            }
            print(self.photoList)
            self.collectionView.reloadData()
        }
    }
}
