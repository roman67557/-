//
//  FourthViewController.swift
//  wq
//
//  Created by Роман on 23.11.2021.
//

import AVFoundation
import UIKit
import CoreFoundation

class FourthViewController: UIViewController {
    
    var presenter: HeroViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sourceType = .camera
        self.delegate = self
    }

}

extension FourthViewController: HeroViewProtocol {
    
    func tabBarButtonDidTap() {
        
    }
    
}

extension FourthViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        presenter?.receivePhoto(view: self, picker: picker, info: info)
    }
    
}

