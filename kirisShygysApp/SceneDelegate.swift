//
//  SceneDelegate.swift
//  kirisShygysApp
//
//  Created by Miras Iskakov on 19.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let send = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: send)
        let navigationController = UINavigationController(rootViewController: ViewController())
        self.window = window
        window.rootViewController = navigationController
        window.overrideUserInterfaceStyle = .light
        window.makeKeyAndVisible()
    }
}

