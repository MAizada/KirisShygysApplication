//
//  ProfileViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 03.09.2023.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfileViewProtocol {
    
    
    var presenter: ProfilePresenterProtocol?
    
    // MARK: - UI
    private lazy var avatarImage: UIImageView = {
        let image =  UIImageView()
        image.image = UIImage(systemName: "person")
        image.contentMode = .left
        image.layer.cornerRadius = 25
        return image
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "editButton"), for: .normal)
        button.tintColor = .black
        button.contentMode = .center
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.layer.cornerRadius = 5
        return table
    }()
    
    private let settingsData: [SettingsItem] = [
        SettingsItem(image: UIImage(named: "settings")!, title: "Settings"),
        SettingsItem(image: UIImage(named: "logout")!, title: "Logout")
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        getUserName()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        [avatarImage, usernameLabel, additionalInfoLabel, editButton, tableView].forEach { view.addSubview($0) }
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
    }
    
    @objc private func editButtonTapped() {
        print("editButtonTapped")
    }
    
    //MARK: - Get Usaername
    
    private func getUserName() {
        FirebaseManager.shared.getUsername { [weak self] username in
               guard let username = username else { return }
               self?.additionalInfoLabel.text = username
           }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(40)
            make.width.height.equalTo(75)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalTo(avatarImage.snp.trailing).offset(20)
        }
        
        additionalInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.leading.equalTo(avatarImage.snp.trailing).offset(20)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(additionalInfoLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(90)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! ProfileTableViewCell
        let item = settingsData[indexPath.row]
        cell.iconImageView.image = item.image
        cell.titleLabel.text = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let settingsViewController = SettingsViewController()
            settingsViewController.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(settingsViewController, animated: true)
        } else if indexPath.row == 1 {
            let confirmationView = ConfirmationView(frame: CGRect(x: 0, y: view.frame.height - 400, width: UIScreen.main.bounds.width, height: 200))
            confirmationView.delegate = self
            view.addSubview(confirmationView)
        }
    }
}

extension ProfileViewController: ConfirmationViewDelegate {
    
    func presentCustomView(_ customView: UIView) {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alertController.view.addSubview(customView)
            let height = NSLayoutConstraint(item: alertController.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
            alertController.view.addConstraint(height)
            
            let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
                if let confirmationView = customView as? ConfirmationView {
                    confirmationView.delegate?.didConfirmLogout()
                }
            }
            alertController.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: "No", style: .cancel) { _ in
                if let confirmationView = customView as? ConfirmationView {
                    confirmationView.delegate?.didCancelLogout()
                }
            }
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    
    func didConfirmLogout() {
        print("Confirmed logout")
        FirebaseManager.shared.Logout { error in
            if let error = error {
                print("Error signing out: \(error.localizedDescription)")
                // Обработка ошибки, если необходимо
            } else {
                print("Logout successful")
                let onboardingViewController = OnboardingViewController()
                onboardingViewController.navigationItem.hidesBackButton = true
                UIApplication.shared.windows.first?.rootViewController = onboardingViewController
            }
        }
    }
    
    func didCancelLogout() {
        if let confirmationView = view.subviews.first(where: { $0 is ConfirmationView }) {
            confirmationView.removeFromSuperview()
            print("Cancelled logout")
        }
    }
}

