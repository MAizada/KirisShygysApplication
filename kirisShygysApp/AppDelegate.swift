//
//  AppDelegate.swift
//  kirisShygysApp
//
//  Created by Miras Iskakov on 19.08.2023.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { let homeViewController = HomeViewController()
        
        FirebaseApp.configure()
       let db = Firestore.firestore()        
    
        let onboardingViewController = OnboardingViewController()
        let navigationController = UINavigationController(rootViewController: onboardingViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
    
        return true
    }

}
