//
//  CustomTextField.swift
//  PersonalData
//
//  Created by Снытин Ростислав on 24.10.2022.
//

import UIKit

class CustomTextField: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        return label
    }()

    private let textField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 24)
        field.textColor = .black
        return field
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 6
        setupConstraints()
    }

    private func addSubviews() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
    }

    private func setupConstraints() {
        addSubviews()
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 14),

            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            textField.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: 10),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    func setupView(title: String, placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
    }

    func clearTextField() {
        textField.text = ""
    }
}
