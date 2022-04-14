//
//  Model for making photos.swift
//  ??
//
//  Created by Роман on 16.03.2022.
//

import Foundation
import UIKit

struct ShootedImages {

    static var shared = ShootedImages()
    var imgs = [UIImage]()
    
    mutating func savePhoto(data: UIImage?) {
        imgs.append(data ?? UIImage())
    }
    
}
