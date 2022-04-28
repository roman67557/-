//
//  HeroViewPresenter.swift
//  ??
//
//  Created by Роман on 13.03.2022.
//

import Foundation
import UIKit

protocol HeroViewProtocol {
    func tabBarButtonDidTap()
}

protocol HeroViewPresenterProtocol {
    init(view: HeroViewProtocol, router: RouterProtocol)
    func didTap(view: UIViewController)
    func receivePhoto(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any])
}

class HeroViewPresenter: HeroViewPresenterProtocol {
    
    let view: HeroViewProtocol?
    let router: RouterProtocol?
    
    required init(view: HeroViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func didTap(view: UIViewController) {
        router?.openCameraView(view: view)
    }
    
    func receivePhoto(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]) {
        catchPhotos(view: view, picker: picker, info: info)
    }
    
}
