//
//  GreenCell.swift
//  kirisShygysApp
//
//  Created by Aizada on 04.12.2023.
//

import UIKit
import SnapKit

class GreenCell: UICollectionViewCell {
    
    var totalIncomeUpdateHandler: ((String) -> Void)?
    var biggestIncomeUpdateHandler: ((String, String) -> Void)?
    
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
        label.text = "You Earned 💰"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var incomeLabel: UILabel = {
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
        label.text = "Your biggest Income is from"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    private lazy var yourIncomeCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bottomIncomeLabel: UILabel = {
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
        contentView.backgroundColor = UIColor(named: "green")
        contentView.addSubview(thisMonthLabel)
        contentView.addSubview(youEarnedLabel)
        contentView.addSubview(incomeLabel)
        contentView.addSubview(whiteView)
        contentView.addSubview(biggestLabel)
        contentView.addSubview(yourIncomeCategoryLabel)
        contentView.addSubview(bottomIncomeLabel)
    }
    
    func updateTotalIncomeForCurrentMonth(_ totalIncome: String) {
        DispatchQueue.main.async { [weak self] in
            self?.incomeLabel.text = totalIncome
            print("Updating total income label with: \(totalIncome)")
        }
    }

    func updateBiggestIncome(amount: String, category: String) {
        DispatchQueue.main.async { [weak self] in
            self?.bottomIncomeLabel.text = amount
            self?.yourIncomeCategoryLabel.text = category
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
        
        incomeLabel.snp.makeConstraints { make in
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
        
        yourIncomeCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(biggestLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        bottomIncomeLabel.snp.makeConstraints { make in
            make.top.equalTo(yourIncomeCategoryLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}
