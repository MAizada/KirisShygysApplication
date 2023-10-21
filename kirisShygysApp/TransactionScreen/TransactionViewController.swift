//
//  TransactionViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//

import UIKit
import SnapKit

final class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    // MARK: - UI
    private let monthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrowDown"), for: .normal)
        button.setTitle(" Month", for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let lineButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let financialReportTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "linearGradient")
        textField.layer.cornerRadius = 10
        textField.placeholder = "See your financial report"
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    private let rightArrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrowRight"), for: .normal)
        button.tintColor = UIColor(named: "lightBrown")
        return button
    }()
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var yesterdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Yesterday"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var transactionTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var secondTransactionTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    private var selectedMonthIndex: Int?
    
    private let transactions: [Transaction] = [
        Transaction(image: UIImage(named: "bag")!, title: "Shopping", description: "Buy some groceries", amount: "-$120", time: "10:30 AM", amountColorName: "red"),
        Transaction(image: UIImage(named: "recurringBill")!, title: "Subscription", description: "Disney+ Annual...", amount: "-$80", time: "03:30 PM", amountColorName: "red"),
        Transaction(image: UIImage(named: "restaurant")!, title: "Food", description: "Buy a ramen", amount: "-$32", time: "07:30 PM", amountColorName: "red"),
    ]
    
    private let secondTransactions: [Transaction] = [
        Transaction(image: UIImage(named: "salary")!, title: "Salary", description: "Salary for July", amount: "+$5000", time: "04:30 PM", amountColorName: "green"),
        Transaction(image: UIImage(named: "car")!, title: "Transportation", description: "Charging Tesla", amount: "-$18", time: "08:30 PM", amountColorName: "red"),
      
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBarItems()
        setupConstraints()
        
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [monthButton, lineButton, financialReportTextField, rightArrowButton, todayLabel, yesterdayLabel, tableView, transactionTableView, secondTransactionTableView].forEach { view.addSubview($0) }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MonthCell")
        transactionTableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionCell")
        secondTransactionTableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionCell")
        
        monthButton.addTarget(self, action: #selector(monthButtonTapped), for: .touchUpInside)
        lineButton.addTarget(self, action: #selector(lineButtonTapped), for: .touchUpInside)
        rightArrowButton.addTarget(self, action: #selector(rightArrowButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Setup NavigationBarItems
    private func setupNavigationBarItems() {
        let monthButtonBarItem = UIBarButtonItem(customView: monthButton)
        let lineBarButtonItem = UIBarButtonItem(customView: lineButton)
        let centerSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        navigationItem.leftBarButtonItems = [monthButtonBarItem]
        navigationItem.rightBarButtonItems = [lineBarButtonItem]
    }
    // MARK: - Actions
    
    @objc private func monthButtonTapped() {
        tableView.isHidden.toggle()
    }
    
    @objc private func lineButtonTapped() {
        print("lineButtonTapped")
    }
    
    @objc private func rightArrowButtonTapped() {
        print("rightArrowButtonTapped")
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
        monthButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(96)
        }
        
        lineButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        financialReportTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(94)
            make.centerX.equalToSuperview()
            make.width.equalTo(375)
            make.height.equalTo(64)
        }
        
        rightArrowButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(94)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(64)
        }
        
        todayLabel.snp.makeConstraints { make in
            make.top.equalTo(financialReportTextField).offset(70)
            make.leading.equalToSuperview().offset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        transactionTableView.snp.makeConstraints { make in
            make.top.equalTo(todayLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        yesterdayLabel.snp.makeConstraints { make in
            make.top.equalTo(transactionTableView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
        }
        
        secondTransactionTableView.snp.makeConstraints { make in
            make.top.equalTo(yesterdayLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    // MARK: - TableView Data Sourse and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return months.count
        } else if tableView == transactionTableView {
            return transactions.count
        } else if tableView == secondTransactionTableView {
            return secondTransactions.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            if indexPath.row >= 0 && indexPath.row < months.count {
                let selectedMonth = months[indexPath.row]
                monthButton.setTitle(selectedMonth, for: .normal)
                tableView.isHidden = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = months[indexPath.row]
            return cell
        } else if tableView == transactionTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
            let transaction = transactions[indexPath.row]
            cell.configure(with: transaction)
            return cell
        } else if tableView == secondTransactionTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
            let transaction = secondTransactions[indexPath.row]
            cell.configure(with: transaction)
            return cell
        }
        return UITableViewCell()
    }
}

