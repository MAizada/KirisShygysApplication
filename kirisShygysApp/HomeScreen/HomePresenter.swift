//
//  HomePresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import UIKit
import Firebase

class HomePresenter: HomePresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    weak var view: HomeViewProtocol?
    var allTransactions: [Transaction] = []
    var todayTransactions: [Transaction] = []
    var weekTransactions: [Transaction] = []
    var monthTransactions: [Transaction] = []
    var yearTransactions: [Transaction] = []
     
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

            guard let view = self.view else { return }

            view.reloadData(
                todayTransactions: self.todayTransactions ?? [],
                weekTransactions: self.weekTransactions ?? [],
                monthTransactions: self.monthTransactions ?? [],
                yearTransactions: self.yearTransactions ?? []
            )

            self.filterTransactions(forPeriod: .today)

            let totalIncome = self.calculateTotal(for: .income)
            let totalExpense = self.calculateTotal(for: .expense)

            let balance = totalIncome - totalExpense
            view.updateBalance(with: balance)

            self.view?.updateTransactions(
                       todayTransactions: self.todayTransactions,
                       weekTransactions: self.weekTransactions,
                       monthTransactions: self.monthTransactions,
                       yearTransactions: self.yearTransactions
                   )
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
    
    func updateTransactions(todayTransactions: [Transaction], weekTransactions: [Transaction], monthTransactions: [Transaction], yearTransactions: [Transaction]) {
        view?.updateTransactions(
            todayTransactions: todayTransactions,
            weekTransactions: weekTransactions,
            monthTransactions: monthTransactions,
            yearTransactions: yearTransactions
        )
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
}
