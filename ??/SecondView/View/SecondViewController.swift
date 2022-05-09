//
//  SecondViewController.swift
//  wq
//
//  Created by Роман on 19.11.2021.
//

import UIKit
import SDWebImage

class SecondViewController: UICollectionViewController {
    
    //MARK: - Properties
    private let refresh = UIRefreshControl()
    private var searchController = UISearchController()
    public var presenter: SecondViewPresenterProtocol?
    public var results = [Results]()
    public var router: RouterProtocol?
    public var assembly: AssemblyModelBuilder?
    public var index: Int?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        navigationItem.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        navigationController?.delegate = self
        
        collectionViewCreation()
        fetchDeafaultPhoto()
        configureRefreshControl()
    }
    
    //MARK: - Setup UI Elements
    
    func collectionViewCreation() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width/3)-1, height: (view.frame.width/3)-1)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(SearchControllerCollectionViewCell.self, forCellWithReuseIdentifier: SearchControllerCollectionViewCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        view.addSubview(collectionView ?? UICollectionView())
        
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: - Methods
    func fetchDeafaultPhoto() {
        if searchController.searchBar.text?.isEmpty == true {
            results = []
            self.presenter?.fetchImages(searchTerm: "Random") { [weak self] searchResult in
                guard let fetchedPhotos = searchResult else { return }
                self?.results = fetchedPhotos.results.shuffled()
                self?.collectionView?.reloadData()
            }
        }
    }
    
    private func configureRefreshControl() {
        collectionView?.refreshControl = self.refresh
        collectionView?.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl(sender: UIRefreshControl) {
        self.results.shuffle()
        self.collectionView?.reloadData()
        sender.endRefreshing()
     }
    
}

//MARK: - Extensions

extension SecondViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchControllerCollectionViewCell.identifier, for: indexPath) as? SearchControllerCollectionViewCell else {
            return UICollectionViewCell()
        }
        let photo = results[indexPath.item]
        itemCell.results = photo
        return itemCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let img = self.results
        let index = indexPath.item
        self.index = indexPath.item
        presenter?.setupIMG(img: img, view: self, index: index)
    }
    
}

extension SecondViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            results = []
            self.presenter?.fetchImages(searchTerm: text) { [weak self] searchResult in
                guard let fetchedPhotos = searchResult else { return }
                self?.results = fetchedPhotos.results.shuffled()
                self?.collectionView?.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    
}
    
extension SecondViewController: SecondViewProtocol {
    
    func succes() {
        self.collectionView?.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
}

extension SecondViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
            
        case .push:
            guard let selectedLayout = self.collectionView.layoutAttributesForItem(at: IndexPath(item: index ?? 0, section: 0)) else { return nil }
            let selectedCellFrame = collectionView.convert(selectedLayout.frame, to: collectionView.superview)
            return Present(pageIndex: index ?? 0, originFrame: selectedCellFrame, rounding: 0)
            
        case .pop:
            guard let selectedLayout = self.collectionView.layoutAttributesForItem(at: IndexPath(item: index ?? 0, section: 0)) else { return nil }
            let returningCellFrame = collectionView.convert(selectedLayout.frame, to: collectionView.superview)
            return Dismiss(pageIndex: index ?? 0, finalFrame: returningCellFrame)
        default:
            return nil
        }
    }
    
}
    




