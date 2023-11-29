//
//  ExpenseView.swift
//  kirisShygysApp
//
//  Created by Aizada on 08.10.2023.
//

import UIKit
import SnapKit

class ExpenseView: UIView {

    // MARK: - UI
    private lazy var expensesView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "red")
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
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var amountLabelSecond: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        addSubview(expensesView)
        expensesView.addSubview(rectangleViewSecond)
        rectangleViewSecond.addSubview(expenseImage)
        expensesView.addSubview(expenseLabel)
        expensesView.addSubview(amountLabelSecond)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        expensesView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(164)
        }
        
        rectangleViewSecond.snp.makeConstraints { make in
            make.centerY.equalTo(expensesView.snp.centerY)
            make.leading.equalTo(expensesView.snp.leading).offset(16)
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
            make.width.equalTo(62)
            make.height.equalTo(17)
        }
        
        amountLabelSecond.snp.makeConstraints { make in
            make.top.equalTo(expenseLabel.snp.bottom).offset(3)
            make.centerX.equalTo(expensesView.snp.centerX).offset(20)
            make.bottom.lessThanOrEqualTo(expensesView.snp.bottom).offset(-8)
        }
    }
}
