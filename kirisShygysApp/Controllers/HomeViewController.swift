//
//  HomeViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//

import UIKit
import SnapKit

class HomeViewController: UITabBarController {
    
    let avatarImage: UIImageView = {
        let image =  UIImageView()
        image.image = UIImage(named: "Avatar")
        image.contentMode = .left
        image.layer.cornerRadius = 25
        return image
    }()
    
    let arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow down 2"), for: .normal)
        button.contentMode = .center
        return button
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "October"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "notifiaction"), for: .normal)
        return button
    }()
    
    let accountBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Account Balance"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.text = "$9400"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    var incomeView: UIView = {
        let view = UIView()
//        let greenColor = UIColor(red: 0x2B/255, green: 0xA4/255, blue: 0x78/255, alpha: 1.0)
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(named: "green")
        return view
    }()
    
    var rectangleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    let incomeImage: UIImageView = {
        let image =  UIImageView()
        image.image = UIImage(named: "income")
        return image
    }()
    
    let incomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Income"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "$5000"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let expensesView: UIView = {
        let view = UIView()
        let redColor = UIColor(red: 0xE9/255, green: 0x4D/255, blue: 0x58/255, alpha: 1.0)
        view.backgroundColor = redColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    let rectangleView2: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()
    
    let expenseImage: UIImageView = {
        let image =  UIImageView()
        image.image = UIImage(named: "expense")
        return image
    }()
    
    let expenseLabel: UILabel = {
        let label = UILabel()
        label.text = "Expenses"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    let amountLabel2: UILabel = {
        let label = UILabel()
        label.text = "$1200"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let spendFrequencyLabel: UILabel = {
        let label = UILabel()
        label.text = "Spend Frequency"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let items = ["Today", "Weak", "Month", "Year"]
        let segment = UISegmentedControl(items: items)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    let resentLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Transaction"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let tableView: UITableView = {
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
        view.addSubview(avatarImage)
        view.addSubview(arrowButton)
        view.addSubview(monthLabel)
        view.addSubview(notificationButton)
        view.addSubview(accountBalanceLabel)
        view.addSubview(moneyLabel)
        view.addSubview(incomeView)
        view.addSubview(rectangleView)
        view.addSubview(incomeImage)
        view.addSubview(incomeLabel)
        view.addSubview(amountLabel)
        view.addSubview(expensesView)
        view.addSubview(rectangleView2)
        view.addSubview(expenseImage)
        view.addSubview(expenseLabel)
        view.addSubview(amountLabel2)
        view.addSubview(spendFrequencyLabel)
        view.addSubview(segmentedControl)
        view.addSubview(resentLabel)
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
        
        rectangleView2.snp.makeConstraints { make in
            make.centerY.equalTo(expensesView.snp.centerY)
            make.left.equalTo(expensesView.snp.left).offset(16)
            make.width.height.equalTo(48)
        }
        
        expenseImage.snp.makeConstraints { make in
            make.centerX.equalTo(rectangleView2)
            make.centerY.equalTo(rectangleView2)
            make.width.height.equalTo(32)
        }
        
        expenseLabel.snp.makeConstraints { make in
            make.centerY.equalTo(expensesView.snp.centerY).offset(-12)
            make.right.equalTo(expensesView.snp.right).offset(-32)
            make.width.equalTo(50)
            make.height.equalTo(17)
        }
        
        amountLabel2.snp.makeConstraints { make in
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.white
    }
}
