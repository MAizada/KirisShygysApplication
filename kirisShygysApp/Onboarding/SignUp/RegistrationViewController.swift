//
//  RegistrationViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.11.2023.
//

import UIKit
import SnapKit

final class RegistrationViewController: UIViewController {
    
    let firebaseManager = FirebaseManager.shared
    var checkField = CheckField.shared
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 10
        textField.borderStyle = .roundedRect
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "lightBrown")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(named: "lightBrown"), for: .normal)
        button.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginLabel, loginButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigation()
    }
    
    // MARK: - Actions
    
    @objc func loginButtonTap() {
        let authVC = AuthorizationViewController()
        navigationController?.pushViewController(authVC, animated: true)
        navigationController?.viewControllers = [authVC]
    }
    
    @objc func signUpButtonTap() {
        guard let email = emailTextField.text?.lowercased(),
              let password = passwordTextField.text,
              !email.isEmpty, !password.isEmpty else {
            let alert = UIAlertController(title: "", message: "Please enter your email and password", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ок", style: .default)
            alert.addAction(okButton)
            present(alert, animated: true)
            return
        }

        firebaseManager.createNewUser(LoginField(email: email, password: password)) { code in
            switch code.code {
            case 0:
                let alert = UIAlertController(title: "", message: "Please enter your email and password", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ок", style: .default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
                
            case 1:
                let alert = UIAlertController(title: "", message: "Congratulations! You have registered", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .default) { _ in
                    // Закрываем текущий экран или выполняем действие, которое нужно после регистрации
                    // Например, выполнение перехода на другой экран или закрытие этого
                    self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okButton)
                self.present(alert, animated: true)
                
            default:
                print("Unknown error")
            }
        }
    }

    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [titleLabel, nameTextField, emailTextField, passwordTextField, showPasswordButton, signUpButton, loginStackView].forEach { view.addSubview($0) }
    }
    
    // MARK: - Setup Navigation
    func setupNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.barTintColor = .white
    }
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.width.equalTo(250)
            make.height.equalTo(30)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.width.equalTo(24)
               make.height.equalTo(24)
               make.centerY.equalTo(passwordTextField)
               make.trailing.equalTo(passwordTextField).offset(-20)
        }
        
        signUpButton.snp.makeConstraints { make in make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).offset(16)
        }
       
    }
}

