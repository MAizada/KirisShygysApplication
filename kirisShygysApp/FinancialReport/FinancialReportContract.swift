//
//  FinancialReportContract.swift
//  kirisShygysApp
//
//  Created by Aizada on 04.12.2023.
//

import Foundation

protocol FinancialReportViewProtocol: AnyObject {
    func updateTotalIncomeForCurrentMonth(_ totalIncome: String)
    func updateBiggestIncome(amount: String, category: String)
    func updateTotalExpenseForCurrentMonth(_ totalExpense: String)
    func updateBiggestExpense(amount: String, category: String)
}

protocol FinancialReportPresenterProtocol {
    var view: FinancialReportViewProtocol? { get set }
    func fetchFinancialReportData()
}
