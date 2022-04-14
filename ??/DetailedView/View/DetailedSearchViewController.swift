//
//  DetailedSearchViewController.swift
//  wq
//
//  Created by Роман on 02.01.2022.
//

import UIKit
import SDWebImage

class DetailedSearchViewController: UIViewController, UIScrollViewDelegate {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.itemSize = .init(width: view.frame.width, height: view.frame.height)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(DetailedCollectionViewCell.self, forCellWithReuseIdentifier: DetailedCollectionViewCell.identifier)
        return collectionView
    }()
    var presenter: DetailedViewPresenterProtocol?
    var closeButton = UIButton()
    var results = [Results]()
    var index: Int?
    var isSwipeToDismissEnabled = true
    public var backgroundColor: UIColor {
        get {
            return view.backgroundColor!
        }
        set(newBackgroundColor) {
            view.backgroundColor = newBackgroundColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .white
        
        presenter?.setImg()
        setup()
        scrollToSelectedImage()
        setupGestureRecognizers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setup() {
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        [collectionView].forEach { elem in
            view.addSubview(elem)
            elem.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func addConstraints() {
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    private func scrollToSelectedImage() {
        self.collectionView.layoutIfNeeded()
        self.collectionView.scrollToItem(at: IndexPath(item: index ?? 0, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    private func setupGestureRecognizers() {
        
        let panGesture = PanDirectionGestureRecognizer(direction: PanDirection.vertical, target: self, action: #selector(wasDragged(_:)))
        collectionView.addGestureRecognizer(panGesture)
        collectionView.isUserInteractionEnabled = true
    }
    
    @objc private func wasDragged(_ gesture: PanDirectionGestureRecognizer) {
        
        guard let image = gesture.view, isSwipeToDismissEnabled else { return }
        
        let translation = gesture.translation(in: self.view)
        image.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY + translation.y)
        
        let yFromCenter = image.center.y - self.view.bounds.midY
        
//        let alpha = 1 - abs(yFromCenter / self.view.bounds.midY)
//        self.view.backgroundColor = backgroundColor.withAlphaComponent(alpha)
        
        if gesture.state == UIGestureRecognizer.State.ended {
            
            var swipeDistance: CGFloat = 0
            let swipeBuffer: CGFloat = 50
            var animateImageAway = false
            
            if yFromCenter > -swipeBuffer && yFromCenter < swipeBuffer {
                // reset everything
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.backgroundColor = self.backgroundColor.withAlphaComponent(0)
                    image.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
                })
            } else if yFromCenter < -swipeBuffer {
                swipeDistance = 0
                animateImageAway = true
            } else {
                swipeDistance = self.view.bounds.height
                animateImageAway = true
            }
            
            if animateImageAway {
                if self.modalPresentationStyle == .custom {
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                
                UIView.animate(withDuration: 0.35, animations: {
//                    self.view.alpha = 0
                    image.center = CGPoint(x: self.view.bounds.midX, y: swipeDistance)
                }, completion: { (complete) in
                    self.navigationController?.popViewController(animated: true)
                })
            }
            
        }
    }
    
}
    


extension DetailedSearchViewController: DetailedViewProtocol {
    
    func setImg(img: [Results]?, index: Int) {
        self.results = img ?? [Results]()
        self.index = index
    }
    
}

extension DetailedSearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedCollectionViewCell.identifier, for: indexPath) as! DetailedCollectionViewCell
        
        let photo = results[indexPath.item]
            cell.result = photo
            return cell
    }
    
}

