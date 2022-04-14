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
    
    init(view: SecondViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func fetchImages(searchTerm: String, completion: @escaping (APIResponse?) -> Void)
    var results: [Results]? { get set }
    func setupIMG(img: [Results]?, view: UIViewController, index: Int)
}

//MARK: - Presenter
class SecondPresenter: SecondViewPresenterProtocol {
    
    var results: [Results]?
    weak var view: SecondViewProtocol?
    let networkService: NetworkServiceProtocol
    var router: RouterProtocol?
    
    required init(view: SecondViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
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
    
    func setupIMG(img: [Results]?, view: UIViewController, index: Int) {
        router?.moveToDetailedController(img: img, view: view, index: index)
    }
    
}


