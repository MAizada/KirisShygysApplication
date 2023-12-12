//
//  IncomeViewProtocol.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//
import UIKit

protocol IncomeViewProtocol: AnyObject {
    func didAddTransaction(amount: String, category: String, description: String, image: UIImage?, amountColorName: String)
    func dismissView()
}

protocol IncomePresenterProtocol: AnyObject {
    func earnedTransaction(amount: String, category: String, description: String) 
}

protocol UpdateTableDelegate: AnyObject {
    func updateTransactions()
}
