//
//  Router.swift
//  wq
//
//  Created by Роман on 29.01.2022.
//

import Foundation
import UIKit

protocol RouterMain {
    var tabBarController: UITabBarController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func moveToDetailedController(img: [Results]?, view: UIViewController, index: Int)
    func openCameraView(view: UIViewController)
}
    
    

class Router: RouterProtocol {
    
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UITabBarController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.tabBarController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let tabBarController = tabBarController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            guard let secondViewController = assemblyBuilder?.createSecondModule(router: self) else { return }
            guard let heroViewController = assemblyBuilder?.createThirdModule(router: self) else { return }
            guard let sixthViewController = assemblyBuilder?.createSixthModule(router: self) else { return }
            
            let fourthNC = UINavigationController(rootViewController: FifthViewController())
            
            let mainNavigationVontroller = UINavigationController(rootViewController: mainViewController)
            let secondNavigationController = UINavigationController(rootViewController: secondViewController)
            let sixthNavigationController = UINavigationController(rootViewController: sixthViewController)
            tabBarController.setViewControllers([mainNavigationVontroller, secondNavigationController, heroViewController, fourthNC, sixthNavigationController], animated: true)
            
            let imagesArray = [UIImage(named: "home"),
                               UIImage(named: "search"),
                               UIImage(named: "video"),
                               UIImage(named: "like"),
                               UIImage(named: "user")]
            
            let viewControllers = [0: mainNavigationVontroller, 1: secondNavigationController, 2: heroViewController, 3: fourthNC, 4: sixthNavigationController]
            for (index, VC) in (viewControllers) {
                VC.tabBarItem = UITabBarItem(title: " ", image: imagesArray[index], tag: index)
            }
        }
    }
    
    func moveToDetailedController(img: [Results]?, view: UIViewController, index: Int) {
        guard let img = img else { return }
        guard let detailedVC = assemblyBuilder?.createDetailedModule(img: img, router: self, index: index) else { return }
        view.navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func openCameraView(view: UIViewController) {
        let cameraView = UIImagePickerController()
        cameraView.sourceType = .camera
        cameraView.delegate = view as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        view.present(cameraView, animated: true)
    }
}
