//
//  NotificationTableViewCell.swift
//  kirisShygysApp
//
//  Created by Aizada on 12.10.2023.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.bottom.lessThanOrEqualTo(contentView).offset(-5)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.bottom.lessThanOrEqualTo(contentView).offset(-5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(30)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.bottom.lessThanOrEqualTo(contentView).offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with notification: Notification) {
        titleLabel.text = notification.title
        descriptionLabel.text = notification.description
        dateLabel.text = notification.time
        }
    }

