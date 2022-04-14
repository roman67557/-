//
//  SixthViewPresenter.swift
//  ??
//
//  Created by Роман on 11.04.2022.
//

import Foundation

protocol SixthViewProtocol {
    
}

protocol SixthViewPresenterProtocol {
    init(view: SixthViewProtocol, router: RouterProtocol)
}

class SixthViewPresenter: SixthViewPresenterProtocol {
    
    var view: SixthViewProtocol?
    var router: RouterProtocol?
    
    required init(view: SixthViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
