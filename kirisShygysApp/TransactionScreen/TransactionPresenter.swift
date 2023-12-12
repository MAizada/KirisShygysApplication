//
//  TransactionPresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 10.11.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class TransactionPresenter: TransactionPresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    weak var view: TransactionViewProtocol?
    var allTransactions: [Transaction] = []
    var todayTransactions: [Transaction] = []
    var yesterdayTransactions: [Transaction] = []
    var previousTransactions: [Transaction] = []
    
    func loadTransactionsFromFirebase() {
        firebaseManager.loadTransactions { [weak self] transactions in
            self?.allTransactions = transactions
            self?.separateTransactions()
            self?.view?.reloadData(
                todayTransactions: self?.todayTransactions ?? [],
                yesterdayTransactions: self?.yesterdayTransactions ?? [],
                previousTransactions: self?.previousTransactions ?? []
            )
        }
    }
    
    func separateTransactions() {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        
        todayTransactions = []
        yesterdayTransactions = []
        previousTransactions = []
        
        for transaction in allTransactions {
            let transactionMonth = calendar.component(.month, from: transaction.date)
            if calendar.isDateInToday(transaction.date) {
                todayTransactions.append(transaction)
            } else if calendar.isDateInYesterday(transaction.date) {
                yesterdayTransactions.append(transaction)
            } else {
                previousTransactions.append(transaction)
            }
        }
    }
    
    func filterTransactions() {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        
        previousTransactions = allTransactions.filter { transaction in
            let transactionDate = transaction.date
            let transactionMonth = calendar.component(.month, from: transactionDate)
            let isToday = calendar.isDateInToday(transactionDate)
            let isYesterday = calendar.isDateInYesterday(transactionDate)
            
            let shouldFilter = transactionMonth != currentMonth && !isToday && !isYesterday
            return shouldFilter
        }
        view?.reloadData(
            todayTransactions: todayTransactions,
            yesterdayTransactions: yesterdayTransactions,
            previousTransactions: previousTransactions
        )
    }
    
    func addTransaction(_ transaction: Transaction) {
        allTransactions.append(transaction)
        separateTransactions()
        view?.reloadData(
            todayTransactions: todayTransactions,
            yesterdayTransactions: yesterdayTransactions,
            previousTransactions: previousTransactions
        )
    }
    
    func updateRecentTransactions(_ transactions: [Transaction]) {
        view?.updateRecentTransactions(transactions)
    }
    
    func reloadData(todayTransactions: [Transaction], yesterdayTransactions: [Transaction], previousTransactions: [Transaction]) {
        self.todayTransactions = todayTransactions
        self.yesterdayTransactions = yesterdayTransactions
        self.previousTransactions = previousTransactions
    }
}
