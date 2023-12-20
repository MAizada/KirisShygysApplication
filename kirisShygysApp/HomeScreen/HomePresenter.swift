//
//  HomePresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import UIKit
import Firebase

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol?
    let firebaseManager = FirebaseManager.shared
    var allTransactions: [Transaction] = []
    var todayTransactions: [Transaction] = []
    var weekTransactions: [Transaction] = []
    var monthTransactions: [Transaction] = []
    var yearTransactions: [Transaction] = []
    
    var incomeTransactions: [Transaction] = []
    var expenseTransactions: [Transaction] = []
    var chartView: TransactionsChartView?
    
    var incomeView: IncomeView?
    var expenseView: ExpenseView?
    
    private func calculateTotal(for type: TransactionType) -> Double {
        return allTransactions.reduce(0) { result, transaction in
            guard transaction.type == type,
                  let amount = Double(transaction.amount) else { return result }
            return result + amount
        }
    }
    
    func loadTransactionsFromFirebase() {
        firebaseManager.loadTransactions { [weak self] transactions in
            guard let self = self else { return }
                  
            self.allTransactions = transactions
            self.separateTransactions()
            
            let totalIncome = self.calculateTotal(for: .income)
            let totalExpense = self.calculateTotal(for: .expense)
            let balance = totalIncome - totalExpense
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.incomeTransactions = transactions.filter { $0.type == .income }
                self.expenseTransactions = transactions.filter { $0.type == .expense }
                
                self.view?.updateChartView(with: self.incomeTransactions, expenseTransactions: self.expenseTransactions)

                self.updateTransactionsAndCharts(
                    todayTransactions: self.todayTransactions,
                    weekTransactions: self.weekTransactions,
                    monthTransactions: self.monthTransactions,
                    yearTransactions: self.yearTransactions,
                    incomeTransactions: self.incomeTransactions,
                    expenseTransactions: self.expenseTransactions,
                    in: self.chartView ?? TransactionsChartView()
                )

                self.view?.reloadData(
                    todayTransactions: self.todayTransactions,
                    weekTransactions: self.weekTransactions,
                    monthTransactions: self.monthTransactions,
                    yearTransactions: self.yearTransactions
                )
                
                self.view?.updateBalance(with: balance)
                self.view?.updateIncome(amount: String(format: "%.2f", totalIncome))
                self.view?.updateExpense(amount: String(format: "%.2f", totalExpense))
            }
        }
    }
    
    func separateTransactions() {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        
        let today = calendar.startOfDay(for: currentDate)
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate))
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))
        let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: currentDate))
        
        todayTransactions = allTransactions.filter { calendar.isDateInToday($0.date) }
        weekTransactions = allTransactions.filter { calendar.dateInterval(of: .weekOfYear, for: $0.date)?.contains(currentDate) ?? false }
        monthTransactions = allTransactions.filter { calendar.isDate($0.date, equalTo: startOfMonth ?? Date(), toGranularity: .month) }
        yearTransactions = allTransactions.filter { calendar.isDate($0.date, equalTo: startOfYear ?? Date(), toGranularity: .year) }
    }
    
    func filterTransactions(forPeriod period: Period) {
        let currentDate = Date()
        let calendar = Calendar.current
        
        var interval: DateInterval?
        
        switch period {
        case .today:
            interval = calendar.dateInterval(of: .day, for: currentDate)
        case .thisWeek:
            interval = calendar.dateInterval(of: .weekOfYear, for: currentDate)
        case .thisMonth:
            interval = calendar.dateInterval(of: .month, for: currentDate)
        case .thisYear:
            interval = calendar.dateInterval(of: .year, for: currentDate)
        }
        
        guard let dateInterval = interval else { return }
        let filteredTransactions = allTransactions.filter { dateInterval.contains($0.date) }
        
        switch period {
        case .today:
            todayTransactions = filteredTransactions
        case .thisWeek:
            weekTransactions = filteredTransactions
        case .thisMonth:
            monthTransactions = filteredTransactions
        case .thisYear:
            yearTransactions = filteredTransactions
        }
        
        view?.reloadData(
            todayTransactions: todayTransactions,
            weekTransactions: weekTransactions,
            monthTransactions: monthTransactions,
            yearTransactions: yearTransactions
        )
    }
    
    func addTransaction(_ transaction: Transaction) {
        allTransactions.append(transaction)
        separateTransactions()
        view?.reloadData(
            todayTransactions: todayTransactions,
            weekTransactions: weekTransactions,
            monthTransactions: monthTransactions,
            yearTransactions: yearTransactions
        )
    }
    
    func updateTransactionsAndCharts(
        todayTransactions: [Transaction],
        weekTransactions: [Transaction],
        monthTransactions: [Transaction],
        yearTransactions: [Transaction],
        incomeTransactions: [Transaction],
        expenseTransactions: [Transaction],
        in chartView: TransactionsChartView
    ) {
        
        view?.updateTransactions(
            todayTransactions: todayTransactions,
            weekTransactions: weekTransactions,
            monthTransactions: monthTransactions,
            yearTransactions: yearTransactions
        )

        chartView.incomeTransactions = incomeTransactions
        chartView.expenseTransactions = expenseTransactions
        chartView.setNeedsDisplay()
    }
    
    func reloadData(todayTransactions: [Transaction], weekTransactions: [Transaction], monthTransactions: [Transaction], yearTransactions: [Transaction]) {
        self.todayTransactions = todayTransactions
        self.weekTransactions = weekTransactions
        self.monthTransactions = monthTransactions
        self.yearTransactions = yearTransactions
        
        view?.reloadData(
            todayTransactions: todayTransactions,
            weekTransactions: weekTransactions,
            monthTransactions: monthTransactions,
            yearTransactions: yearTransactions
        )
    }
    
    func updateBalance(transactions: [Transaction], currentBalance: Double, completion: @escaping (Double) -> Void) {
        var newBalance = currentBalance
        for transaction in transactions {
            if let amount = Double(transaction.amount) {
                newBalance += (transaction.type == .income) ? amount : -amount
            }
        }
        
        if let userId = Auth.auth().currentUser?.uid {
            FirebaseManager.shared.updateBalance(for: userId, newBalance: newBalance) { responseCode in
                if responseCode.code == 1 {
                    print("Баланс успешно обновлен в Firebase: \(newBalance)")
                    completion(newBalance)
                } else {
                    print("Ошибка при обновлении баланса в Firebase")
                    completion(currentBalance)
                }
            }
        } else {
            print("UserId не найден")
            completion(currentBalance)
        }
    }
}

