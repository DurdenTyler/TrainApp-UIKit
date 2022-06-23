//
//  OnBoardingViewCell.swift
//  TrainApp1
//
//  Created by Ivan White on 08.06.2022.
//

import UIKit

class OnBoardingViewCell: UICollectionViewCell {
    
    private let image_Background: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let text_Top: UILabel = {
        let label = UILabel()
        label.textColor = .specialDarkBlue
        label.font = UIFont(name: "Roboto-Medium", size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let text_Bottom: UILabel = {
        let label = UILabel()
        label.textColor = .specialYellow
        label.font = UIFont(name: "Roboto-Medium", size: 18)
        label.textAlignment = .center
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        self.backgroundColor = .specialDarkBlue
        self.addSubview(image_Background)
        self.addSubview(text_Top)
        self.addSubview(text_Bottom)
    }
    
    func cellConfigure(slide: Slide) {
        image_Background.image = slide.image
        text_Top.text = slide.topLabel
        text_Top.font = UIFont(name: "Roboto-Medium", size: CGFloat(slide.fone_Size))
        text_Bottom.text = slide.bottomLabel
    }
}

// MARK: - setConstrains
extension OnBoardingViewCell {
    private func setConstrains() {

        NSLayoutConstraint.activate([
            image_Background.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            image_Background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            image_Background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            image_Background.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            text_Top.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            text_Top.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            text_Top.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            text_Bottom.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            text_Bottom.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            text_Bottom.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            text_Bottom.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
}
