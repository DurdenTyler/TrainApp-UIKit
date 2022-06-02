//
//  ProfileCollectionCell.swift
//  TrainApp1
//
//  Created by Ivan White on 01.06.2022.
//

import UIKit

class ProfileCollectionCell:UICollectionViewCell{
    
    private let text_TrainingName = UILabel(text: "PUSH UPS", fontName: "Roboto-Medium", fontSize: 28, textColor: .specialDarkBlue, opacity: 1)
    
    private let imageTable:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        image.image = UIImage(named: "testWorkout")?.withRenderingMode(.alwaysTemplate)
        return image
    }()
    
    private let text_TrainingCount = UILabel(text: "180", fontName: "Roboto-Medium", fontSize: 44, textColor: .specialDarkBlue, opacity: 1)
    
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
        self.addSubview(imageTable)
        self.addSubview(text_TrainingCount)
    }
    
}

extension ProfileCollectionCell {
    private func setConstrains() {
        NSLayoutConstraint.activate([
            text_TrainingName.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            text_TrainingName.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            imageTable.topAnchor.constraint(equalTo: text_TrainingName.bottomAnchor, constant: 15),
            imageTable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 13)
        ])
        
        NSLayoutConstraint.activate([
            text_TrainingCount.topAnchor.constraint(equalTo: text_TrainingName.bottomAnchor, constant: 15),
            text_TrainingCount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -13)
        ])
    }
}
