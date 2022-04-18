//
//  SixthViewController.swift
//  wq
//
//  Created by Роман on 23.11.2021.
//

import UIKit

protocol Animation: AnyObject {
    
}

class SixthViewController: UIViewController, Animation {
    
    var presenter: SixthViewPresenterProtocol?
    var myPhotoImageView = UIImageView()
    private var myPhotoImage = UIImage()
    lazy var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width/3)-1, height: (view.frame.width/3)-1)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        navigationItem.title = "user"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.delegate = self
        shootedImages = DatabaseHandler.shared.retrieveData()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    
    func setup() {
        rightBarItem()
        createProfileImageView()
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        [myPhotoImageView,
        collectionView].forEach { elem in
            view.addSubview(elem)
            elem.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func rightBarItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(pushOptionViewController))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func createProfileImageView() {
        
        guard let myProfilePhotoImage = UIImage(named: "me") else {
            let error = "Error! Add a profile photo!"
            print(error)
            return
        }
        
        myPhotoImageView = UIImageView(image: myProfilePhotoImage)
        myPhotoImageView.backgroundColor = UIColor.systemGray5
        myPhotoImageView.layer.cornerRadius = 50  //myPhotoImageView.bounds.height / 2
        myPhotoImageView.clipsToBounds = true
        myPhotoImageView.isUserInteractionEnabled = true
        myPhotoImageView.contentMode = .scaleAspectFill
        
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(moveToProfilePhoto))
        myPhotoImageView.addGestureRecognizer(gesture)
    }
    
    private func setupConstraints() {
        myPhotoImageView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        myPhotoImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        myPhotoImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        myPhotoImageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: self.myPhotoImageView.bottomAnchor, constant: self.view.frame.height / 20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is Animation && toVC is Animation {
            switch operation {
            case .push:
                return TransitionAnimator(presentationStartButton: myPhotoImageView,
                                          animationDuration: 0.5,
                                          animationType: .present)
            case .pop:
                return TransitionAnimator(presentationStartButton: myPhotoImageView,
                                          animationDuration: 0.5,
                                          animationType: .dismiss)
            default:
                return nil
            }
        }
        return nil
    }
    
}

extension SixthViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shootedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .systemGray4
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.frame = cell.bounds
        guard let data = shootedImages[indexPath.row].img else { return UICollectionViewCell() }
        imgView.image = UIImage(data: data)
        cell.addSubview(imgView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
}

extension SixthViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        presenter?.receivePhoto(view: self, picker: picker, info: info)
    }
    
}

extension SixthViewController: SixthViewProtocol {
    
    @objc func moveToProfilePhoto(_ sender: Any) {
        presenter?.moveToProfilePhoto(view: self)
    }
    
    @objc func pushOptionViewController() {
        presenter?.openCamera(view: self)
    }
    
}




