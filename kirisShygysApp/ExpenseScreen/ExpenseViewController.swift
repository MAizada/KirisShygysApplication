//
//  ExpenseViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//

import UIKit
import SnapKit

final class ExpenseViewController: UIViewController {
    
    weak var delegate: ExpenseViewProtocol?
    let firebaseManager = FirebaseManager.shared
    weak var updateDelegate: UpdateTableDelegate?
    
    // MARK: - UI
    
    private lazy var howMuchLabel: UILabel = {
        let label = UILabel()
        label.text = "How much?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private lazy var sumTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.font = UIFont.systemFont(ofSize: 64)
        textField.textColor = .white
        textField.isUserInteractionEnabled = false
        return textField
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
    
    private lazy var spentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Spent", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor(named: "red")
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let categories = ["Shopping", "Food", "Transportation", "Salary", "Subscription", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Navigation Bar
    
    private func setupNavigationBar() {
       
        navigationItem.title = "Expense"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "red")
        
        [howMuchLabel, sumTextField, whiteView].forEach { view.addSubview($0) }
        [categoryTextField, categoryArrowButton, descriptionTextField, spentButton].forEach { whiteView.addSubview($0) }
        
        spentButton.addTarget(self, action: #selector(spentButtonTapped), for: .touchUpInside)
        sumTextField.isUserInteractionEnabled = true
    }
    
    // MARK: - Actions
    
    @objc private func spentButtonTapped() {
        let amount = sumTextField.text ?? ""
        let category = categoryTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        guard !category.isEmpty, !amount.isEmpty else {
            return
        }
        
        let newTransaction = Transaction(
            //  image:
            title: category,
            description: description,
            amount: amount,
            time: Date(),
            date: Date(),
            type: .expense
        )
        
        firebaseManager.saveTransaction(newTransaction) { error in
            if let error = error {
            } else {
                self.sumTextField.text = ""
                self.categoryTextField.text = ""
                self.descriptionTextField.text = ""
                
                self.updateDelegate?.updateTransactions()
                self.navigationController?.dismiss(animated: true)
            }
        }
    }
    
    @objc private func categoryArrowButtonTapped() {
        print("button tapped")
        showExpenseCategoryOptions()
    }
    
    private func showExpenseCategoryOptions() {
        let alert = UIAlertController(title: "Select an Expense Category", message: nil, preferredStyle: .actionSheet)

        for category in Category.expenses {
            let action = UIAlertAction(title: category.name, style: .default) { [weak self] _ in
                self?.categoryTextField.text = category.name 
            }
            alert.addAction(action)
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = categoryArrowButton
            popoverController.sourceRect = categoryArrowButton.bounds
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        howMuchLabel.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.width.equalTo(102)
            make.height.equalTo(22)
        }
        
        sumTextField.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(16)
            make.top.equalTo(howMuchLabel.snp.bottom).offset(10)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        whiteView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(0)
            make.top.equalTo(sumTextField.snp.bottom).offset(300)
            make.bottom.equalToSuperview().inset(0)
        }
        
        categoryTextField.snp.makeConstraints { make in
            make.leading.equalTo(whiteView).offset(16)
            make.top.equalTo(whiteView).offset(38)
            make.trailing.equalTo(whiteView).offset(-16)
            make.height.equalTo(56)
        }
        
        categoryArrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryTextField)
            make.trailing.equalTo(categoryTextField).offset(-15)
        }

        
        descriptionTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(categoryTextField)
            make.top.equalTo(categoryTextField.snp.bottom).offset(16)
            make.height.equalTo(56)
        }
        
        spentButton.snp.makeConstraints { make in
            make.leading.equalTo(categoryTextField)
            make.top.equalTo(descriptionTextField.snp.bottom).offset(40)
            make.width.equalTo(categoryTextField)
            make.height.equalTo(56)
        }
    }
}

