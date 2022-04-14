//
//  SearchControllerCollectionViewCell.swift
//  wq
//
//  Created by Роман on 02.01.2022.
//

import UIKit
import SDWebImage

class SearchControllerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchControllerCollectionViewCell"
    
    var results: Results? {
        didSet {
            let photoUrl = results?.urls.thumb
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            searchPageImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    var searchPageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(searchPageImageView)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        searchPageImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        searchPageImageView.image = nil
    }
    
}
    
