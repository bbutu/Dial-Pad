//
//  ReusableButtonView.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 02.12.22.
//

import UIKit

class ReusableButtonView: UIView {
    
    public var number: String = ""
    
    private let centerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.numberOfLines = 1
        label.tintColor = .black
        return label
    }()
    
    private let secondaryLabel: UILabel? = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        label.tintColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        addSubview(centerView)
        centerView.addSubview(numberLabel)
        if secondaryLabel != nil {
            centerView.addSubview(secondaryLabel!)
        }
        configureConstraints()
    }
    
    private func configureConstraints() {
        let centerViewConstraints = [
            centerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            centerView.heightAnchor.constraint(equalTo: centerView.widthAnchor, multiplier: 1 / 1)
        ]
        
        let numberLabelConstraints = [
            numberLabel.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            numberLabel.topAnchor.constraint(equalTo: centerView.topAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerView.centerYAnchor, constant: -10)
        ]
        
        let secondaryLabelConstraints = [
            secondaryLabel!.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            secondaryLabel!.topAnchor.constraint(equalTo: numberLabel.bottomAnchor),
           // secondaryLabel!.bottomAnchor.constraint(equalTo: centerView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(centerViewConstraints)
        NSLayoutConstraint.activate(numberLabelConstraints)
        NSLayoutConstraint.activate(secondaryLabelConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: ReusableButtonViewModel) {
        self.numberLabel.text = model.number
        self.secondaryLabel?.text = model.secondaryText
        self.number = model.number
    }
    
}
