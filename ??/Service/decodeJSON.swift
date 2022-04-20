//
//  fetchImages.swift
//  ??
//
//  Created by Роман on 19.04.2022.
//

import Foundation

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
