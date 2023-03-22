//
//  PhoneCallViewController.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 02.12.22.
//

import UIKit

class PhoneCallViewController: UIViewController {
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        configureConstraints()
    }
    
    @objc private func didTapCloseButton(_ sender: UIButton) {
        DispatchQueue.main.async {[weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    private func configureConstraints(){
        let closeButtonConstraints = [
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ]
        NSLayoutConstraint.activate(closeButtonConstraints)
    }
}
