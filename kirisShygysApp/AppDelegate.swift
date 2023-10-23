//
//  AppDelegate.swift
//  kirisShygysApp
//
//  Created by Miras Iskakov on 19.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
            window?.rootViewController = homeViewController
            window?.makeKeyAndVisible()
    
        return true
    }

}
