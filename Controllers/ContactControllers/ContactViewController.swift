//
//  ContactViewController.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 10.12.22.
//

import UIKit

class ContactViewController: UIViewController {
    
    private let mobileViewstackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private let mobileViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+995 571 92 76 67", for: .normal)
        button.tintColor = .tintColor
        return button
    }()
    
//    private let mobileViewTitle: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        label.backgroundColor = .white
//        label.font = .systemFont(ofSize: 14, weight: .semibold)
//        return label
//    }()
    
    private let mobileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let contactButton: ContactReusableButtonView = {
        let button = ContactReusableButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configureWith(model: ContactReusableButtonViewModel(systemImageName: "message.fill", text: "message", isActive: true))
        return button
    }()
    
    private let phoneButton: ContactReusableButtonView = {
        let button = ContactReusableButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configureWith(model: ContactReusableButtonViewModel(systemImageName: "phone.fill", text: "mobile", isActive: true))
        return button
    }()
    
    private let facetimeButton: ContactReusableButtonView = {
        let button = ContactReusableButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configureWith(model: ContactReusableButtonViewModel(systemImageName: "video.fill", text: "FaceTime", isActive: true))
        return button
    }()
    
    private let mailButton: ContactReusableButtonView = {
        let button = ContactReusableButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configureWith(model: ContactReusableButtonViewModel(systemImageName: "envelope.fill", text: "mail", isActive: false))
        return button
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "Beka Buturishvili"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.backgroundColor = .systemGray3
        imageView.tintColor = .systemGray6
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        configureConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(personImageView)
        view.addSubview(fullNameLabel)
        view.addSubview(contactButton)
        buttonsStackView.addArrangedSubview(contactButton)
        buttonsStackView.addArrangedSubview(phoneButton)
        buttonsStackView.addArrangedSubview(facetimeButton)
        buttonsStackView.addArrangedSubview(mailButton)
        view.addSubview(buttonsStackView)
        view.addSubview(mobileView)
//        mobileViewstackView.addArrangedSubview(mobileViewTitle)
        mobileViewstackView.addArrangedSubview(mobileViewButton)
        mobileView.addSubview(mobileViewstackView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        personImageView.layer.cornerRadius = personImageView.frame.height / 2
    }
    
    private func configureConstraints() {
        let personImageViewConstraints = [
            personImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            personImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4),
            personImageView.heightAnchor.constraint(equalTo: personImageView.widthAnchor)
        ]
        
        let fullNameLabelConstraints = [
            fullNameLabel.topAnchor.constraint(equalTo: personImageView.bottomAnchor, constant: 8),
            fullNameLabel.centerXAnchor.constraint(equalTo: personImageView.centerXAnchor),
            fullNameLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.9),
        ]
        
        let buttonsStackViewConstraints = [
            buttonsStackView.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -3),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let contactButtonConstraints = [
            contactButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 2/9),
            contactButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 1),
        ]
        
        let phoneButtonConstraints = [
            phoneButton.widthAnchor.constraint(equalTo: contactButton.widthAnchor),
            phoneButton.heightAnchor.constraint(equalTo: contactButton.heightAnchor),
        ]
        
        let facetimeButtonConstraints = [
            facetimeButton.widthAnchor.constraint(equalTo: contactButton.widthAnchor),
            facetimeButton.heightAnchor.constraint(equalTo: contactButton.heightAnchor),
        ]
        
        let mailButtonConstraints = [
            mailButton.widthAnchor.constraint(equalTo: contactButton.widthAnchor),
            mailButton.heightAnchor.constraint(equalTo: contactButton.heightAnchor),
        ]
        
        let mobileViewConstraints = [
            mobileView.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            mobileView.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            mobileView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 10),
            mobileView.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor)
        ]
        
        let mobileViewstackViewConstraints = [
            mobileViewstackView.leadingAnchor.constraint(equalTo: mobileView.leadingAnchor, constant: 5),
            mobileViewstackView.trailingAnchor.constraint(equalTo: mobileView.trailingAnchor, constant: -5),
            mobileViewstackView.topAnchor.constraint(equalTo: mobileView.topAnchor, constant: 3),
            mobileViewstackView.bottomAnchor.constraint(equalTo: mobileView.bottomAnchor, constant: -3)
        ]
        
        NSLayoutConstraint.activate(personImageViewConstraints)
        NSLayoutConstraint.activate(fullNameLabelConstraints)
        NSLayoutConstraint.activate(buttonsStackViewConstraints)
        NSLayoutConstraint.activate(contactButtonConstraints)
        NSLayoutConstraint.activate(phoneButtonConstraints)
        NSLayoutConstraint.activate(facetimeButtonConstraints)
        NSLayoutConstraint.activate(mailButtonConstraints)
        NSLayoutConstraint.activate(mobileViewConstraints)
        NSLayoutConstraint.activate(mobileViewstackViewConstraints)
    }
    
    func configure(with model: ContactsTableCollectionViewCellModel) {
        self.fullNameLabel.text = model.fullName
        self.mobileViewButton.setTitle(model.phoneNumber, for: .normal)
        self.personImageView.image = model.imageData
    }
}
