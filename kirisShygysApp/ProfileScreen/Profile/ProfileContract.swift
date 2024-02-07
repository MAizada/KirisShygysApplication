//
//  ProfileViewProtocol.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import Foundation
import UIKit

protocol ProfileViewProtocol: AnyObject {
    func showLogoutConfirmation()
    func navigateToOnboarding()
    func updateProfileInfo(name: String, avatar: UIImage?)
}

protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set }
    func logout(completion: @escaping (Result<(), Error>) -> ())
    func handleLogoutResult(result: Result<(), Error>)
    func updateProfileInfo(name: String, avatar: UIImage?)
}

protocol ConfirmLogoutViewDelegate: AnyObject {
    func confirmLogout()
   
}
