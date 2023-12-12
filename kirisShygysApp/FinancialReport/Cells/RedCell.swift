//
//  RedCell.swift
//  kirisShygysApp
//
//  Created by Aizada on 04.12.2023.
//

import UIKit
import SnapKit

class RedCell: UICollectionViewCell {
    
    var totalExpenseUpdateHandler: ((String) -> Void)?
    var biggestExpenseUpdateHandler: ((String, String) -> Void)?
    
    //MARK: - UI
    private lazy var thisMonthLabel: UILabel = {
        let label = UILabel()
        label.text = "This Month"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var youEarnedLabel: UILabel = {
        let label = UILabel()
        label.text = "You Spend 💸"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var expenseLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 36)
        return label
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var biggestLabel: UILabel = {
        let label = UILabel()
        label.text = "Your biggest spending is from"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var yourExpenseCategoryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bottomExpenseLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 26)
        return label
    }()
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = UIColor(named: "red")
        contentView.addSubview(thisMonthLabel)
        contentView.addSubview(youEarnedLabel)
        contentView.addSubview(expenseLabel)
        contentView.addSubview(whiteView)
        contentView.addSubview(biggestLabel)
        contentView.addSubview(yourExpenseCategoryLabel)
        contentView.addSubview(bottomExpenseLabel)
    }
    
    func updateTotalExpenseForCurrentMonth(_ totalExpense: String) {
        DispatchQueue.main.async { [weak self] in
            self?.expenseLabel.text = totalExpense
            print("Updating total expense label with: \(totalExpense)")
        }
    }

    func updateBiggestExpense(amount: String, category: String) {
        DispatchQueue.main.async { [weak self] in
            self?.bottomExpenseLabel.text = amount
            self?.yourExpenseCategoryLabel.text = category
        }
    }
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        thisMonthLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }

        youEarnedLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(thisMonthLabel.snp.bottom).offset(90)
        }

        expenseLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(youEarnedLabel.snp.bottom).offset(10)
        }

        whiteView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-80)
            make.height.equalTo(200)
        }

        biggestLabel.snp.makeConstraints { make in
            make.top.equalTo(whiteView).offset(20)
            make.centerX.equalToSuperview()
        }

        yourExpenseCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(biggestLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }

        bottomExpenseLabel.snp.makeConstraints { make in
            make.top.equalTo(yourExpenseCategoryLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}

    


