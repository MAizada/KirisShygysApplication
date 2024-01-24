//
//  EditPresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.01.2024.
//

import Foundation
import UIKit

class EditPresenter: EditPresenterProtocol {
    
    weak var view: EditViewProtocol?
    var profilePresenter: ProfilePresenterProtocol?
    
    init(view: EditViewProtocol, profilePresenter: ProfilePresenterProtocol?) {
        self.view = view
        self.profilePresenter = profilePresenter
    }
    
    func saveChanges(name: String, avatar: UIImage?) {
        view?.updateProfileInfo(name: name, avatar: avatar)
    }
}
