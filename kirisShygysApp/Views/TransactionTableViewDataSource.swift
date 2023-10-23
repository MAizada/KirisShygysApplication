//
//  TransactionTableViewDataSource.swift
//  kirisShygysApp
//
//  Created by Aizada on 06.10.2023.
//

import UIKit

class TransactionTableViewDataSource: UIViewController {

    // MARK: - TransactionTableView Data Sourse and Delegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return months.count
        } else if tableView == transactionTableView {
            return transactions.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = months[indexPath.row]
            return cell
        } else if tableView == transactionTableView {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            let transaction = transactions[indexPath.row]
            
            // Создайте и настройте кастомную ячейку для транзакций
            let transactionCell = TransactionTableViewCell()
            transactionCell.configure(with: transaction)
            
            // Добавьте кастомную ячейку в таблицу
            cell.contentView.addSubview(transactionCell)
            
            // Настройте constraints для кастомной ячейки
            transactionCell.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
}
