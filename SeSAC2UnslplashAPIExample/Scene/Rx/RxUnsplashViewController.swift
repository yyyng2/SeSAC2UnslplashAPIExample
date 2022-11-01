//
//  UnsplashViewController.swift
//  SeSAC2UnslplashAPIExample
//
//  Created by Y on 2022/10/26.
//

import UIKit

import Kingfisher
import RxSwift
import RxCocoa

class RxUnsplashViewController: BaseViewController {
    var mainView = RxUnsplashView()
    
    var viewModel = UnsplashViewModel()
    
    var disposeBag = DisposeBag()
    
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setCollectionView()
        configureDataSource()
        
        bindData() // 선 cell dataSource -> 후 bind. 안그러면 바인딩 중 dataSource.apply 때문에 fatalError.
    }
    
    private func setCollectionView() {
        mainView.collectionView.collectionViewLayout = createLayout()
        mainView.collectionView.delegate = self
    }
    
    func bindData() {
        
        let input = UnsplashViewModel.Input(searchText: mainView.searchBar.rx.text)
        
        let output = viewModel.transform(input: input)
        
        output.searchText
            .withUnretained(self)
            .subscribe { (vc, value) in
                vc.viewModel.requestSearchPhoto(query: value)
            }
            .disposed(by: disposeBag)
        
        
        // subscribe는 input/output어떻게 하나
        viewModel.photoList
            .withUnretained(self)
            .subscribe (onNext: { (vc, photo) in
                //initial
                var snapShot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
                snapShot.appendSections([0])
                snapShot.appendItems(photo.results)
                vc.dataSource.apply(snapShot)
            }, onError: { error in
                print("=========Error: \(error)")
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
            .disposed(by: disposeBag)
        
//        mainView.searchBar.rx.text.orEmpty
//            .debounce(.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .withUnretained(self)
//            .subscribe { (vc, value) in
//                vc.viewModel.requestSearchPhoto(query: value)
//            }
//            .disposed(by: disposeBag)
    }
    
    override func configure() {
        super.configure()
    
    }
    
}
extension RxUnsplashViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }

//        let alert = UIAlertController(title: item, message: "tapped!", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "okay", style: .default)
//        alert.addAction(ok)
//        present(alert, animated: true)
    }
}

//extension UnsplashViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//    }
//}

extension RxUnsplashViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
     
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SearchResult>(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)
                let data = try? Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
        
            }

//            content.secondaryText = "\(itemIdentifier.count)"

            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.strokeColor = .brown
            background.strokeWidth = 2
            cell.backgroundConfiguration = background
            
        })
        
        //numberofitemsInSection,cellforItemAt
        //collectionView.datasource = self 없어도됨
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        

    }
}
