//
//  FinancialReportPresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 04.12.2023.
//

import Foundation

final class FinancialReportPresenter: FinancialReportPresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    weak var view: FinancialReportViewProtocol?
    
    func fetchFinancialReportData() {
        firebaseManager.loadTransactions { [weak self] transactions in
            guard let self = self else { return }
            
            
            // переделать в отдклный метод
            let totalIncome = self.calculateTotal(transactions: transactions, ofType: .income)
            self.view?.updateTotalIncomeForCurrentMonth("\(totalIncome)")
            
            self.calculateBiggest(transactions: transactions, ofType: .income) { amount, category in
                self.view?.updateBiggestIncome(amount: amount, category: category)
            }
            
            let totalExpense = self.calculateTotal(transactions: transactions, ofType: .expense)
            self.view?.updateTotalExpenseForCurrentMonth("\(totalExpense)")
            
            self.calculateBiggest(transactions: transactions, ofType: .expense) { amount, category in
                self.view?.updateBiggestExpense(amount: amount, category: category)
            }
            
        }
    }
    
    private func calculateTotal(transactions: [Transaction], ofType type: TransactionType) -> Double {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        
        let transactionsThisMonth = transactions.filter { transaction in
            let transactionMonth = calendar.component(.month, from: transaction.date)
            return transactionMonth == currentMonth && transaction.type == type
        }
        
        let total = transactionsThisMonth.reduce(0.0) { result, transaction in
            guard let amount = Double(transaction.amount) else { return result }
            return result + amount
        }
        return total
    }
    
    private func calculateBiggest(transactions: [Transaction], ofType type: TransactionType, completion: @escaping (String, String) -> Void) {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        
        let transactionsThisMonth = transactions.filter { transaction in
            let transactionMonth = calendar.component(.month, from: transaction.date)
            return transactionMonth == currentMonth && transaction.type == type
        }
        
        if let transactionWithMaxAmount = transactionsThisMonth.max(by: { firstTransaction, secondTransaction in
            guard let firstAmount = Double(firstTransaction.amount),
                  let secondAmount = Double(secondTransaction.amount) else { return false }
            return firstAmount < secondAmount
        }) {
            completion(transactionWithMaxAmount.amount, transactionWithMaxAmount.title)
        }
    }
}
