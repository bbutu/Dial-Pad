//
//  AddContactViewController.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 10.12.22.
//

import UIKit
import PhotosUI

protocol AddContactViewControllerDelegate: AnyObject {
    func AddContactViewControllerWillDismiss(_ sender: AddContactViewController, withData data: TableModel)
}

class AddContactViewController: UIViewController {
    
    weak var delegate: AddContactViewControllerDelegate?
    
    public var data:TableModel!
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "First name"
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Last name"
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Phone number"
        textField.backgroundColor = .systemGray5
        textField.keyboardType = .phonePad
        return textField
    }()
    
    private let addPhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Photo", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
    
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .systemGray3
        imageView.tintColor = .systemGray6
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New Contact"
        label.textColor = .label
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        addButtonTargets()
        addTextfieldTargets()
        configureConstraints()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        addGestureRecognizers()
    }
    
    private func addGestureRecognizers() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        personImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUpload)))
        addPhotoButton.addTarget(self, action: #selector(didTapToUpload), for: .touchUpInside)
    }
    @objc private func didTapToUpload() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc private func didTapToDismiss() {
        view.endEditing(true)
    }
    
    @objc private func editingChanged(_ sender: UITextField) {
        handleEditing()
    }
    
    private func addTextfieldTargets() {
        firstNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    private func addButtonTargets() {
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonDidTap), for: .touchUpInside)
    }
    
    private func handleEditing() {
        if(firstNameTextField.text?.isEmpty == false || lastNameTextField.text?.isEmpty == false || phoneNumberTextField.text?.isEmpty == false ) {
            doneButton.isEnabled = true
            doneButton.alpha = 1
        } else {
            doneButton.isEnabled = false
            doneButton.alpha = 0.5
        }
    }
    
    private func addSubviews() {
        view.addSubview(cancelButton)
        view.addSubview(titleLabel)
        view.addSubview(doneButton)
        view.addSubview(personImageView)
        view.addSubview(addPhotoButton)
        textFieldsStackView.addArrangedSubview(firstNameTextField)
        textFieldsStackView.addArrangedSubview(lastNameTextField)
        textFieldsStackView.addArrangedSubview(phoneNumberTextField)
        view.addSubview(containerView)
        containerView.addSubview(textFieldsStackView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        personImageView.layer.cornerRadius = personImageView.frame.width / 2
        containerView.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstNameTextField.becomeFirstResponder()
    }
    
    @objc private func doneButtonDidTap(_ sender: UIButton) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let fullName = firstName + " " + lastName
        let phoneNumber = phoneNumberTextField.text ?? ""
        if fullName.isEmpty == false {
            let first = fullName.first?.uppercased()
            add(fullName: fullName, phoneNumber: phoneNumber,first: first!)
        }
        delegate?.AddContactViewControllerWillDismiss(self, withData: data)
        dismiss(animated: true)
    }
    
    private func add(fullName: String, phoneNumber: String, first: String) {
        let title = String(first)
        if let index = data.sections.firstIndex(where: { $0.title == title}) {
            addRow(fullName: fullName, toSection: index,phoneNumber: phoneNumber)
        }else {
            addSection(title: title, fullName: fullName, phoneNumber: phoneNumber)
        }
    }
    
    private func addSection(title: String, fullName: String, phoneNumber: String) {
        let model = ContactsTableCollectionViewCellModel(fullName: fullName, phoneNumber: phoneNumber, imageData: self.personImageView.image!)
        let section = SectionModel(title: title, cells: [model])
        data.sections.append(section)
        data.sections.sort { $0.title < $1.title }
    }
    
    private func addRow(fullName: String, toSection index: Int, phoneNumber: String) {
        data.sections[index].cells.append(ContactsTableCollectionViewCellModel(fullName: fullName, phoneNumber: phoneNumber, imageData: self.personImageView.image!))
        data.sections[index].cells.sort { $0.fullName < $1.fullName }
    }
    
    @objc private func cancelButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func configureConstraints() {
        let cancelButtonConstraints = [
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ]
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor)
        ]
        
        let doneButtonConstraints = [
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            doneButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor)
        ]
        
        let personImageViewConstraints = [
            personImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            personImageView.heightAnchor.constraint(equalTo: personImageView.widthAnchor),
            personImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40)
        ]
        
        let addPhotoButtonConstraints = [
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoButton.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 5)
        ]
        
        let textFieldsStackViewConstraints = [
            textFieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            textFieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            textFieldsStackView.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor,constant: 15)
        ]
        
        let firstNameTextFieldConstraints = [
            firstNameTextField.heightAnchor.constraint(equalToConstant: 44),
            firstNameTextField.widthAnchor.constraint(equalTo: textFieldsStackView.widthAnchor)
        ]
        
        let lastNameTextFieldConstraints = [
            lastNameTextField.heightAnchor.constraint(equalTo: firstNameTextField.heightAnchor)
        ]
        
        let phoneNumberTextFieldConstraints = [
            phoneNumberTextField.heightAnchor.constraint(equalTo: firstNameTextField.heightAnchor)
        ]
        
        let containerViewConstraints = [
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: textFieldsStackView.heightAnchor),
            containerView.topAnchor.constraint(equalTo: textFieldsStackView.topAnchor)
        ]
        
        NSLayoutConstraint.activate(cancelButtonConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(doneButtonConstraints)
        NSLayoutConstraint.activate(personImageViewConstraints)
        NSLayoutConstraint.activate(addPhotoButtonConstraints)
        NSLayoutConstraint.activate(textFieldsStackViewConstraints)
        NSLayoutConstraint.activate(firstNameTextFieldConstraints)
        NSLayoutConstraint.activate(lastNameTextFieldConstraints)
        NSLayoutConstraint.activate(phoneNumberTextFieldConstraints)
        NSLayoutConstraint.activate(containerViewConstraints)
    }

}

extension AddContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddContactViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.personImageView.image = image
                    }
                }
            }
        }
    }
}
