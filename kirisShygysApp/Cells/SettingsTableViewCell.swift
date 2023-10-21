//
//  SettingsTableViewCell.swift
//  kirisShygysApp
//
//  Created by Aizada on 12.10.2023.
//

import UIKit
import SnapKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(containerView)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(iconImageView)
        }
    }
}
