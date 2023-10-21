//
//  HomeViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UI
    
    private lazy var avatarImage: UIImageView = {
        let image =  UIImageView()
        image.image = UIImage(named: "Avatar")
        image.contentMode = .left
        image.layer.cornerRadius = 25
        return image
    }()
    
    private lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowDown"), for: .normal)
        button.contentMode = .center
        button.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.text = "October"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "notification"), for: .normal)
        return button
    }()
    
    private lazy var accountBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Account Balance"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.text = "$9400"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    private lazy var incomeView: IncomeView = {
        let view = IncomeView()
        return view
    }()
    
    private lazy var expenseView: ExpenseView = {
        let view = ExpenseView()
        return view
    }()
    
    private lazy var spendFrequencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Spend Frequency"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Today", "Weak", "Month", "Year"]
        let segment = UISegmentedControl(items: items)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    private lazy var resentLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Transaction"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
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
    
    private let transactions: [Transaction] = [
        Transaction(image: UIImage(named: "bag")!, title: "Shopping", description: "Buy some groceries", amount: "-$120", time: "10:30 AM", amountColorName: "red"),
        Transaction(image: UIImage(named: "recurringBill")!, title: "Subscription", description: "Disney+ Annual...", amount: "-$80", time: "03:30 PM", amountColorName: "red"),
        Transaction(image: UIImage(named: "restaurant")!, title: "Food", description: "Buy a ramen", amount: "-$32", time: "07:30 PM", amountColorName: "red"),
    ]
    
    private let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    private var selectedMonthIndex: Int?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBarItems()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "linearGradient")
        
        [avatarImage, arrowButton, monthLabel, notificationButton, accountBalanceLabel, moneyLabel, incomeView, expenseView, spendFrequencyLabel, segmentedControl, resentLabel, tableView, transactionTableView].forEach { view.addSubview($0) }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MonthCell")
        transactionTableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionCell")
        
    }
    // MARK: - Setup NavigationBarItems
    private func setupNavigationBarItems() {
        
        let notificationBarButtonItem = UIBarButtonItem(customView: notificationButton)
        let arrowBarButtonItem = UIBarButtonItem(customView: arrowButton)
        let centerSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [notificationBarButtonItem, arrowBarButtonItem]
//        navigationItem.centerItems = [arrowBarButtonItem]
        
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        arrowButton.addTarget(self, action: #selector(arrowButtonTapped), for: .touchUpInside)
        
        let centerSpaceBarButtonItem2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
    }
    
    // MARK: - Actions
    
    @objc private func arrowButtonTapped() {
        tableView.isHidden.toggle()
    }
    
    @objc private func notificationButtonTapped() {
        
        let notificationVC = NotificationViewController()
        self.present(notificationVC, animated: true, completion: nil)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(32)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.trailing.equalTo(monthLabel).offset(-60)
            make.width.equalTo(40)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(32)
        }
        
        accountBalanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(113)
            make.height.equalTo(17)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(accountBalanceLabel.snp.bottom).offset(9)
            make.centerX.equalToSuperview()
        }
        
        incomeView.snp.makeConstraints { make in
            make.top.equalTo(moneyLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(164)
            make.height.equalTo(80)
        }
        
        expenseView.snp.makeConstraints { make in
            make.top.equalTo(moneyLabel.snp.bottom).offset(9)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(164)
            make.height.equalTo(80)
        }
        
        spendFrequencyLabel.snp.makeConstraints { make in
            make.top.equalTo(incomeView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(450)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(350)
            make.height.equalTo(30)
        }
        
        resentLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(450)
        }
        
        transactionTableView.snp.makeConstraints { make in
            make.top.equalTo(resentLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: - TableView Data Sourse and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return months.count
        } else if tableView == transactionTableView {
            return transactions.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            if indexPath.row >= 0 && indexPath.row < months.count {
                let selectedMonth = months[indexPath.row]
                monthLabel.text = selectedMonth
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
        }
        return UITableViewCell()
    }
}
