//
//  ExpenseViewProtocol.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import UIKit

protocol ExpenseViewProtocol: AnyObject {
    func didAddTransaction(amount: String, category: String, description: String, image: UIImage?, amountColorName: String)
    func dismissView()
}

protocol ExpensePresenterProtocol: AnyObject {
    func spentTransaction(amount: String, category: String, description: String) 
}
