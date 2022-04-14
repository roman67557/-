//
//  CatchPhotos.swift
//  ??
//
//  Created by Роман on 04.04.2022.
//

import Foundation
import UIKit

var shootedImages = ShootedImages.shared

func catchPhotos(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]) -> UIImage {
    guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return UIImage() }
    picker.dismiss(animated: true)
    shootedImages.savePhoto(data: pickedImage)
    return pickedImage
}
