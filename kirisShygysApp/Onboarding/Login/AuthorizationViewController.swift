//
//  AuthorizationViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.11.2023.
//

import UIKit
import SnapKit

final class AuthorizationViewController: UIViewController, AuthorizationViewProtocol {
    
    let firebaseManager = FirebaseManager.shared
    var checkField = CheckField.shared
    var presenter: AuthorizationPresenterProtocol?
    
    var userDefault = UserDefaults.standard
    
    //MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
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
        button.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(showPasswordTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "lightBrown")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account yet?"
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor(named: "lightBrown"), for: .normal)
        button.addTarget(self, action: #selector(signUpTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private var isPasswordVisible = false
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNavigation()
        setupPresenter()
    }
    
    private func setupPresenter() {
        let presenter = AuthorizationPresenter()
        presenter.delegate = self
        presenter.view = self
        self.presenter = presenter
    }
    
    //MARK: - AuthorizationViewProtocol functions
    
    func getEmailTextFieldValue() -> String? {
        return emailTextField.text
    }
    
    func getPasswordTextFieldValue() -> String? {
        return passwordTextField.text
    }
    
    func showEmptyFieldsError() {
        let alert = UIAlertController(title: "", message: "Please enter both email and password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showSuccessMessage(_ message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func signUpTap() {
        let registrationVC = RegistrationViewController()
        navigationController?.pushViewController(registrationVC, animated: true)
        navigationController?.viewControllers = [registrationVC]
    }
    
    @objc private func showPasswordTapped() {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        showPasswordButton.isSelected = isPasswordVisible
    }
    
    @objc func loginButtonTap() {
        presenter?.authorize()
    }
    
    func alertAction(_ header: String?, _ message: String?) -> UIAlertController {
        let alert = UIAlertController(title: header, message: message, preferredStyle: .alert)
        return alert
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [titleLabel, emailTextField, passwordTextField, showPasswordButton, loginButton, signUpStackView].forEach { view.addSubview($0) }
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
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
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
        
        loginButton.snp.makeConstraints { make in make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
        signUpStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(16)
        }
        
    }
}

extension AuthorizationViewController: AuthorizationPresenterDelegate {
    func didAuthorizeSuccessfully() {
        let mainVC = MainTabBarController()
        navigationController?.setViewControllers([mainVC], animated: true)
    }
    
    func didFailToAuthorize() {
        let alert = UIAlertController(title: "Error", message: "Failed to log in", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
