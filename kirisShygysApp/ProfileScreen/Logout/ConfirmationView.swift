//
//  ConfirmationView.swift
//  kirisShygysApp
//
//  Created by Aizada on 05.12.2023.
//

//import UIKit
//
//class ConfirmationView: UIView {
//
//    var onConfirm: (() -> Void)?
//    var onCancel: (() -> Void)?
//
//    private lazy var messageLabel: UILabel = {
//            let label = UILabel()
//            label.textAlignment = .center
//            label.font = UIFont.systemFont(ofSize: 16)
//            label.numberOfLines = 0
//            label.textColor = .white // Цвет текста сообщения
//            label.text = "Are you sure you want to logout?"
//            return label
//        }()
//
////    private lazy var titleLabel: UILabel = {
////        let label = UILabel()
////        label.textAlignment = .center
////        label.font = UIFont.boldSystemFont(ofSize: 18)
////        label.numberOfLines = 0
////        label.text = "Are you sure you want to logout?"
////        return label
////    }()
//
////    private lazy var yesButton: UIButton = {
////        let button = UIButton()
////        button.setTitle("Yes", for: .normal)
////        button.setTitleColor(.systemBlue, for: .normal)
////        button.backgroundColor = UIColor(named: "brown")
////        button.layer.cornerRadius = 10
////        button.setTitleColor(.white, for: .normal)
////        button.addTarget(self, action: #selector(confirmLogout), for: .touchUpInside)
////        return button
////    }()
////
////    private lazy var noButton: UIButton = {
////        let button = UIButton()
////        button.setTitle("No", for: .normal)
////        button.setTitleColor(.systemBlue, for: .normal)
////        button.backgroundColor = UIColor(named: "lightBrown")
////        button.layer.cornerRadius = 10
////        button.setTitleColor(.white, for: .normal)
////        button.addTarget(self, action: #selector(cancelLogout), for: .touchUpInside)
////        return button
////    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupViews()
//    }
//
//    private func setupViews() {
//        backgroundColor = UIColor(named: "linearGradient")
//        layer.cornerRadius = 20
//
//        addSubview(messageLabel)
////        addSubview(yesButton)
////        addSubview(noButton)
//
//        messageLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(15)
//            make.leading.trailing.equalToSuperview().inset(20)
//        }
//
////        yesButton.snp.makeConstraints { make in
////            make.top.equalTo(titleLabel.snp.bottom).offset(15)
////            make.leading.equalToSuperview().offset(20)
////            make.bottom.equalToSuperview().inset(20)
////            make.width.equalTo(160)
////            make.height.equalTo(50)
////        }
////
////        noButton.snp.makeConstraints { make in
////            make.top.equalTo(titleLabel.snp.bottom).offset(15)
////            make.trailing.equalToSuperview().offset(-20)
////            make.bottom.equalToSuperview().inset(20)
////            make.width.equalTo(160)
////            make.height.equalTo(50)
////        }
//    }
//
//    @objc private func confirmLogout() {
//        onConfirm?()
//    }
//
//    @objc private func cancelLogout() {
//        onCancel?()
//    }
//
////    func setOnConfirm(_ closure: (() -> Void)?) {
////        onConfirm = closure
////    }
////
////    func setOnCancel(_ closure: (() -> Void)?) {
////        onCancel = closure
////    }
//}
