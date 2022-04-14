//
//  NetworkService.swift
//  wq
//
//  Created by Роман on 13.01.2022.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        let params = self.prepareParams(searchTerm: searchTerm)
        let url = self.url(params: params)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = setDataTask(from: request, completion: completion)
        task.resume() 
    }
    
    private func prepareHeader() -> [String: String]? {
        var header = [String: String]()
        header["Authorization"] = "Client-ID B6t55eM4dZgKE92XOx4-kY_dXLeUjx1mdqYUHjdjKfY"
        return header
    }
    
    private func prepareParams(searchTerm: String?) -> [String: String] {
        var params = [String: String]()
        params["query"] = searchTerm
        params["page"] = String(1)
        params["per_page"] = String(31)
        return params
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        guard let componetsUrlUnwrap = components.url else { return URL(fileURLWithPath: " ") }
        return componetsUrlUnwrap
    }
    
    private func setDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            print(Thread.current)
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
}



