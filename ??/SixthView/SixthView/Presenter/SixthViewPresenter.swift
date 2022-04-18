//
//  SixthViewPresenter.swift
//  ??
//
//  Created by Роман on 11.04.2022.
//

import Foundation
import UIKit

protocol SixthViewProtocol {
    func moveToProfilePhoto(_ sender: Any)
    func pushOptionViewController()
}

protocol SixthViewPresenterProtocol {
    init(view: SixthViewProtocol, router: RouterProtocol)
    func moveToProfilePhoto(view: UIViewController)
    func openCamera(view: UIViewController)
    func receivePhoto(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any])
}

class SixthViewPresenter: SixthViewPresenterProtocol {
    
    var view: SixthViewProtocol?
    var router: RouterProtocol?
    
    required init(view: SixthViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func moveToProfilePhoto(view: UIViewController) {
        let profilePhotoVC = ProfilePhotoViewController()
        view.navigationController?.pushViewController(profilePhotoVC, animated: true)
    }
    
    func openCamera(view: UIViewController) {
        router?.openCameraView(view: view)
    }
    
    func receivePhoto(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]) {
        catchPhotos(view: view, picker: picker, info: info)
    }
    
}
