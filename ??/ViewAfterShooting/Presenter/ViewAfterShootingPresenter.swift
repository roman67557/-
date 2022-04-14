//
//  ViewAfterShootingPresenter.swift
//  ??
//
//  Created by Роман on 30.03.2022.
//

import Foundation
import UIKit

protocol ViewAfterShootingProtocol {
    
}

protocol ViewAfterShootingPresenterProtocol {
    
    init(image: UIImage, view: ViewAfterShootingProtocol, router: RouterProtocol)

}

class ViewAfterShootingPresenter: ViewAfterShootingPresenterProtocol {
    
    var view: ViewAfterShootingProtocol?
    var router: RouterProtocol?
    var image: UIImage?
    
    required init(image: UIImage, view: ViewAfterShootingProtocol, router: RouterProtocol) {
        self.image = image
        self.view = view
        self.router = router
    }
}
