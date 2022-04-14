//
//  ImagePreviewFullViewCell.swift
//  wq
//
//  Created by Роман on 01.02.2022.
//

import UIKit

class ImagePreviewFullViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    var scrollImg = UIScrollView()
    var imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
            
        setupViews()
//        setupConstraints()
    }
    
    private func setupViews() {
        scrollImg = UIScrollView()
        scrollImg.delegate = self
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.frame = self.bounds
        scrollImg.flashScrollIndicators()
        scrollImg.isScrollEnabled = false

        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 4.0

        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)

        self.addSubview(scrollImg)

        imgView = UIImageView()
        imgView.frame = scrollImg.bounds
        imgView.center = scrollImg.center
        imgView.contentMode = .scaleAspectFit
        scrollImg.addSubview(imgView)
    }
    
//    private func setupConstraints() {
//        self.addSubview(scrollImg)
//        scrollImg.addSubview(imgView)
//
//        scrollImg.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        scrollImg.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        scrollImg.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        scrollImg.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//
//        imgView.topAnchor.constraint(equalTo: scrollImg.topAnchor).isActive = true
//        imgView.bottomAnchor.constraint(equalTo: scrollImg.bottomAnchor).isActive = true
//        imgView.leadingAnchor.constraint(equalTo: scrollImg.leadingAnchor).isActive = true
//        imgView.trailingAnchor.constraint(equalTo: scrollImg.trailingAnchor).isActive = true
//    }
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale , center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imgView.frame.size.height / scale
        zoomRect.size.width  = imgView.frame.size.width  / scale
        let newCenter = imgView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollImg.frame = self.bounds
        imgView.frame = self.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
        scrollImg.setZoomScale(1, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
