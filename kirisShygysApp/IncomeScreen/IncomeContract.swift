//
//  IncomeViewProtocol.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//
import UIKit

protocol IncomeViewProtocol: AnyObject {
    func didAddTransaction(amount: String, category: String, description: String, image: UIImage?, amountColorName: String)
}

protocol IncomePresenterProtocol: AnyObject {
    
}

protocol UpdateTableDelegate: AnyObject {
    func updateTransactions()
}
