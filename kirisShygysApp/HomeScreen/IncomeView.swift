//
//  IncomeView.swift
//  kirisShygysApp
//
//  Created by Aizada on 08.10.2023.
//

import UIKit
import SnapKit

class IncomeView: UIView {
    
    // MARK: - UI
    
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
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .boldSystemFont(ofSize: 18)
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
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [incomeView, rectangleView, incomeImage, incomeLabel, amountLabel].forEach { addSubview($0) }
    }
    
    func updateIncome(amount: String) {
        amountLabel.text = amount
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        incomeView.snp.makeConstraints { make in
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
            make.trailing.equalTo(incomeView.snp.trailing).offset(-32)
            make.width.equalTo(62)
            make.height.equalTo(17)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(incomeLabel.snp.bottom).offset(3)
            make.centerX.equalTo(incomeView.snp.centerX).offset(20)
            make.bottom.lessThanOrEqualTo(incomeView.snp.bottom).offset(-8)
        }
    }
}
