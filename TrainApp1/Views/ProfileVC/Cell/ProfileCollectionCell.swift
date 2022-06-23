//
//  ProfileCollectionCell.swift
//  TrainApp1
//
//  Created by Ivan White on 01.06.2022.
//

import UIKit

class ProfileCollectionCell:UICollectionViewCell{
    
    private let text_TrainingName = UILabel(text: "PUSH UPS", fontName: "Roboto-Medium", fontSize: 28, textColor: .white, opacity: 1)
    
    private let text_TrainingCount = UILabel(text: "180", fontName: "Roboto-Medium", fontSize: 44, textColor: .specialYellow, opacity: 1)
    
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
        self.backgroundColor = .specialYellow
        self.layer.cornerRadius = 10
        self.addSubview(text_TrainingName)
        self.addSubview(text_TrainingCount)
        self.addShadowOnView()
    }
    
    func cellConfigure(model: ResultWorkout) {
        text_TrainingName.text = model.name
        text_TrainingCount.text = "\(model.result)"
        
        guard let count = text_TrainingName.text?.count else { return }
        if count >= 8 {
            text_TrainingName.font = UIFont(name: "Roboto-Medium", size: 18)
        }
    }
    
}

extension ProfileCollectionCell {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            text_TrainingName.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            text_TrainingName.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            text_TrainingCount.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            text_TrainingCount.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 25)
        ])
    }
}
