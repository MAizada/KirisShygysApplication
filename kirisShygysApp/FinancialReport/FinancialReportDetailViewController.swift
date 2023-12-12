//
//  FinancialReportDetailViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 04.12.2023.
//

import UIKit

final class FinancialReportDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    
    // MARK: - UI
    private lazy var financialReportLabel: UILabel = {
        let label = UILabel()
        label.text = "Financial Report"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private var monthButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrowDown"), for: .normal)
        button.setTitle(" Month", for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var monthTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["Income", "Expense"]
        let segment = UISegmentedControl(items: items)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        segment.layer.cornerRadius = 20
        segment.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        segment.setBackgroundImage(imageFromColor(color: UIColor(named: "red")!), for: .normal, barMetrics: .default)
        segment.setBackgroundImage(imageFromColor(color: UIColor(named: "green")!), for: .selected, barMetrics: .default)
            
        return segment
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    private var selectedMonthIndex: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigationBarItems()
        
        
    }
    //MARK: - Set uo views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [financialReportLabel, monthButton, monthTableView, balanceLabel, segmentedControl, tableView ].forEach { view.addSubview($0) }
        
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: "TransactionCell")
        
        monthTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MonthCell")
        monthTableView.isHidden = true
    }
    
    //MARK: - setupNavigationBarItems
    
    private func setupNavigationBarItems() {
        let monthButtonBarItem = UIBarButtonItem(customView: monthButton)
        let centerSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        monthButton.addTarget(self, action: #selector(monthButtonTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItems = [monthButtonBarItem]
    }
    
    //MARK: - Actions
    
    func imageFromColor(color: UIColor) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
        return renderer.image { context in
            color.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
    }
    
    
    @objc private func monthButtonTapped() {
        monthTableView.isHidden.toggle()
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        //        switch sender.selectedSegmentIndex {
        //        case 0:
        //            presenter?.filterTransactions(forPeriod: .income)
        //        case 1:
        //            presenter?.filterTransactions(forPeriod: .expense)
        //
        //        default:
        //            break
        //        }
    }
    
    //MARK: - setupConstraints
    private func setupConstraints() {
        
        financialReportLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(56)
        }
        
        monthButton.snp.makeConstraints { make in
            make.top.equalTo(financialReportLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            
        }
        
        monthTableView.snp.makeConstraints { make in
            make.top.equalTo(monthButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().offset(10)
            make.height.equalTo(800)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(monthButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(monthButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(monthButton.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().offset(10)
            make.height.equalTo(800)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == monthTableView {
            return months.count
            //        } else if tableView == self.tableView {
            //            //пока что 10
            //            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        if tableView == monthTableView {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonthCell", for: indexPath)
        cell.textLabel?.text = months[indexPath.row]
        return cell
        //        } else if tableView == self.tableView {
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
        //            var transaction: Transaction?
        
    }
}

