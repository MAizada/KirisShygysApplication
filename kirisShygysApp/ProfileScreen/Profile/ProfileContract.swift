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

}

protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set }
    func logout(completion: @escaping (Result<(), Error>) -> ())
    func handleLogoutResult(result: Result<(), Error>)
}

protocol ConfirmLogoutViewDelegate: AnyObject {
    func confirmLogout()
   
}
