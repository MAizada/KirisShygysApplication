//
//  HomeViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    private lazy var avatarImage: UIImageView = {
        let image =  UIImageView()
        image.image = UIImage(named: "Avatar")
        image.contentMode = .left
        image.layer.cornerRadius = 25
        return image
    }()
    
    private lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_down"), for: .normal)
        button.contentMode = .center
        return button
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.text = "October"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "notifiaction"), for: .normal)
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
    
    private lazy var incomeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(named: "green")
        return view
    }()
    
    private lazy var rectangleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var incomeImage: UIImageView = {
        let image =  UIImageView()
        image.image = UIImage(named: "income")
        return image
    }()
    
    private lazy var incomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Income"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "$5000"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var expensesView: UIView = {
        let view = UIView()
        let redColor = UIColor(red: 0xE9/255, green: 0x4D/255, blue: 0x58/255, alpha: 1.0)
        view.backgroundColor = redColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var rectangleViewSecond: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var expenseImage: UIImageView = {
        let image =  UIImageView()
        image.image = UIImage(named: "expense")
        return image
    }()
    
    private lazy var expenseLabel: UILabel = {
        let label = UILabel()
        label.text = "Expenses"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var amountLabelSecond: UILabel = {
        let label = UILabel()
        label.text = "$1200"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        return label
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
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        
        view.backgroundColor = UIColor(named: "linearGradient")
        [avatarImage, arrowButton, monthLabel, notificationButton, accountBalanceLabel, moneyLabel, incomeView, rectangleView,
         incomeImage, incomeLabel, amountLabel, expensesView,rectangleViewSecond,expenseImage,expenseLabel,amountLabelSecond, spendFrequencyLabel, segmentedControl,
         resentLabel].forEach { view.addSubview($0) }
        
        
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
            make.leading.equalTo(152)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
        
        notificationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(56)
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
            make.height.equalTo(80)
            make.width.equalTo(164)
        }
        
        rectangleView.snp.makeConstraints { make in
            make.centerY.equalTo(incomeView.snp.centerY)
            make.left.equalTo(incomeView.snp.left).offset(16)
            make.width.height.equalTo(48)
        }
        
        incomeImage.snp.makeConstraints { make in
            make.centerX.equalTo(rectangleView)
            make.centerY.equalTo(rectangleView)
            make.width.height.equalTo(32)
        }
        
        incomeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(incomeView.snp.centerY).offset(-12)
            make.right.equalTo(incomeView.snp.right).offset(-32)
            make.width.equalTo(50)
            make.height.equalTo(17)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(incomeLabel.snp.bottom).offset(3)
            make.centerX.equalTo(incomeView.snp.centerX).offset(20)
            make.bottom.lessThanOrEqualTo(incomeView.snp.bottom).offset(-8)
        }
        
        expensesView.snp.makeConstraints { make in
            make.top.equalTo(moneyLabel.snp.bottom).offset(9)
            make.trailing.equalTo(-16)
            make.height.equalTo(80)
            make.width.equalTo(164)
        }
        
        rectangleViewSecond.snp.makeConstraints { make in
            make.centerY.equalTo(expensesView.snp.centerY)
            make.left.equalTo(expensesView.snp.left).offset(16)
            make.width.height.equalTo(48)
        }
        
        expenseImage.snp.makeConstraints { make in
            make.centerX.equalTo(rectangleViewSecond)
            make.centerY.equalTo(rectangleViewSecond)
            make.width.height.equalTo(32)
        }
        
        expenseLabel.snp.makeConstraints { make in
            make.centerY.equalTo(expensesView.snp.centerY).offset(-12)
            make.right.equalTo(expensesView.snp.right).offset(-32)
            make.width.equalTo(50)
            make.height.equalTo(17)
        }
        
        amountLabelSecond.snp.makeConstraints { make in
            make.top.equalTo(expenseLabel.snp.bottom).offset(3)
            make.centerX.equalTo(expensesView.snp.centerX).offset(20)
            make.bottom.lessThanOrEqualTo(expensesView.snp.bottom).offset(-8)
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
    }
}
