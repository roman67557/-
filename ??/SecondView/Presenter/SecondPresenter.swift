//
//  Presenter.swift
//  wq
//
//  Created by Роман on 13.01.2022.
//

import Foundation
import UIKit

//MARK: - Protocols
protocol SecondViewProtocol: AnyObject {
    
    func succes()
    func failure(error: Error)
    
}

protocol SecondViewPresenterProtocol: AnyObject {
    
    init(view: SecondViewProtocol, photoFetcher: FetchingPhotosFromInternetProtocol, router: RouterProtocol)
    func fetchImages(searchTerm: String, completion: @escaping (APIResponse?) -> Void)
    var results: [Results]? { get set }
    func setupIMG(img: [Results]?, view: UIViewController, index: Int)
}

//MARK: - Presenter
class SecondPresenter: SecondViewPresenterProtocol {
    
    var results: [Results]?
    weak var view: SecondViewProtocol?
    let photoFetcher: FetchingPhotosFromInternetProtocol
    var router: RouterProtocol?
    
    required init(view: SecondViewProtocol, photoFetcher: FetchingPhotosFromInternetProtocol, router: RouterProtocol) {
        self.view = view
        self.photoFetcher = photoFetcher
        self.router = router
    }
    
    func fetchImages(searchTerm: String, completion: @escaping (APIResponse?) ->Void) {
        photoFetcher.fetchPhoto(searchTerm: searchTerm, completion: completion)
    }
    
    func setupIMG(img: [Results]?, view: UIViewController, index: Int) {
        router?.moveToDetailedController(img: img, view: view, index: index)
    }
    
}


