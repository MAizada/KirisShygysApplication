//
//  IncomeViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//

import UIKit
import SnapKit

final class IncomeViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var howMuchLabel: UILabel = {
        let label = UILabel()
        label.text = "How much?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.text = "0$"
        label.font = UIFont.systemFont(ofSize: 64)
        label.textColor = .white
        return label
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Category"
        textField.borderStyle = .roundedRect
        
        textField.rightView = categoryArrowButton
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var categoryArrowButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrowDown"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(categoryArrowButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var earnedButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Earned", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(named: "green")
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Navigation Bar
    
    private func setupNavigationBar() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.title = "Income"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "green")
        
        [howMuchLabel, sumLabel, whiteView].forEach { view.addSubview($0) }
        [categoryTextField, categoryArrowButton, descriptionTextField, earnedButton].forEach { whiteView.addSubview($0) }
        
        earnedButton.addTarget(self, action: #selector(earnedButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func earnedButtonTapped() {
        print("Earned button tapped")
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func categoryArrowButtonTapped() {
        print("button tapped")
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        howMuchLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.width.equalTo(102)
            make.height.equalTo(22)
        }
        
        sumLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(16)
            make.top.equalTo(howMuchLabel.snp.bottom).offset(10)
            make.width.equalTo(102)
            make.height.equalTo(50)
        }
        
        whiteView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(0)
            make.top.equalTo(sumLabel.snp.bottom).offset(300)
            make.bottom.equalToSuperview().inset(0)
        }
        
        categoryTextField.snp.makeConstraints { make in
            make.leading.equalTo(whiteView).offset(16)
            make.top.equalTo(whiteView).offset(38)
            make.trailing.equalTo(whiteView).offset(-16)
            make.height.equalTo(56)
        }
        
        categoryArrowButton.snp.makeConstraints { make in
            make.trailing.equalTo(categoryTextField).inset(-15)
            
        }
        
        descriptionTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(categoryTextField)
            make.top.equalTo(categoryTextField.snp.bottom).offset(16)
            make.height.equalTo(56)
        }
        
        earnedButton.snp.makeConstraints { make in
            make.leading.equalTo(categoryTextField)
            make.top.equalTo(descriptionTextField.snp.bottom).offset(40)
            make.width.equalTo(categoryTextField)
            make.height.equalTo(56)
        }
    }
}

