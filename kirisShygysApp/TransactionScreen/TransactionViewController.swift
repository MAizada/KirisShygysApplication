//
//  TransactionViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//

import UIKit
import SnapKit

final class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TransactionViewProtocol {
    
    var presenter: TransactionPresenterProtocol?
    var updateRecentTransactions: (([Transaction]) -> Void)?
    
    var todayTransactions: [Transaction] = []
    var yesterdayTransactions: [Transaction] = []
    var previousTransactions: [Transaction] = []
    
    private var initialDataLoaded = false
    
    // MARK: - UI
    private var monthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrowDown"), for: .normal)
        button.setTitle(" Month", for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private var lineButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private var financialReportTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "linearGradient")
        textField.layer.cornerRadius = 10
        textField.placeholder = "See your financial report"
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    private var rightArrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrowRight"), for: .normal)
        button.tintColor = UIColor(named: "lightBrown")
        return button
    }()
    
    private lazy var monthTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    private var selectedMonthIndex: Int?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBarItems()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadTransactionsFromFirebase()
        }
    
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionCell")
        
        [monthButton, lineButton, financialReportTextField, rightArrowButton, monthTableView, tableView].forEach { view.addSubview($0) }
        
        monthTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MonthCell")
        monthTableView.isHidden = true
    }
    
    // MARK: - Setup NavigationBarItems
    
    private func setupNavigationBarItems() {
        let monthButtonBarItem = UIBarButtonItem(customView: monthButton)
        let lineBarButtonItem = UIBarButtonItem(customView: lineButton)
        let centerSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        monthButton.addTarget(self, action: #selector(monthButtonTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItems = [monthButtonBarItem]
        navigationItem.rightBarButtonItems = [lineBarButtonItem]
    }
    
    // MARK: - Actions
    
    @objc private func monthButtonTapped() {
        monthTableView.isHidden.toggle()
    }
    
    @objc private func lineButtonTapped() {
        print("lineButtonTapped")
    }
    
    @objc private func rightArrowButtonTapped() {
        print("rightArrowButtonTapped")
    }
    
    func addTransaction(_ transaction: Transaction) {
        presenter?.addTransaction(transaction)
    }
    
    func reloadData(todayTransactions: [Transaction], yesterdayTransactions: [Transaction], previousTransactions: [Transaction]) {
        self.todayTransactions = todayTransactions
        self.yesterdayTransactions = yesterdayTransactions
        self.previousTransactions = previousTransactions
        tableView.reloadData()
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
            make.top.equalToSuperview().offset(130)
            make.centerX.equalToSuperview()
            make.width.equalTo(375)
            make.height.equalTo(64)
        }
        
        rightArrowButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(64)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(financialReportTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(800)
        }
        
        monthTableView.snp.makeConstraints { make in
            make.top.equalTo(monthButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
    }
    
    // MARK: - TableView Data Source and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == monthTableView {
            return months.count
        } else if tableView == self.tableView {
            switch section {
            case 0:
                return todayTransactions.count
            case 1:
                return yesterdayTransactions.count
            case 2:
                return previousTransactions.count
            default:
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == monthTableView {
            if indexPath.row >= 0 && indexPath.row < months.count {
                let selectedMonth = months[indexPath.row]
                monthButton.setTitle(selectedMonth, for: .normal)
                monthTableView.isHidden = true
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableView {
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.tableView {
            switch section {
            case 0:
                return "Today"
            case 1:
                return "Yesterday"
            case 2:
                return "Previous"
            default:
                return nil
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == monthTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell", for: indexPath)
            cell.textLabel?.text = months[indexPath.row]
            return cell
        } else if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
            var transaction: Transaction?
            switch indexPath.section {
            case 0:
                if indexPath.row < todayTransactions.count {
                    cell.configure(with: todayTransactions[indexPath.row])
                }
            case 1:
                if indexPath.row < yesterdayTransactions.count {
                    cell.configure(with: yesterdayTransactions[indexPath.row])
                }
            case 2:
                if indexPath.row < previousTransactions.count {
                    cell.configure(with: previousTransactions[indexPath.row])
                }
            default:
                break
            }
            if let transaction = transaction {
                      cell.configure(with: transaction)
                  }
            return cell
        }
        return UITableViewCell()
    }
    
    func updateRecentTransactions(_ transactions: [Transaction]) {
        self.updateRecentTransactions?(transactions)
    }
}

extension TransactionViewController: IncomeViewProtocol {
    func didAddTransaction(amount: String, category: String, description: String, image: UIImage?, amountColorName: String) {
        let newTransaction = Transaction(
            //  image: image ?? UIImage(),
            title: category,
            description: description,
            amount: amount,
            time: Date(),
            date: Date(),
            type: .income
        )
        presenter?.addTransaction(newTransaction)
    }
}
 
extension TransactionViewController: UpdateTableDelegate {
    func updateTransactions() {
        presenter?.loadTransactionsFromFirebase()
    }
}
