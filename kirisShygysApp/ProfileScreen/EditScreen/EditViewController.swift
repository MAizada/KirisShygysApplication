//
//  EditViewController.swift
//  kirisShygysApp
//
//  Created by Aizada on 23.01.2024.
//

import UIKit
import SnapKit

final class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var onSave: ((String, UIImage?) -> Void)?
    var presenter: ProfilePresenterProtocol
    
    init(presenter: ProfilePresenterProtocol) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
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
    
    private var avatarImage: UIImage? {
        didSet {
            avatarImageView.image = avatarImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        [avatarImageView, nameTextField].forEach { view.addSubview($0) }
        setUpConstraints()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    private func setUpConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(180)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView).offset(200)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    @objc private func avatarTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        print("Save Info")
    
        guard let name = nameTextField.text else { return }
               onSave?(name, avatarImage)
        presenter.updateProfileInfo(name: name, avatar: avatarImage)
               dismiss(animated: true, completion: nil)
           }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            avatarImage = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
