//
//  DetailedCollectionViewCell.swift
//  ??
//
//  Created by Роман on 04.02.2022.
//

import UIKit
import SDWebImage

class DetailedCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    static var identifier = "DetailedCell"
    var scrollImg: UIScrollView?
    var imgView: UIImageView?
    var result: Results? {
        didSet{
            let photoUrl = result?.urls.regular
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            imgView?.sd_setImage(with: url, completed: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        setupScroll()
        setupImageView()
        addSubViews()
    }
    
    private func addSubViews() {
        self.addSubview(scrollImg ?? UIScrollView())
        scrollImg?.addSubview(imgView ?? UIImageView())
//        imgView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupScroll() {
        scrollImg = UIScrollView()
        scrollImg?.delegate = self
        scrollImg?.alwaysBounceVertical = false
        scrollImg?.alwaysBounceHorizontal = false
        scrollImg?.showsVerticalScrollIndicator = true
        scrollImg?.frame = self.bounds
        scrollImg?.flashScrollIndicators()
        
        scrollImg?.minimumZoomScale = 1.0
        scrollImg?.maximumZoomScale = 4.0
        
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg?.addGestureRecognizer(doubleTapGest)
    }
    
    private func setupImageView() {
        imgView = UIImageView()
        imgView?.backgroundColor = .systemGray4
//        imgView?.translatesAutoresizingMaskIntoConstraints = false
        
//        return tableView.frame.width / widthRatio
        
//        imgView?.frame = CGRect(x: 0, y: 0, width: Int(imageViewWidth), height: scaledHeight)
        imgView?.contentMode = .scaleAspectFit
//        imgView?.center = scrollImg?.center ?? CGPoint()
       
    }
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        guard let scrollImg = scrollImg else { return }

        if (scrollImg.zoomScale > scrollImg.minimumZoomScale) {
            scrollImg.setZoomScale(scrollImg.minimumZoomScale, animated: true)
        } else {
            scrollImg.setZoomScale(scrollImg.maximumZoomScale, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imgView?.frame.size.height ?? CGFloat(0) / scale
        zoomRect.size.width  = imgView?.frame.size.width ?? CGFloat(0)  / scale
        let newCenter = imgView?.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter?.x ?? CGFloat(0) - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter?.y ?? CGFloat(0) - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    @objc(viewForZoomingInScrollView:) func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageWidth = result?.width else { return }
        guard let imageHeight = result?.height else { return }
        let imageViewWidth = self.frame.width

        let widthRatio = CGFloat(imageWidth) / CGFloat(imageHeight)
        let scaledHeight = imageViewWidth / widthRatio
        
        scrollImg?.frame = self.bounds
        imgView?.frame = CGRect(x: 0, y: 0, width: Int(imageViewWidth), height: Int(scaledHeight))
        imgView?.center = scrollImg?.center ?? CGPoint()
        
        
//        imgView?.centerYAnchor.constraint(equalTo: scrollImg?.centerYAnchor ?? NSLayoutYAxisAnchor()).isActive = true
//        imgView?.leadingAnchor.constraint(equalTo: scrollImg?.leadingAnchor ?? NSLayoutXAxisAnchor()).isActive = true
//        imgView?.trailingAnchor.constraint(equalTo: scrollImg?.trailingAnchor ?? NSLayoutXAxisAnchor()).isActive = true
//        imgView?.heightAnchor.constraint(equalToConstant: scaledHeight).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView?.image = nil
        scrollImg?.setZoomScale(1, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
