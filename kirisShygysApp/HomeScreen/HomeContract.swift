//
//  HomePresenterProtocol.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func reloadData(todayTransactions: [Transaction], weekTransactions: [Transaction], monthTransactions: [Transaction], yearTransactions: [Transaction])
    func updateTransactions(todayTransactions: [Transaction], weekTransactions: [Transaction], monthTransactions: [Transaction], yearTransactions: [Transaction])
    func updateBalance(with balance: Double)
    func updateIncome(amount: String)
    func updateExpense(amount: String)
}

protocol HomePresenterProtocol: AnyObject {
    func loadTransactionsFromFirebase()
    func separateTransactions()
    func filterTransactions(forPeriod period: Period)
    func addTransaction(_ transaction: Transaction)
    func updateBalance(transactions: [Transaction], currentBalance: Double, completion: @escaping (Double) -> Void)

}
