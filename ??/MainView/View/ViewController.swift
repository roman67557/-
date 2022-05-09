//
//  ViewController.swift
//  wq
//
//  Created by Роман on 19.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties.
    
    private var refresh = UIRefreshControl()
    private var myTableView = UITableView()
    var presenter: MainViewPresenterProtocol?
    private var myImageView = UIImageView()
    var results = [Results]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleView()
    
        self.view.backgroundColor = .yellow
        tabBarItem.title = " "
        rightBarItems()
        setUpTableView()
        photoFetch()
        configureRefreshControl()
    }
    
    //MARK: - Setup UI Elemenets
    private func setUpTableView() {
        
        myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(ViewControllerCell.self, forCellReuseIdentifier: ViewControllerCell.identifier)
        myTableView.delegate = self
        myTableView.dataSource = self
        view.addSubview(myTableView)
    }
    
    private func rightBarItems() {
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(switchToCamera(par:)))
        let chatButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(moveToChat(par:)))
        self.navigationItem.rightBarButtonItems = [chatButton, cameraButton]
        cameraButton.tintColor = .black
        chatButton.tintColor = .black
    }
    
    fileprivate func setTitleView() {
   
        let leftItem = UIBarButtonItem(title: "Instagram", style: .plain, target: self, action: #selector(moveToUp))
        guard let billaBong = UIFont(name: "Billabong", size: 33) else { return }
        leftItem.setTitleTextAttributes([NSAttributedString.Key.font : billaBong], for: .normal)
        leftItem.setTitleTextAttributes([NSAttributedString.Key.font : billaBong], for: .highlighted)
        leftItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftItem
    }
    
    //MARK: - Methods
    @objc func moveToUp() {
        
        myTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func switchToCamera(par: UIBarButtonItem) {
        
        presenter?.openCamera(view: self)
        
    }
    
    @objc func moveToChat(par: UIBarButtonItem) {
        
        let chatVC = ChatViewController()
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    private func photoFetch() {
        
        results = []
        presenter?.fetchImages(searchTerm: "Random") { [weak self] searchResult in
            guard let fetchedPhotos = searchResult else { return }
            self?.results = fetchedPhotos.results
            self?.myTableView.reloadData()
        }
    }
    
    private func configureRefreshControl() {
        
        myTableView.refreshControl = self.refresh
        myTableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

}

//MARK: - Extensions
extension ViewController: MainViewProtocol {
   
//    func succes() {
//        myTableView.reloadData()
//    }
//    
//    func failure(error: Error) {
//        print(error.localizedDescription)
//    }
    
    @objc func handleRefreshControl(sender: UIRefreshControl) {
        
        self.results.shuffle()
        myTableView.reloadData()
        sender.endRefreshing()
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let currentImage = results[indexPath.item]
        guard let imageHeight = currentImage.height else { return 0.0 }
        guard let imageWidth = currentImage.width else { return 0.0 }
        let widthRatio = CGFloat(imageWidth) / CGFloat(imageHeight)
        return tableView.frame.width / widthRatio
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: ViewControllerCell.identifier, for: indexPath) as? ViewControllerCell
        let photo = results[indexPath.item]
        cell?.results = photo
        return cell ?? UITableViewCell()
    }
    
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        presenter?.receivePhoto(view: self, picker: picker, info: info)
    }
    
}





