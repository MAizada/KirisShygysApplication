//
//  EditViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.01.2024.
//

import UIKit
import SnapKit

final class EditViewController: UIViewController {
    
    var presenter: EditPresenterProtocol?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(avatarTapped)))
        return imageView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save Changes", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "lightBrown")
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        [avatarImageView, nameTextField, saveButton].forEach { view.addSubview($0) }
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView).offset(130)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextField).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        
    }
    
    private func updateProfileInfo(name: String, avatar: UIImage?) {
        nameTextField.text = name
        avatarImageView.image = avatar
    }
    
    @objc private func avatarTapped() {
        
    }
    
    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text else { return }
        let avatar = avatarImageView.image
        presenter?.saveChanges(name: name, avatar: avatar)
    }
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc private func avatarTap() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            avatarImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
