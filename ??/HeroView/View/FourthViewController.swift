//
//  FourthViewController.swift
//  wq
//
//  Created by Роман on 23.11.2021.
//

import AVFoundation
import UIKit
import CoreFoundation

class FourthViewController: UIImagePickerController {
    
    var presenter: HeroViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension FourthViewController: HeroViewProtocol {
    
    func tabBarButtonDidTap() {
        
    }
    
}

