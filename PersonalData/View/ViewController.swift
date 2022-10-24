//
//  ViewController.swift
//  PersonalData
//
//  Created by Снытин Ростислав on 24.10.2022.
//

import UIKit

class ViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        label.text = "Персональные данные"
        return label
    }()

    private let nameTextField: CustomTextField = {
        let field = CustomTextField()
        field.setupView(title: "Имя", placeholder: "Введите Ваше имя")
        return field
    }()

    private let ageTextField: CustomTextField = {
        let field = CustomTextField()
        field.setupView(title: "Возраст", placeholder: "Введите Ваш возраст")
        return field
    }()

    private let childrenLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        label.text = "Дети (макс.5)"
        return label
    }()

    private let childrenStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()

    lazy var addChildrenButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("Добавить ребенка", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.configuration?.contentInsets.leading = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(addChildrenButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var clearAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }

    @objc func addChildrenButtonTapped() {
        if childrenStackView.arrangedSubviews.count < 5 {
            let view = ElementStackView(delegate: self)
            childrenStackView.addArrangedSubview(view)
        }
        if childrenStackView.arrangedSubviews.count == 5 {
            addChildrenButton.isHidden = true
        }
    }

    @objc func clearAllButtonTapped() {
        let action = UIAlertController(
            title: "Сброс данных",
            message: "Вы уверены, что хотите сбросить данные?",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.nameTextField.clearTextField()
            self.ageTextField.clearTextField()
            self.childrenStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            self.addChildrenButton.isHidden = false
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        action.addAction(okAction)
        action.addAction(cancelAction)
        present(action, animated: true)
    }
}

// - MARK: Delegate

extension ViewController: ElementStackViewDelegate {
    func removeView(view: ElementStackView) {
        if let first = self.childrenStackView.arrangedSubviews.first(where: { $0 === view }) {
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    first.isHidden = true
                    first.removeFromSuperview()
                }, completion: { (_) in
                    self.view.layoutIfNeeded()
                }
            )
        }
        if childrenStackView.arrangedSubviews.count != 5 {
            addChildrenButton.isHidden = false
        }
    }
}

// - MARK: Setup UI

extension ViewController {
    private func addSubviews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)

        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(headerLabel)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameTextField)
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(ageTextField)
        childrenLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childrenLabel)
        addChildrenButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(addChildrenButton)
        childrenStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childrenStackView)
        clearAllButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(clearAllButton)
    }

    private func setupConstraints() {
        addSubviews()

        let constraintWidth = NSLayoutConstraint(
                item: addChildrenButton,
                attribute: .width,
                relatedBy: .equal,
                toItem: childrenLabel,
                attribute: .width,
                multiplier: 1,
                constant: 0
        )
        constraintWidth.priority = .defaultHigh

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            headerLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),

            nameTextField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            nameTextField.leftAnchor.constraint(equalTo: headerLabel.leftAnchor),
            nameTextField.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),

            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            ageTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            ageTextField.rightAnchor.constraint(equalTo: nameTextField.rightAnchor),

            childrenLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            childrenLabel.leftAnchor.constraint(equalTo: ageTextField.leftAnchor),

            addChildrenButton.centerYAnchor.constraint(equalTo: childrenLabel.centerYAnchor),
            addChildrenButton.leftAnchor.constraint(lessThanOrEqualTo: childrenLabel.rightAnchor, constant: 14),
            constraintWidth,
            addChildrenButton.rightAnchor.constraint(equalTo: ageTextField.rightAnchor),
            addChildrenButton.heightAnchor.constraint(equalToConstant: 48),

            childrenStackView.topAnchor.constraint(equalTo: childrenLabel.bottomAnchor, constant: 20),
            childrenStackView.leftAnchor.constraint(equalTo: childrenLabel.leftAnchor),
            childrenStackView.rightAnchor.constraint(equalTo: addChildrenButton.rightAnchor),

            clearAllButton.topAnchor.constraint(equalTo: childrenStackView.bottomAnchor, constant: 20),
            clearAllButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 100),
            clearAllButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -100),
            clearAllButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            clearAllButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
