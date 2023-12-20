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
    func updateChartView(with incomeTransactions: [Transaction], expenseTransactions: [Transaction])
}

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var incomeTransactions: [Transaction] { get }
    var expenseTransactions: [Transaction] { get }
    
    func loadTransactionsFromFirebase()
    func separateTransactions()
    func filterTransactions(forPeriod period: Period)
    func addTransaction(_ transaction: Transaction)
    func updateBalance(transactions: [Transaction], currentBalance: Double, completion: @escaping (Double) -> Void)
    func updateTransactionsAndCharts(todayTransactions: [Transaction], weekTransactions: [Transaction], monthTransactions: [Transaction], yearTransactions: [Transaction], incomeTransactions: [Transaction], expenseTransactions: [Transaction], in chartView: TransactionsChartView)
}
