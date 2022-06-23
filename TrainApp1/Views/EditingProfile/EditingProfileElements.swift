//
//  EditingProfileElements.swift
//  TrainApp1
//
//  Created by Ivan White on 01.06.2022.
//

import UIKit
import RealmSwift

protocol EditingProfileElementsDelegate: AnyObject {
    func button_back_press()
    func button_save_press()
    func button_add_photo()
}

class EditingProfileElements: UIView {
    
    weak var delegate: EditingProfileElementsDelegate?
    
    private let text_Profile = UILabel(text: "Изменить профиль", fontName: "Roboto-Medium", fontSize: 24, textColor: .specialDarkBlue, opacity: 1)

    var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        imageView.image = UIImage(named: "cinema")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    
    private let plusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "plus.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.backgroundColor = .specialDarkBlue
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let blueBlock: UIView = {
        let block = UIView()
        block.translatesAutoresizingMaskIntoConstraints = false
        block.backgroundColor = .specialDarkBlue
        block.layer.cornerRadius = 10
        return block
    }()
    
    private let text_firstName = UILabel(text: "Имя", fontName: "Roboto-Medium", fontSize: 14, textColor: .specialDarkBlue, opacity: 1)
    
    private let textField_firstName: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .specialYellow
        field.textColor = .specialDarkBlue
        field.layer.cornerRadius = 10
        field.borderStyle = .none
        field.font = UIFont(name: "Roboto-Medium", size: 20)
        field.clearButtonMode = .always
        field.returnKeyType = .done
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        return field
    }()
    
    private let text_lastName = UILabel(text: "Фамилия", fontName: "Roboto-Medium", fontSize: 14, textColor: .specialDarkBlue, opacity: 1)
    
    private let textField_lastName: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .specialYellow
        field.textColor = .specialDarkBlue
        field.layer.cornerRadius = 10
        field.borderStyle = .none
        field.font = UIFont(name: "Roboto-Medium", size: 20)
        field.clearButtonMode = .always
        field.returnKeyType = .done
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        return field
    }()
    
    private let text_Height = UILabel(text: "Рост", fontName: "Roboto-Medium", fontSize: 14, textColor: .specialDarkBlue, opacity: 1)
    
    private let textField_Height: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .specialYellow
        field.textColor = .specialDarkBlue
        field.layer.cornerRadius = 10
        field.borderStyle = .none
        field.font = UIFont(name: "Roboto-Medium", size: 20)
        field.clearButtonMode = .always
        field.returnKeyType = .done
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    private let text_Weight = UILabel(text: "Вес", fontName: "Roboto-Medium", fontSize: 14, textColor: .specialDarkBlue, opacity: 1)
    
    private let textField_Weight: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .specialYellow
        field.textColor = .specialDarkBlue
        field.layer.cornerRadius = 10
        field.borderStyle = .none
        field.font = UIFont(name: "Roboto-Medium", size: 20)
        field.clearButtonMode = .always
        field.returnKeyType = .done
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        return field
    }()
    
    private let saveButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .specialYellow
        button.backgroundColor = .specialDarkBlue
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 24)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(funcButtonSave), for: .touchUpInside)
        return button
    }()
    
    private let backButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .specialDarkBlue
        button.backgroundColor = .specialYellow
        button.setTitle("Назад", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 24)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(funcButtonBack), for: .touchUpInside)
        return button
    }()
    
    private let localRealm = try! Realm()
    private var userArray: Results<UserModel>!
    private var userModel = UserModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstrains()
        setDelegates()
        addTaps()
        
        userArray = localRealm.objects(UserModel.self)
        
        loadUserInfo()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.addSubview(text_Profile)
        self.addSubview(blueBlock)
        self.addSubview(userImageView)
        self.addSubview(text_firstName)
        self.addSubview(textField_firstName)
        self.addSubview(text_lastName)
        self.addSubview(textField_lastName)
        self.addSubview(text_Height)
        self.addSubview(textField_Height)
        self.addSubview(text_Weight)
        self.addSubview(textField_Weight)
        self.addSubview(saveButton)
        self.addSubview(backButton)
        self.addSubview(plusImage)
    }
    
    private func setModel() {
        guard let userFirstName = textField_firstName.text else { return }
        userModel.userFirstName = userFirstName
        
        guard let userLastName = textField_lastName.text else { return }
        userModel.userLastName = userLastName
        
        guard let userHeight = textField_Height.text else { return }
        userModel.userHeight = Int(userHeight) ?? 0
        
        guard let userWeight = textField_Weight.text else { return }
        userModel.userWidth = Int(userWeight) ?? 0
        
        if userImageView.image == UIImage(systemName: "plus") {
            userModel.userImg = nil
        } else {
            guard let imageData = userImageView.image?.pngData() else { return }
            userModel.userImg = imageData
        }
    }
    
    private func saveModel() {
        if userArray.isEmpty {
            RealmManager.shared.saveUserModel(model: userModel)
        } else {
            RealmManager.shared.updateUserModel(model: userModel)
        }
        userModel = UserModel()
    }
    
    @objc private func funcButtonSave() {
        setModel()
        saveModel()
        delegate?.button_save_press()
    }
    
    @objc private func funcButtonBack() {
        delegate?.button_back_press()
    }
    
    private func setDelegates() {
        textField_firstName.delegate = self
        textField_lastName.delegate = self
        textField_Height.delegate = self
        textField_Weight.delegate = self
    }
    
    
    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.addGestureRecognizer(tapScreen)
        
        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(swipeHideKeyboard))
        swipeScreen.cancelsTouchesInView = false
        self.addGestureRecognizer(swipeScreen)
        
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(chooseThePhoto))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tapImageView)
    }
    
    private func loadUserInfo() {
        if !userArray.isEmpty {
            textField_firstName.placeholder = userArray[0].userFirstName
            textField_lastName.placeholder = userArray[0].userLastName
            textField_Height.placeholder = String(userArray[0].userHeight)
            textField_Weight.placeholder = String(userArray[0].userWidth)
            
            guard let data = userArray[0].userImg else { return }
            guard let image = UIImage(data: data) else { return }
            userImageView.image = image
            userImageView.contentMode = .scaleAspectFit
            userImageView.layer.borderWidth = 5
            userImageView.layer.borderColor = UIColor.white.cgColor
            
        }
    }
    
    @objc private func hideKeyboard() {
        self.endEditing(true)
    }
    
    @objc private func swipeHideKeyboard() {
        self.endEditing(true)
    }
    
    @objc private func chooseThePhoto() {
        delegate?.button_add_photo()
    }
    
}

// MARK: - setContrains
extension EditingProfileElements {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            text_Profile.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            text_Profile.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: text_Profile.bottomAnchor, constant: 15),
            userImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            plusImage.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor, constant: 29),
            plusImage.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor, constant: 28),
            plusImage.heightAnchor.constraint(equalToConstant: 36),
            plusImage.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            blueBlock.topAnchor.constraint(equalTo: userImageView.centerYAnchor),
            blueBlock.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            blueBlock.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            blueBlock.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            text_firstName.topAnchor.constraint(equalTo: blueBlock.bottomAnchor, constant: 40),
            text_firstName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            textField_firstName.topAnchor.constraint(equalTo: text_firstName.bottomAnchor, constant: 3),
            textField_firstName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField_firstName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textField_firstName.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            text_lastName.topAnchor.constraint(equalTo: textField_firstName.bottomAnchor, constant: 25),
            text_lastName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            textField_lastName.topAnchor.constraint(equalTo: text_lastName.bottomAnchor, constant: 3),
            textField_lastName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField_lastName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textField_lastName.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            text_Height.topAnchor.constraint(equalTo: textField_lastName.bottomAnchor, constant: 25),
            text_Height.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            textField_Height.topAnchor.constraint(equalTo: text_Height.bottomAnchor, constant: 3),
            textField_Height.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField_Height.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textField_Height.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            text_Weight.topAnchor.constraint(equalTo: textField_Height.bottomAnchor, constant: 25),
            text_Weight.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            textField_Weight.topAnchor.constraint(equalTo: text_Weight.bottomAnchor, constant: 3),
            textField_Weight.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField_Weight.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            textField_Weight.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: textField_Weight.bottomAnchor, constant: 112),
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 85),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: textField_Weight.bottomAnchor, constant: 112),
            backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -85),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}

// MARK: UITextFieldDelegate
extension EditingProfileElements: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField_firstName.resignFirstResponder()
        textField_lastName.resignFirstResponder()
        textField_Height.resignFirstResponder()
        return textField_Weight.resignFirstResponder()
    }
}
