//
//  ContactsTableViewCell.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 10.12.22.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    static let identifier = "ContactsTableViewCell"
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.text = ""
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        stackView.addArrangedSubview(fullNameLabel)
        stackView.addArrangedSubview(phoneNumberLabel)
        addSubview(stackView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureConstraints() {
//        let fullNameLabelConstraints = [
//            fullNameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
//            fullNameLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: -20)
//        ]
//
//        let phoneNumberLabelConstraints = [
//            phoneNumberLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
//            phoneNumberLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: -20)
//        ]
        
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
//        NSLayoutConstraint.activate(fullNameLabelConstraints)
//        NSLayoutConstraint.activate(phoneNumberLabelConstraints)
    }

}

extension ContactsTableViewCell {
    func configure(with model: ContactsTableCollectionViewCellModel) {
        self.fullNameLabel.text = model.fullName
        self.phoneNumberLabel.text = model.phoneNumber
    }
}
