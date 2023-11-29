//
//  BudgetPresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import Foundation

class BudgetPresenter: BudgetPresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    var view: BudgetViewProtocol?
}
