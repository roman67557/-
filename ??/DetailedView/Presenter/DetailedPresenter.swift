//
//  DetailedPresenter.swift
//  wq
//
//  Created by Роман on 03.02.2022.
//

import Foundation
import UIKit

protocol DetailedViewProtocol : AnyObject {
    func setImg(img: [Results]?, index: Int)
}

protocol DetailedViewPresenterProtocol: AnyObject {
    var index: Int? { get set }
    var secondIndex: Int? { get set }
    init(view: DetailedViewProtocol, img: [Results], router: RouterProtocol, index: Int)
    func setImg()
    func goBack(index: Int)
}

class DetailedViewPresenter: DetailedViewPresenterProtocol {
    
    var index: Int?
    var secondIndex: Int?
    var view: DetailedViewProtocol?
    var router: RouterProtocol?
    var img: [Results]

    required init(view: DetailedViewProtocol, img: [Results], router: RouterProtocol, index: Int) {
        self.view = view
        self.router = router
        self.img = img
        self.index = index
    }
    
    func setImg() {
        self.view?.setImg(img: img, index: index ?? Int())
    }
    
    func goBack(index: Int) {
        self.secondIndex = index
    }
    
}
