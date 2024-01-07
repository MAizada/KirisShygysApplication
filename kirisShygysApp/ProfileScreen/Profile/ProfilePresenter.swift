//
//  ProfilePresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import Foundation
import UIKit

class ProfilePresenter: ProfilePresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    weak var view: ProfileViewProtocol?
    
    //MARK: - Get Usaername
    
    internal func getUserName() {
        firebaseManager.getUsername { [weak self] username in
            guard let username = username else { return }
            self?.view?.showUserName(username)
        }
    }
    
    func confirmLogout() {
           FirebaseManager.shared.Logout { error in
               if let error = error {
                   print("Error signing out: \(error.localizedDescription)")
               } else {
                   print("Logout successful")
                   let onboardingViewController = OnboardingViewController()
                   onboardingViewController.navigationItem.hidesBackButton = true
                   UIApplication.shared.windows.first?.rootViewController = onboardingViewController
               }
           }
       }
   }
