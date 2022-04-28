//
//  MainPresenter.swift
//  wq
//
//  Created by Роман on 26.01.2022.
//

import Foundation
import UIKit
protocol MainViewProtocol: AnyObject {
//    func succes()
//    func failure(error: Error)
    func handleRefreshControl(sender: UIRefreshControl)
}

protocol MainViewPresenterProtocol: AnyObject {
    var results: [Results]? { get set }
    init(view: MainViewProtocol, photoFetcher: FetchingPhotosFromInternetProtocol, router: RouterProtocol)
    func fetchImages(searchTerm: String, completion: @escaping (APIResponse?) ->Void)
    func openCamera(view: UIViewController)
    func receivePhoto(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any])
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    var results: [Results]?
    var view: MainViewProtocol?
    var photoFetcher: FetchingPhotosFromInternetProtocol
    var router: RouterProtocol?

    required init(view: MainViewProtocol, photoFetcher: FetchingPhotosFromInternetProtocol, router: RouterProtocol) {
        self.view = view
        self.photoFetcher = photoFetcher
        self.router = router
    }
    
    func openCamera(view: UIViewController) {
        router?.openCameraView(view: view)
    }
    
    func fetchImages(searchTerm: String, completion: @escaping (APIResponse?) ->Void) {
        photoFetcher.fetchPhoto(searchTerm: searchTerm, completion: completion)
    }
    
    func receivePhoto(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]) {
        catchPhotos(view: view, picker: picker, info: info)
    }
    
}
