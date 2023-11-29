//
//  TransactionViewProtocol.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import Foundation

protocol TransactionViewProtocol: AnyObject {
    func reloadData(todayTransactions: [Transaction], yesterdayTransactions: [Transaction], previousTransactions: [Transaction])
    func updateRecentTransactions(_ transactions: [Transaction])
}

protocol TransactionPresenterProtocol: AnyObject {
    var view: TransactionViewProtocol? { get set }
    func loadTransactionsFromFirebase()
    func separateTransactions()
    func filterTransactions()
    func addTransaction(_ transaction: Transaction)
    func updateRecentTransactions(_ transactions: [Transaction])
}
