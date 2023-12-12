//
//  ProfilePresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import Foundation
class ProfilePresenter: ProfilePresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    var view: ProfileViewProtocol?
}
