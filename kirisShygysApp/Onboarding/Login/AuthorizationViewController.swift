//
//  AuthorizationViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.11.2023.
//

import UIKit
import SnapKit

final class AuthorizationViewController: UIViewController {
    
    let firebaseManager = FirebaseManager.shared
    var checkField = CheckField.shared
    
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

        if checkField.isValidEmail(email: emailTextField.text!) {
            
               let authData = LoginField(email: emailTextField.text!, password: passwordTextField.text!)
            
               firebaseManager.authInApp(authData) { [weak self] responce in
                   switch responce {
                       
                   case .success:
                       self?.userDefault.set(true, forKey: "isLogin")
                       if let navigationController = self?.navigationController {
                               let mainTabBarController = MainTabBarController()
                               navigationController.setViewControllers([mainTabBarController], animated: true)
                           } else {
                               let mainTabBarController = MainTabBarController()
                               self?.present(mainTabBarController, animated: true, completion: nil)
                           }


                   case .noVerify:
                       let alert = self?.alertAction("Error", "You haven't verified your email. A link has been sent to your email!")
                       let verifyButton = UIAlertAction(title: "Ok", style: .default)
                       alert?.addAction(verifyButton)
                       self?.present(alert!, animated: true)

                   case .error:
                       let alert = self?.alertAction("Error", "Email or password is incorrect")
                       let verifyButton = UIAlertAction(title: "Ok", style: .default)
                       alert?.addAction(verifyButton)
                       self?.present(alert!, animated: true)
                   }
               }
            
           } else {
               let alert = self.alertAction("Error", "Check the entered data")
               let verifyButton = UIAlertAction(title: "Ok", style: .default)
               alert.addAction(verifyButton)
               self.present(alert, animated: true)
           }
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


