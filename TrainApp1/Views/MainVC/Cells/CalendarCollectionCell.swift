//
//  CalendarCollectionCell.swift
//  TrainApp1
//
//  Created by Ivan White on 12.04.2022.
//

import UIKit

class CalendarCollectionCell:UICollectionViewCell{
    
    private let dayOfWeek:UILabel = {
        let label = UILabel()
        label.text = "Tu"
        label.font = UIFont(name: "Roboto-Bold", size: 18)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfMonth:UILabel = {
        let label = UILabel()
        label.text = "12"
        label.font = UIFont(name: "Roboto-Medium", size: 22)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.backgroundColor = .yellow
                self.dayOfWeek.textColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
                self.numberOfMonth.textColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
                self.layer.cornerRadius = 5
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
                self.layer.shadowOpacity = 0.5
                self.layer.shadowRadius = 0.7
            }else {
                self.backgroundColor = .none
                self.dayOfWeek.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.numberOfMonth.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setContrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dayOfWeek)
        self.addSubview(numberOfMonth)
    }
    
}

// MARK: - setContrains
extension CalendarCollectionCell {
    private func setContrains() {
        NSLayoutConstraint.activate([
                    dayOfWeek.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
                    dayOfWeek.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                    
                ])
                
                NSLayoutConstraint.activate([
                    numberOfMonth.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
                    numberOfMonth.centerXAnchor.constraint(equalTo: self.centerXAnchor)
                ])
    }
}
