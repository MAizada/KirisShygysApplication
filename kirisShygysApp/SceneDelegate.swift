//
//  SceneDelegate.swift
//  kirisShygysApp
//
//  Created by Miras Iskakov on 19.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var userDefault = UserDefaults.standard
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        
        if let imageData = UserDefaults.standard.data(forKey: "userAvatar"),
           let savedImage = UIImage(data: imageData) {
            let mainTabBarController = MainTabBarController(userImage: savedImage)
            setRootViewController(mainTabBarController)
        } else {
            let isLogin = userDefault.object(forKey: "isLogin") as? Bool ?? false
            
            if isLogin {
                let mainTabBarController = MainTabBarController(userImage: nil)
                setRootViewController(mainTabBarController)
            } else {
                let onboardingViewController = OnboardingViewController()
                setRootViewController(onboardingViewController)
            }
        }
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
    }
}
