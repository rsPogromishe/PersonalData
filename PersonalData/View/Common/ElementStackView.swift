//
//  ElementStackView.swift
//  PersonalData
//
//  Created by Снытин Ростислав on 24.10.2022.
//

import UIKit

protocol ElementStackViewDelegate: AnyObject {
    func removeView(view: ElementStackView)
}

class ElementStackView: UIView {
    weak var delegate: ElementStackViewDelegate?

    private let nameTextField: CustomTextField = {
        let field = CustomTextField()
        field.setupView(title: "Имя", placeholder: "")
        return field
    }()

    private let ageTextField: CustomTextField = {
        let field = CustomTextField()
        field.setupView(title: "Возраст", placeholder: "")
        return field
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()

    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    init(delegate: ElementStackViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupConstraints()
    }

    private func addSubviews() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameTextField)
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ageTextField)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteButton)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
    }

    private func setupConstraints() {
        addSubviews()
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            nameTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameTextField.rightAnchor.constraint(equalTo: centerXAnchor),

            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            ageTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            ageTextField.rightAnchor.constraint(equalTo: nameTextField.rightAnchor),

            deleteButton.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            deleteButton.leftAnchor.constraint(equalTo: nameTextField.rightAnchor, constant: 16),

            lineView.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 16),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.leftAnchor.constraint(equalTo: leftAnchor),
            lineView.rightAnchor.constraint(equalTo: rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    @objc func deleteButtonTapped() {
        delegate?.removeView(view: self)
    }
}
