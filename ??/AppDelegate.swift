//
//  AppDelegate.swift
//  ??
//
//  Created by Роман on 03.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //MARK: Custom Font
//        UIFont.familyNames.forEach({ name in
//
//            for font_name in UIFont.fontNames(forFamilyName: name) {
//                print("\n\(font_name)")
//            }
//
//        })
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let tabBarController = UITabBarController()
        let assemblyBuilder = AssemblyModelBuilder()
        let router = Router(navigationController: tabBarController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

}

