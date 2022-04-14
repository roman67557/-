//
//  MainPresenter.swift
//  wq
//
//  Created by Роман on 26.01.2022.
//

import Foundation
import UIKit
protocol MainViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
    func handleRefreshControl(sender: UIRefreshControl)
}

protocol MainViewPresenterProtocol: AnyObject {
    var results: [Results]? { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func fetchImages(searchTerm: String, completion: @escaping (APIResponse?) ->Void)
    func openCamera(view: UIViewController)
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
            let decode = self?.decodeJSON(type: APIResponse.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let JSONError {
            print("ERROR @(!#*!*$JDWQJSDSAMC<SAC>CXX>", JSONError)
            return nil
        }
    }
    
}
