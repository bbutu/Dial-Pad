//
//  CollectionHeaderReusableView.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 29.12.22.
//

import UIKit

class CollectionHeaderReusableView: UICollectionReusableView {
    static let identifier = "CollectionHeaderReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = ""
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureConstraints() {
        let titleLabelConstraints = [
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
}

extension CollectionHeaderReusableView {
    func configure(with model: CollectionHeaderReusableViewModel) {
        titleLabel.text = model.title
    }
}
