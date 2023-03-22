//
//  ContactsCollectionViewCell.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 27.12.22.
//

import UIKit

class ContactsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ContactsCollectionViewCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
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
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.addArrangedSubview(personImageView)
        stackView.addArrangedSubview(fullNameLabel)
        stackView.addArrangedSubview(phoneNumberLabel)
        addSubview(stackView)
        configureConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 1
        layer.cornerRadius = 15
        personImageView.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureConstraints() {
        let personImageViewConstraints = [
            personImageView.widthAnchor.constraint(equalToConstant: 40),
            personImageView.heightAnchor.constraint(equalTo: personImageView.widthAnchor)
        ]
        
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor,constant: frame.height / 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -(frame.height / 10))
        ]
        
        NSLayoutConstraint.activate(personImageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
        
    }
    
}

extension ContactsCollectionViewCell {
    func configure(with model: ContactsTableCollectionViewCellModel) {
        self.fullNameLabel.text = model.fullName
        self.phoneNumberLabel.text = model.phoneNumber
        self.personImageView.image = model.imageData
    }
}
