//
//  RegistrationContract.swift
//  kirisShygysApp
//
//  Created by Aizada on 29.11.2023.
//

import Foundation

protocol RegistrationViewProtocol: AnyObject {
    func getEmailTextFieldValue() -> String?
    func getPasswordTextFieldValue() -> String?
    func showEmptyFieldsError()
    func showErrorMessage(_ message: String)
    func showSuccessMessage(_ message: String)
}

protocol RegistrationPresenterProtocol: AnyObject {
    func signUp()
}
