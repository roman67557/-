//
//  fetchImages.swift
//  ??
//
//  Created by Роман on 19.04.2022.
//

import Foundation

protocol FetchingPhotosFromInternetProtocol {
    func fetchPhoto(searchTerm: String, completion: @escaping (APIResponse?) ->Void)
}

class FetchingPhotosFromInternet: FetchingPhotosFromInternetProtocol {
    
    let networkService = NetworkService()
    
    func fetchPhoto(searchTerm: String, completion: @escaping (APIResponse?) ->Void) {
        networkService.request(searchTerm: searchTerm) { [weak self] data, error in
            if error != nil {
                print("ERROR!!!?!>>!??!LJSHSDJAFCI*$*$")
                completion(nil)
            }
            let decode = self?.decodeJSON(type: APIResponse.self, from: data)
            completion(decode)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
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


