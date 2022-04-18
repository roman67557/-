//
//  CatchPhotos.swift
//  ??
//
//  Created by Роман on 04.04.2022.
//

import Foundation
import UIKit

//var shootedImages = ShootedImages.shared
var shootedImages = [ShooterdImages]()

func catchPhotos(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]) {
    if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        
        DatabaseHandler.shared.saveImage(img: pickedImage)
        shootedImages = DatabaseHandler.shared.retrieveData()
    } else { return }
    picker.dismiss(animated: true)
}
