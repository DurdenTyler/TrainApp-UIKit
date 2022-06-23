//
//  ProfileElements.swift
//  TrainApp1
//
//  Created by Ivan White on 31.05.2022.
//

import UIKit
import RealmSwift

protocol ProfileElementsDelegate: AnyObject {
    func button_Editing_press()
}

class ProfileElements: UIView {
    
    weak var delegate: ProfileElementsDelegate?
    
    private let text_Profile = UILabel(text: "Профиль", fontName: "Roboto-Medium", fontSize: 24, textColor: .specialDarkBlue, opacity: 1)

    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "cinema")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let blueBlock: UIView = {
        let block = UIView()
        block.translatesAutoresizingMaskIntoConstraints = false
        block.backgroundColor = .specialDarkBlue
        block.layer.cornerRadius = 10
        return block
    }()
    
    let text_Name = UILabel(text: "Ваше Имя", fontName: "Roboto-Medium", fontSize: 26, textColor: .white, opacity: 1)
    
    let text_Height = UILabel(text: "Рост:  __ см", fontName: "Roboto-Medium", fontSize: 18, textColor: .specialDarkBlue, opacity: 1)
    
    let text_Weight = UILabel(text: "Вес:  __ кг", fontName: "Roboto-Medium", fontSize: 18, textColor: .specialDarkBlue, opacity: 1)
    
    private let text_7days = UILabel(text: "Количество повторений за последние 7 дней ->", fontSize: 14, textColor: .specialDarkBlue, opacity: 1)
    
    private let button_Editing: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.setTitle("Изменить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16)
        button.addTarget(self, action: #selector(funcButtonEditing), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstrains()
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
        self.addSubview(text_Name)
        self.addSubview(text_Height)
        self.addSubview(text_Weight)
        self.addSubview(button_Editing)
        self.addSubview(text_7days)
    }
    
    @objc private func funcButtonEditing() {
        delegate?.button_Editing_press()
    }
    
}

// MARK: - setContrains
extension ProfileElements {
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
            blueBlock.topAnchor.constraint(equalTo: userImageView.centerYAnchor),
            blueBlock.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            blueBlock.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            blueBlock.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            text_Name.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 15),
            text_Name.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            text_Height.topAnchor.constraint(equalTo: blueBlock.bottomAnchor, constant: 22),
            text_Height.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35)
        ])
        
        NSLayoutConstraint.activate([
            text_Weight.topAnchor.constraint(equalTo: blueBlock.bottomAnchor, constant: 22),
            text_Weight.leadingAnchor.constraint(equalTo: text_Height.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            button_Editing.topAnchor.constraint(equalTo: blueBlock.bottomAnchor, constant: 22),
            button_Editing.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            text_7days.topAnchor.constraint(equalTo: button_Editing.bottomAnchor, constant: 35),
            text_7days.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

