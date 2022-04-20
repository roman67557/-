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
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func fetchImages(searchTerm: String, completion: @escaping (APIResponse?) ->Void)
    func openCamera(view: UIViewController)
    func receivePhoto(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any])
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    var results: [Results]?
    var view: MainViewProtocol?
    var networkService: NetworkServiceProtocol
    var router: RouterProtocol?

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func openCamera(view: UIViewController) {
        router?.openCameraView(view: view)
    }
    
    func fetchImages(searchTerm: String, completion: @escaping (APIResponse?) ->Void) {
        networkService.request(searchTerm: searchTerm) { [weak self] data, error in
            if error != nil {
                print("ERROR!!!?!>>!??!LJSHSDJAFCI*$*$")
                completion(nil)
            }
            let decode = decodeJSON(type: APIResponse.self, from: data)
            completion(decode)
        }
    }
    
    func receivePhoto(view: UIViewController, picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]) {
        catchPhotos(view: view, picker: picker, info: info)
    }
    
}
