//
//  UserImageView.swift
//  TrainApp1
//
//  Created by Ivan White on 07.04.2022.
//

import UIKit


class AddWorkoutButton:UIButton {
    
    convenience init() {
        self.init(type: .system)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setContrains()
    }
    
    private let addWorkoutLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Добавить тренировку"
        label.font = UIFont(name: "Roboto-Medium", size: 11)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        return label
    }()
    
    
    private let addWorkoutImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .init(systemName: "plus")
        image.tintColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        return image
    }()
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                addWorkoutImage.alpha = 0.5
                addWorkoutLabel.alpha = 0.5
            } else {
                addWorkoutImage.alpha = 1
                addWorkoutLabel.alpha = 1
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9294117647, blue: 0, alpha: 1)
        self.layer.cornerRadius = 10
        self.addShadowOnView() /// расширение что добавляет тень которое мы написали сами
        self.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        self.addSubview(addWorkoutImage)
        self.addSubview(addWorkoutLabel)
    }
    
    @objc private func addWorkoutButtonTapped() {
        print("addWorkoutButtonTapped is working...")
    }
    
}

extension AddWorkoutButton {
    private func setContrains() {
        NSLayoutConstraint.activate([
                    addWorkoutImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                    addWorkoutImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
                    addWorkoutImage.heightAnchor.constraint(equalToConstant: 30),
                    addWorkoutImage.widthAnchor.constraint(equalToConstant: 30)
                    
                ])
                
                NSLayoutConstraint.activate([
                    addWorkoutLabel.topAnchor.constraint(equalTo: addWorkoutImage.bottomAnchor, constant: 6),
                    addWorkoutLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
                    addWorkoutLabel.widthAnchor.constraint(equalToConstant: 65)
                    
                ])
    }
}
