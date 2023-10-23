//
//  NotificationViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 07.10.2023.
//

import UIKit
import SnapKit

final class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UI
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notification"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var notifications: [Notification] = [
        Notification(title: "Shopping budget has exceeds the..", description: "Your shopping budget has exceeds the lim...", time: "19.30"),
        Notification(title: "Utilities budget has exceeds the..", description: "Your utolities budget has exceeds the limit...", time: "19.30"),
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
        [titleLabel, backButton, moreButton, tableView].forEach { view.addSubview($0) }
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: "NotificationCell")
    }
    
    // MARK: - Actions
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func moreButtonTapped() {
        print("tapped")
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(titleLabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleLabel)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(450)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return notifications.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = NotificationTableViewCell(style: .default, reuseIdentifier: nil)
            let notification = notifications[indexPath.row]
            cell.configure(with: notification)
            return cell
        }
        return UITableViewCell()
    }
}
