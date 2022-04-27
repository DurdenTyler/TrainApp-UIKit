//
//  ExercicesSetsAndTimer.swift
//  TrainApp1
//
//  Created by Ivan White on 21.04.2022.
//

import UIKit

class ExercicesSetsTimerView:UIView {
    
    private let labelName = UILabel(text: "Планка", fontName: "Roboto-Medium", fontSize: 24, textColor: .specialDarkBlue, opacity: 1)
    
    private let setsLabel = UILabel(text: "Подходы", fontName: "Roboto-Medium", fontSize: 20, textColor: .specialDarkBlue, opacity: 1)
    
    private let countOfSetsLabel = UILabel(text: "1/4", fontName: "Roboto-Medium", fontSize: 20, textColor: .specialDarkBlue, opacity: 1)
    
    private let stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let sepView:UIView = {
        let sepView = UIView()
        sepView.translatesAutoresizingMaskIntoConstraints = false
        sepView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return sepView
    }()
    
    private let repsLabel = UILabel(text: "Время подхода", fontName: "Roboto-Medium", fontSize: 20, textColor: .specialDarkBlue, opacity: 1)
    
    private let countOfRepsLabel = UILabel(text: "1 мин 30 сек", fontName: "Roboto-Medium", fontSize: 20, textColor: .specialDarkBlue, opacity: 1)
    
    private let stackView2:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let sepView2:UIView = {
        let sepView = UIView()
        sepView.translatesAutoresizingMaskIntoConstraints = false
        sepView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return sepView
    }()
    
    private let editingButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.setTitle("Изменить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 14)
        button.addTarget(self, action: #selector(editingFuncButton), for: .touchUpInside)
        return button
    }()
    
    private let nextSetButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .specialYellow
        button.backgroundColor = .specialDarkBlue
        button.setTitle("Следующий подход", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextSetFuncButton), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.addSubview(labelName)
        self.addSubview(stackView)
        stackView.addArrangedSubview(setsLabel)
        stackView.addArrangedSubview(countOfSetsLabel)
        self.addSubview(sepView)
        self.addSubview(stackView2)
        stackView2.addArrangedSubview(repsLabel)
        stackView2.addArrangedSubview(countOfRepsLabel)
        self.addSubview(sepView2)
        self.addSubview(editingButton)
        self.addSubview(nextSetButton)
    }
    
    @objc private func editingFuncButton() {
        ///
    }
    
    @objc private func nextSetFuncButton() {
        ///
    }
}

// MARK: - setContrains
extension ExercicesSetsTimerView {
    private func setContrains() {
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            sepView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
            sepView.heightAnchor.constraint(equalToConstant: 1),
            sepView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            sepView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackView2.topAnchor.constraint(equalTo: sepView.bottomAnchor, constant: 30),
            stackView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            sepView2.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 4),
            sepView2.heightAnchor.constraint(equalToConstant: 1),
            sepView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            sepView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: sepView2.bottomAnchor, constant: 13),
            editingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 25),
            nextSetButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextSetButton.heightAnchor.constraint(equalToConstant: 50),
            nextSetButton.widthAnchor.constraint(equalToConstant: 200)
        ])
   }
}

