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
        setupPresenter()
    }
    
    private func setupPresenter() {
        presenter = ProfilePresenter()
        presenter?.view = self
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
    
    func showSettings() {
        let settingsViewController = SettingsViewController()
        settingsViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func showLogoutConfirmation() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.presenter?.logout(completion: { result in
            self?.presenter?.handleLogoutResult(result: result)
            })
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func navigateToOnboarding() {
        let onboardingViewController = OnboardingViewController()
        let navigationController = UINavigationController(rootViewController: onboardingViewController)
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
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
            showSettings()
        } else if indexPath.row == 1 {
            showLogoutConfirmation()
        }
    }
}

