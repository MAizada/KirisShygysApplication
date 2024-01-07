//
//  SettingsViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 05.12.2023.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let settingsData = ["Currency", "Language", "Notification"]
    private let currencies = ["USD", "KZ", "RB"]
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(settingsLabel)
        view.addSubview(tableView)
        
        settingsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsTableViewCell
        cell.titleLabel.text = settingsData[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSetting = settingsData[indexPath.row]
        
        switch selectedSetting {
//        case "Currency":
//            let currencySelectionVC = CurrencyViewController(currencies: currencies)
//            navigationController?.pushViewController(currencySelectionVC, animated: true)
        case "Language":
            let languageSelectionVC = LanguageViewController()
            navigationController?.pushViewController(languageSelectionVC, animated: true)
        case "Notification":
            let notificationSelectionVC = NotificationSettingsViewController()
            navigationController?.pushViewController(notificationSelectionVC, animated: true)
        default:
            break
        }
        
    }
}
