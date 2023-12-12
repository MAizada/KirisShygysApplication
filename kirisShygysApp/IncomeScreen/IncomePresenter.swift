//
//  IncomePresenter.swift
//  kirisShygysApp
//
//  Created by Aizada on 16.10.2023.
//

import UIKit

class IncomePresenter: IncomePresenterProtocol {
    
    let firebaseManager = FirebaseManager.shared
    weak var view: IncomeViewProtocol?
    weak var updateDelegate: UpdateTableDelegate?
    
    func earnedTransaction(amount: String, category: String, description: String) {
        guard !category.isEmpty, !amount.isEmpty else {
            return
        }

        let isIncomeCategory = Category.incomes.contains { $0.name == category }
        let transactionType: TransactionType = isIncomeCategory ? .income : .expense
        
        let newTransaction = Transaction(
            title: category,
            description: description,
            amount: amount,
            time: Date(),
            date: Date(),
            type: transactionType
        )

        firebaseManager.saveTransaction(newTransaction) { [weak self] error in
            if let error = error {
                print("Ошибка при сохранении транзакции: \(error.localizedDescription)")
            } else {
                print("Успешно сохранено")
                self?.updateDelegate?.updateTransactions()
                self?.view?.dismissView()
            }
        }
    }

}
