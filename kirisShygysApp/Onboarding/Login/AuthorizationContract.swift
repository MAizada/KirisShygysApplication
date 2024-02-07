//
//  AuthorizationContract.swift
//  kirisShygysApp
//
//  Created by Aizada on 29.11.2023.
//

import Foundation
import UIKit

protocol AuthorizationViewProtocol: AnyObject {
    func getEmailTextFieldValue() -> String?
    func getPasswordTextFieldValue() -> String?
    func showEmptyFieldsError()
    func showErrorMessage(_ message: String)
    func showSuccessMessage(_ message: String)
}

protocol AuthorizationPresenterProtocol: AnyObject {
    func authorize()
}

protocol AuthorizationPresenterDelegate: AnyObject {
    func didAuthorizeSuccessfully(userImage: UIImage?)
    func didFailToAuthorize()
}
