//
//  ThemeViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 08.12.2023.
//

import UIKit
import SnapKit

class ThemeViewController: UIViewController {

    private let themeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Light", "Dark"])
        segmentedControl.selectedSegmentIndex = 0 
        segmentedControl.addTarget(self, action: #selector(themeChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose theme"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupThemeControl()
        setupTitleLabel()
    }

    private func setupThemeControl() {
        view.addSubview(themeSegmentedControl)
        themeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        themeSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(themeSegmentedControl.snp.leading).offset(-10)
        }
    }
    
    @objc private func themeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // Установка светлой темы
            overrideUserInterfaceStyle = .light
            setLightTheme() // Функция для установки светлой темы
        case 1:
            // Установка темной темы
            overrideUserInterfaceStyle = .dark
            setDarkTheme() // Функция для установки темной темы
        default:
            break
        }
    }

    private func setLightTheme() {
        // Настройки для светлой темы
        view.backgroundColor = .white
        // Другие настройки для светлой темы
    }

    private func setDarkTheme() {
        // Настройки для темной темы
        view.backgroundColor = .black
        // Другие настройки для темной темы
    }

}
