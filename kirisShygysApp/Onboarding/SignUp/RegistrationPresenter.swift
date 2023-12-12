//
//  Registratio.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.11.2023.
//

import UIKit
import Firebase

final class RegistrationPresenter: RegistrationPresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    weak var view: RegistrationViewProtocol?
    
    func signUp() {
        guard let email = view?.getEmailTextFieldValue()?.lowercased(),
              let password = view?.getPasswordTextFieldValue(),
              !email.isEmpty, !password.isEmpty else {
            view?.showEmptyFieldsError()
            return
        }
        
        firebaseManager.createNewUser(LoginField(email: email, password: password)) { [weak self] code in
            switch code.code {
            case 0:
                self?.view?.showErrorMessage("Please enter your email and password")
                
            case 1:
                self?.view?.showSuccessMessage("Congratulations! You have registered")
                
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                self?.view?.showErrorMessage("The email address is already in use by another account")
                
            case AuthErrorCode.invalidEmail.rawValue:
                self?.view?.showErrorMessage("Invalid email address")
                
            case AuthErrorCode.weakPassword.rawValue:
                self?.view?.showErrorMessage("Password is too weak")
                
            default:
                self?.view?.showErrorMessage("Unknown error")
            }
        }
    }
}
