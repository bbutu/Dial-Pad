//
//  ContactReusableButtonView.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 13.12.22.
//

import UIKit

class ContactReusableButtonView: UIView {
    
    private var button: UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.image = UIImage(systemName: "message.fill")
        button.tintColor = .tintColor
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private var buttonTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .tintColor
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(buttonTitle)
        addSubview(stackView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
    }
    
    private func configureConstraints() {
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ]
        let buttonConstraints = [
            button.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6),
            button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    func configureWith(model: ContactReusableButtonViewModel) {
        self.button.image = UIImage(systemName: "\(model.systemImageName)")
        self.buttonTitle.text = model.text
        if(model.isActive == false) {
            self.button.tintColor = .systemGray
            self.button.alpha = 0.7
            self.buttonTitle.textColor = .systemGray
            self.button.alpha = 0.7
        }
    }
}
