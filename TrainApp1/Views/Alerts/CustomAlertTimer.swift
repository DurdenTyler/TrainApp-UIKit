//
//  CustomAlertTimer.swift
//  TrainApp1
//
//  Created by Ivan White on 20.05.2022.
//

import UIKit

protocol CustomAlertTimerProtocol: AnyObject {
    func backButtonPressed()
    func saveButtonPressed()
}

class CustomAlertTimer:UIView {
    
    let whiteBlock:UIView = {
        let block = UIView()
        block.translatesAutoresizingMaskIntoConstraints = false
        block.backgroundColor = .white
        block.layer.cornerRadius = 10
        return block
    }()
    
    private let imageBlock:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "GirlRun")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let editingLabel = UILabel(text: "Изменить", fontName: "Roboto-Medium", fontSize: 22, textColor: .specialDarkBlue, opacity: 1)
    
    private let setsLabel = UILabel(text: "Подходы", fontName: "Roboto-Medium", fontSize: 28, textColor: .specialDarkBlue, opacity: 1)
    
    let setsTextField:UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .specialDarkBlue
        field.textColor = .specialYellow
        field.layer.cornerRadius = 10
        field.borderStyle = .none
        field.font = UIFont(name: "Roboto-Medium", size: 28)
        field.clearButtonMode = .always
        field.returnKeyType = .done
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    private let repsLabel = UILabel(text: "Время", fontName: "Roboto-Medium", fontSize: 28, textColor: .specialDarkBlue, opacity: 1)
    
    private let MLabel = UILabel(text: "м", fontName: "Roboto-Medium", fontSize: 28, textColor: .specialDarkBlue, opacity: 1)
    
    private let SLabel = UILabel(text: "с", fontName: "Roboto-Medium", fontSize: 28, textColor: .specialDarkBlue, opacity: 1)
    
    let minutesTextField:UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .specialDarkBlue
        field.textColor = .specialYellow
        field.layer.cornerRadius = 10
        field.borderStyle = .none
        field.font = UIFont(name: "Roboto-Medium", size: 28)
        field.clearButtonMode = .always
        field.returnKeyType = .done
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    let secondsTextField:UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .specialDarkBlue
        field.textColor = .specialYellow
        field.layer.cornerRadius = 10
        field.borderStyle = .none
        field.font = UIFont(name: "Roboto-Medium", size: 28)
        field.clearButtonMode = .always
        field.returnKeyType = .done
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    private let backButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .specialDarkBlue
        button.setTitle("Назад", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(backFuncButton), for: .touchUpInside)
        return button
    }()
    
    private let saveButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .specialDarkBlue
        button.backgroundColor = .specialYellow
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveFuncButton), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: CustomAlertTimerProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .specialDarkBlue.withAlphaComponent(0.7)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(whiteBlock)
        self.addSubview(imageBlock)
        self.addSubview(editingLabel)
        self.addSubview(setsLabel)
        self.addSubview(setsTextField)
        self.addSubview(repsLabel)
        self.addSubview(minutesTextField)
        self.addSubview(MLabel)
        self.addSubview(secondsTextField)
        self.addSubview(SLabel)
        self.addSubview(backButton)
        self.addSubview(saveButton)
    }
    
    @objc private func backFuncButton() {
        delegate?.backButtonPressed()
    }
    
    @objc private func saveFuncButton() {
        delegate?.saveButtonPressed()
    }
}

// MARK: - setContrains
extension CustomAlertTimer {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            whiteBlock.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            whiteBlock.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -90),
            whiteBlock.heightAnchor.constraint(equalToConstant: 430),
            whiteBlock.widthAnchor.constraint(equalToConstant: 370)
        ])
        
        NSLayoutConstraint.activate([
            imageBlock.centerXAnchor.constraint(equalTo: whiteBlock.centerXAnchor),
            imageBlock.topAnchor.constraint(equalTo: whiteBlock.topAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            setsLabel.centerXAnchor.constraint(equalTo: whiteBlock.centerXAnchor, constant: -108),
            setsLabel.topAnchor.constraint(equalTo: imageBlock.bottomAnchor, constant: 27)
        ])
        
        NSLayoutConstraint.activate([
            setsTextField.centerXAnchor.constraint(equalTo: whiteBlock.centerXAnchor, constant: 95),
            setsTextField.topAnchor.constraint(equalTo: imageBlock.bottomAnchor, constant: 18),
            setsTextField.heightAnchor.constraint(equalToConstant: 50),
            setsTextField.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            repsLabel.leadingAnchor.constraint(equalTo: whiteBlock.leadingAnchor, constant: 18),
            repsLabel.topAnchor.constraint(equalTo: setsLabel.bottomAnchor, constant: 42)
        ])
        
        NSLayoutConstraint.activate([
            minutesTextField.leadingAnchor.constraint(equalTo: repsLabel.trailingAnchor, constant: 8),
            minutesTextField.topAnchor.constraint(equalTo: setsLabel.bottomAnchor, constant: 37),
            minutesTextField.heightAnchor.constraint(equalToConstant: 50),
            minutesTextField.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            MLabel.leadingAnchor.constraint(equalTo: minutesTextField.trailingAnchor, constant: 12),
            MLabel.topAnchor.constraint(equalTo: setsLabel.bottomAnchor, constant: 42)
        ])
        
        NSLayoutConstraint.activate([
            secondsTextField.leadingAnchor.constraint(equalTo: MLabel.trailingAnchor, constant: 8),
            secondsTextField.topAnchor.constraint(equalTo: setsLabel.bottomAnchor, constant: 37),
            secondsTextField.heightAnchor.constraint(equalToConstant: 50),
            secondsTextField.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            SLabel.leadingAnchor.constraint(equalTo: secondsTextField.trailingAnchor, constant: 12),
            SLabel.topAnchor.constraint(equalTo: setsLabel.bottomAnchor, constant: 42)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: repsLabel.bottomAnchor, constant: 35),
            backButton.centerXAnchor.constraint(equalTo: whiteBlock.centerXAnchor, constant: -65),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: repsLabel.bottomAnchor, constant: 35),
            saveButton.centerXAnchor.constraint(equalTo: whiteBlock.centerXAnchor, constant: 65),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 120)
        ])
   }
}
