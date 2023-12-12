//
//  OnboardingViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 21.11.2023.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - Views
    
    private  lazy var onboardingImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 25
        return image
    }()
    
    private lazy var label1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var label2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor(named: "brown")
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = 3
        return pageControl
    }()
    
    private let descriptions = [
        [
            "Gain total control of your money",
            "Become your own money manager and make every cent count"
        ],
        [
            "Know where your money goes",
            "Track your transaction easily, with categories and financial report"
        ],
        [
            "Planning ahead\n\n",
            "Setup your budget for each category so you in control"
        ]
    ]
    
    private let imageNames = [
        "Illustration1",
        "Illustration2",
        "Illustration3"
    ]
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = UIColor(named: "brown")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(named: "lightBrown")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
        [onboardingImage, label1, label2, pageControl, signUpButton, loginButton].forEach { view.addSubview($0) }
        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        updateContent(for: 0)
    }
    
    // MARK: - Actions
    
    @objc private func signUpButtonTapped() {
        let registrationVC = RegistrationViewController()
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    @objc private func loginButtonTapped() {
        let authVC = AuthorizationViewController()
        navigationController?.pushViewController(authVC, animated: true)
    }
    
    @objc private func pageChanged() {
        updateContent(for: pageControl.currentPage)
    }
    
    private func updateContent(for index: Int) {
        label1.text = descriptions[index][0]
        label2.text = descriptions[index][1]
        onboardingImage.image = UIImage(named: imageNames[index])
    }
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        onboardingImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.width.height.equalTo(312)
        }
        
        label1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(onboardingImage.snp.bottom).offset(10)
            make.width.equalTo(300)
        }
        
        label2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label1.snp.bottom).offset(10)
            make.width.equalTo(300)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label2.snp.bottom).offset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginButton.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(56)
            
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(56)
        }
    }
}
