//
//  ProfilePresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import Foundation
import UIKit

final class ProfilePresenter: ProfilePresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    weak var view: ProfileViewProtocol?
    
    func logout(completion: @escaping (Result<(), Error>) -> ()) {
        print("Trying to logout...")
        firebaseManager.logout { result in
            completion(result)
        }
    }
    
    func handleLogoutResult(result: Result<(), Error>) {
        switch result {
        case .success:
            print("Logout successful")
            view?.navigateToOnboarding()
        case .failure(let error):
            print("Logout failed with error: \(error.localizedDescription)")
        }
    }
    
    func updateProfileInfo(name: String, avatar: UIImage?) {
        view?.updateProfileInfo(name: name, avatar: avatar)
    }
}
