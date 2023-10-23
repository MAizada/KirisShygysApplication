//
//  BudgetViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//

import UIKit
import SnapKit

final class BudgetViewController: UIViewController {
    
    // MARK: - UI
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.text = "May"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var leftArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrowLeft"))
        return imageView
    }()
    
    private lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrowRight"))
        return imageView
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "You don't have a budget. Let's make one so you in control"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var createBudgetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create a budget", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "lightBrown")
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    private lazy var currentMonthIndex = 4
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "lightBrown")
        [monthLabel, leftArrowImageView, rightArrowImageView, whiteView, messageLabel, createBudgetButton].forEach { view.addSubview($0) }
        
        createBudgetButton.addTarget(self, action: #selector(createBudgetButtonTapped), for: .touchUpInside)
        
        leftArrowImageView.isUserInteractionEnabled = true
        let leftArrowTap = UITapGestureRecognizer(target: self, action: #selector(leftArrowButtonTapped))
        leftArrowImageView.addGestureRecognizer(leftArrowTap)
        
        rightArrowImageView.isUserInteractionEnabled = true
        let rightArrowTap = UITapGestureRecognizer(target: self, action: #selector(rightArrowButtonTapped))
        rightArrowImageView.addGestureRecognizer(rightArrowTap)
    }
    
    // MARK: - Actions
    
    @objc func createBudgetButtonTapped() {
        print("createBudgetButtonTapped")
    }
    
    @objc func leftArrowButtonTapped() {
        if currentMonthIndex > 0 {
            currentMonthIndex -= 1
            updateMonthLabel()
        }
    }
    
    @objc func rightArrowButtonTapped() {
        if currentMonthIndex < months.count - 1 {
            currentMonthIndex += 1
            updateMonthLabel()
        }
    }
    
    private func updateMonthLabel() {
        monthLabel.text = months[currentMonthIndex]
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.centerX.equalToSuperview()
        }
        
        leftArrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(monthLabel)
            make.leading.equalToSuperview().offset(20)
        }
        
        rightArrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(monthLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        whiteView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        createBudgetButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-140)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
    }
}
