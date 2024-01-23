//
//  ConfirmLogoutView.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.01.2024.
//

import UIKit

class ConfirmLogoutView: UIView {

    weak var delegate: ConfirmLogoutViewDelegate?

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you sure you want to logout?"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var yesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yes", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var noButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("No", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true

        [messageLabel, yesButton, noButton].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        yesButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }

        noButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.leading.equalTo(yesButton.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(yesButton.snp.width)
        }
    }

    @objc private func yesButtonTapped() {
        delegate?.confirmLogout()
    }

    @objc private func noButtonTapped() {
        delegate?.cancelLogout()
    }
}
