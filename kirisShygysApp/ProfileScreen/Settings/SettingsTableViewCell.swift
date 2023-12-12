//
//  SettingsTableViewCell.swift
//  kirisShygysApp
//
//  Created by Aizada on 08.12.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    public var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    public var actionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowRight"), for: .normal)
        
        if let image = UIImage(named: "arrowRight")?.withTintColor(.black) {
            button.setImage(image, for: .normal)
        }

        return button
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionButton)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        actionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
