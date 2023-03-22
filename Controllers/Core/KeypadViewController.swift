//
//  KeypadViewController.swift
//  Dial Pad
//
//  Created by Beka Buturishvili on 02.12.22.
//

import UIKit

class KeypadViewController: UIViewController {
    private var buttonViewsConstraints: [NSLayoutConstraint] = []
    
    private var buttonViews: [ReusableButtonView] = []
    
    private let buttonViewModels: [ReusableButtonViewModel] = [
        ReusableButtonViewModel(number: "1", secondaryText: ""),
        ReusableButtonViewModel(number: "2", secondaryText: "ABC"),
        ReusableButtonViewModel(number: "3", secondaryText: "DEF"),
        ReusableButtonViewModel(number: "4", secondaryText: "GHI"),
        ReusableButtonViewModel(number: "5", secondaryText: "JKL"),
        ReusableButtonViewModel(number: "6", secondaryText: "MNO"),
        ReusableButtonViewModel(number: "7", secondaryText: "PQRS"),
        ReusableButtonViewModel(number: "8", secondaryText: "TUV"),
        ReusableButtonViewModel(number: "9", secondaryText: "WXYZ"),
        ReusableButtonViewModel(number: "*", secondaryText: ""),
        ReusableButtonViewModel(number: "0", secondaryText: "+"),
        ReusableButtonViewModel(number: "#", secondaryText: ""),
    ]
    
    private let numberPadParentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private let numberPadFirstLineButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let numberPadSecondLineButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let numberPadThirdLineButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let numberPadFourthLineButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let addNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Number", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.font = button.titleLabel?.font.withSize(20)
        return button
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 30, weight: .bold)
        textField.text = "(+995) "
        textField.textColor = .label
        return textField
    }()
    
    private let backspaceButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemGray3
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        return button
    }()
    
    private let callButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.setImage(UIImage(systemName: "phone.fill"), for: .normal)
        return button
    }()
    
    @objc func didTapReusableButton(_ sender: UITapGestureRecognizer) {
        DispatchQueue.main.async { [weak self] in
            if let tapped = sender.view as? ReusableButtonView {
                self?.phoneTextField.text = (self?.phoneTextField.text)! + tapped.number
                UIView.animate(withDuration: 0.15, delay: 0) {
                    tapped.layer.opacity = 0.4
                }completion: { _ in
                    tapped.layer.opacity = 1
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(callButton)
        view.addSubview(backspaceButton)
        view.addSubview(phoneTextField)
        view.addSubview(addNumberButton)
        
        configureButtons()
        
        addButtonsToStackView(to: numberPadFirstLineButtonsStackView, startIndex: 0, endIndex: 2)
        addButtonsToStackView(to: numberPadSecondLineButtonsStackView, startIndex: 3, endIndex: 5)
        addButtonsToStackView(to: numberPadThirdLineButtonsStackView, startIndex: 6, endIndex: 8)
        addButtonsToStackView(to: numberPadFourthLineButtonsStackView, startIndex: 9, endIndex: 11)
        
        numberPadParentStackView.addArrangedSubview(numberPadFirstLineButtonsStackView)
        numberPadParentStackView.addArrangedSubview(numberPadSecondLineButtonsStackView)
        numberPadParentStackView.addArrangedSubview(numberPadThirdLineButtonsStackView)
        numberPadParentStackView.addArrangedSubview(numberPadFourthLineButtonsStackView)
        
        view.addSubview(numberPadParentStackView)
        
        phoneTextField.delegate = self
        backspaceButton.addTarget(self, action: #selector(didTapBackspaceButton), for: .touchUpInside)
        addNumberButton.addTarget(self, action: #selector(didTapAddNumberButton), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(didTapCallButton), for: .touchUpInside)
        configureConstraints()
    }
    
    @objc private func didTapCallButton(_ sender: UIButton) {
        let vc = PhoneCallViewController()
        vc.modalPresentationStyle = .overFullScreen
        navigationController?.present(vc, animated: true)
    }
    
    private func addButtonsToStackView(to stackView: UIStackView, startIndex: Int, endIndex: Int) {
        for (i,reusableButtonView) in buttonViews.enumerated() {
            if(i >= startIndex && i <= endIndex){
                reusableButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapReusableButton)))
                stackView.addArrangedSubview(reusableButtonView)
            }
        }
    }
    
    private func configureButtons() {
        buttonViewModels.forEach { ReusableButtonViewModel in
            let button = ReusableButtonView()
            button.configure(with: ReusableButtonViewModel)
            buttonViews.append(button)
        }
    }
    
    @objc private func didTapAddNumberButton(_ sender: UIButton) {
        let vc = AddNumberViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapBackspaceButton(_ sender: UIButton) {
        if(phoneTextField.text!.count > 0) {
            self.phoneTextField.text = String(phoneTextField.text!.dropLast(1))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        callButton.layer.cornerRadius = callButton.frame.width / 2
    }
    
    private func configureConstraints() {
        let callButtonConstraints = [
            callButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            callButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            callButton.heightAnchor.constraint(equalTo: callButton.widthAnchor, multiplier: 1 / 1)

        ]
        
        let backspaceButtonConstraints = [
            backspaceButton.leadingAnchor.constraint(equalTo: callButton.trailingAnchor, constant: 45),
            backspaceButton.centerYAnchor.constraint(equalTo: callButton.centerYAnchor),
            backspaceButton.widthAnchor.constraint(equalToConstant: 44),
            backspaceButton.heightAnchor.constraint(equalToConstant: 44)
        ]
        
        let phoneTextFieldConstraints = [
            phoneTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let addNumberButtonConstraints = [
            addNumberButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor,constant: 10),
            addNumberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]

        let firstButtonConstraints = [
            buttonViews[0].widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            buttonViews[0].heightAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1 / 1)
        ]
        
        let secondButtonConstraints = [
            buttonViews[1].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[1].heightAnchor.constraint(equalTo: buttonViews[1].widthAnchor, multiplier: 1 / 1)
        ]
        
        let thirdButtonConstraints = [
            buttonViews[2].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[2].heightAnchor.constraint(equalTo: buttonViews[2].widthAnchor, multiplier: 1 / 1)
        ]
        
        let fourthButtonConstraints = [
            buttonViews[3].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[3].heightAnchor.constraint(equalTo: buttonViews[3].widthAnchor, multiplier: 1 / 1)
        ]
        
        let fifthButtonConstraints = [
            buttonViews[4].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[4].heightAnchor.constraint(equalTo: buttonViews[4].widthAnchor, multiplier: 1 / 1)
        ]
        
        let sixthButtonConstraints = [
            buttonViews[5].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[5].heightAnchor.constraint(equalTo: buttonViews[5].widthAnchor, multiplier: 1 / 1)
        ]
        
        let seventhButtonConstraints = [
            buttonViews[6].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[6].heightAnchor.constraint(equalTo: buttonViews[6].widthAnchor, multiplier: 1 / 1)
        ]
        
        let eigthsButtonConstraints = [
            buttonViews[7].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[7].heightAnchor.constraint(equalTo: buttonViews[7].widthAnchor, multiplier: 1 / 1)
        ]
        
        let ninethButtonConstraints = [
            buttonViews[8].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[8].heightAnchor.constraint(equalTo: buttonViews[8].widthAnchor, multiplier: 1 / 1)
        ]
        
        let tenthButtonConstraints = [
            buttonViews[9].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[9].heightAnchor.constraint(equalTo: buttonViews[9].widthAnchor, multiplier: 1 / 1)
        ]
        
        let eleventhButtonConstraints = [
            buttonViews[10].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[10].heightAnchor.constraint(equalTo: buttonViews[10].widthAnchor, multiplier: 1 / 1)
        ]
        
        let twelvethButtonConstraints = [
            buttonViews[11].widthAnchor.constraint(equalTo: buttonViews[0].widthAnchor, multiplier: 1),
            buttonViews[11].heightAnchor.constraint(equalTo: buttonViews[11].widthAnchor, multiplier: 1 / 1)
        ]
        
        let numberPadParentStackViewConstraints = [
            numberPadParentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            numberPadParentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            numberPadParentStackView.topAnchor.constraint(equalTo: addNumberButton.bottomAnchor,constant: 15),
            numberPadParentStackView.bottomAnchor.constraint(equalTo: callButton.topAnchor,constant: -15),
         //   numberPadParentStackView.heightAnchor.constraint(lessThanOrEqualToConstant: 400)
        ]
        
        NSLayoutConstraint.activate(callButtonConstraints)
        NSLayoutConstraint.activate(backspaceButtonConstraints)
        NSLayoutConstraint.activate(phoneTextFieldConstraints)
        NSLayoutConstraint.activate(addNumberButtonConstraints)
        NSLayoutConstraint.activate(firstButtonConstraints)
        NSLayoutConstraint.activate(secondButtonConstraints)
        NSLayoutConstraint.activate(thirdButtonConstraints)
        NSLayoutConstraint.activate(fourthButtonConstraints)
        NSLayoutConstraint.activate(fifthButtonConstraints)
        NSLayoutConstraint.activate(sixthButtonConstraints)
        NSLayoutConstraint.activate(seventhButtonConstraints)
        NSLayoutConstraint.activate(eigthsButtonConstraints)
        NSLayoutConstraint.activate(ninethButtonConstraints)
        NSLayoutConstraint.activate(tenthButtonConstraints)
        NSLayoutConstraint.activate(eleventhButtonConstraints)
        NSLayoutConstraint.activate(twelvethButtonConstraints)
        NSLayoutConstraint.activate(numberPadParentStackViewConstraints)
    }

}

extension KeypadViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneTextField.resignFirstResponder()
        return true
    }
}
