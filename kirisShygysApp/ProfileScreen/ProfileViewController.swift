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
        label.text = "Kiris Shygys"
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
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        [avatarImage, usernameLabel, additionalInfoLabel, editButton, tableView].forEach { view.addSubview($0) }
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
    }
    
    @objc private func editButtonTapped() {
        print("editButtonTapped")
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
            make.top.equalTo(additionalInfoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(20)
            make.height.equalTo(200)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsTableViewCell
        let item = settingsData[indexPath.row]
        cell.iconImageView.image = item.image
        cell.titleLabel.text = item.title
        return cell
    }
}




