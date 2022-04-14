//
//  ViewControllerCellTableViewCell.swift
//  wq
//
//  Created by Роман on 14.01.2022.
//

import UIKit
import SDWebImage

class ViewControllerCell: UITableViewCell {

    static var identifier = "ViewControllerCell"
    var cellImageView = UIImageView()
    var img: UIImage?
    
    var results: Results? {
        didSet {
            let photoUrl = results?.urls.regular
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            cellImageView.sd_setImage(with: url, completed: nil)
            img?.sd_imageData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupImageView()
        setImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageView() {
        cellImageView.backgroundColor = .systemGray5
        self.addSubview(cellImageView)
    }
    
    func setImageViewConstraints() {
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        cellImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cellImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        cellImageView.widthAnchor.constraint(equalToConstant: self.frame.size.width).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView.image = nil
    }
    
}
