//
//  Authorization.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.11.2023.
//

import Foundation

class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    weak var view: AuthorizationViewProtocol?
    weak var delegate: AuthorizationPresenterDelegate?
    var checkField = CheckField.shared
    var userDefault = UserDefaults.standard
    
    func authorize() {
        guard let email = view?.getEmailTextFieldValue(),
              let password = view?.getPasswordTextFieldValue(),
              !email.isEmpty, !password.isEmpty else {
            view?.showEmptyFieldsError()
            return
        }
        
        if checkField.isValidEmail(email: email) {
            let authData = LoginField(email: email, password: password)
            
            firebaseManager.authInApp(authData) { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case .success:
                    self.userDefault.set(true, forKey: "isLogin")
                    self.delegate?.didAuthorizeSuccessfully()
                case .noVerify, .error:
                    self.delegate?.didFailToAuthorize()
                    self.view?.showErrorMessage("Failed to authorize")
                }
            }
        } else {
            self.showErrorAlert(message: "Check the entered data")
        }
    }
    private func showErrorAlert(message: String) {
            self.view?.showErrorMessage(message)
        }
}
