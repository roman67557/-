//
//  ProfilePhotoViewController.swift
//  ??
//
//  Created by Роман on 28.02.2022.
//

import UIKit

class ProfilePhotoViewController: UIViewController, Animation {

    lazy var profilePhotoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.itemSize = .init(width: UIScreen.main.bounds.width - 1, height: UIScreen.main.bounds.height - 1)
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ImagePreviewFullViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    private var imgArray = [UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"), UIImage(named: "me"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        setupConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setupConstraints() {
        profilePhotoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profilePhotoCollectionView)
        profilePhotoCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        profilePhotoCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        profilePhotoCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        profilePhotoCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }

}


extension ProfilePhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagePreviewFullViewCell
        let imgView = cell.imgView

        imgView.image = self.imgArray[indexPath.row]
                return cell
    }

}



