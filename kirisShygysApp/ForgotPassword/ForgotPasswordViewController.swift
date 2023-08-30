//
//  ForgotPasswordViewController.swift
//  kirisShygysApp
//
//  Created by siberianarg on 30.08.2023.
//

import UIKit
import SnapKit

final class ForgotPasswordViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var forgotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ilustration")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Your email is on the way"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Check your email test@test.com and follow the instructions to reset your password"
        label.font = UIFont(name: "Arial", size: 16)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "violet")
        button.layer.cornerRadius = 16
        button.setTitle("Back to Login", for: .normal)
        button.tintColor = UIColor(named: "baseLight")
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(backButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(forgotImageView)
        view.addSubview(emailLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(backButton)
    }
    
    @objc private func backButtonDidPressed() {
        print("Back Button Did Pressed")
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        forgotImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(76)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(312)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(forgotImageView.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-23)
            make.height.equalTo(29)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-23)
            make.height.equalTo(57)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(56)
        }
    }
}
