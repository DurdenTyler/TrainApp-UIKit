//
//  WorkoutTableViewCell.swift
//  TrainApp1
//
//  Created by Ivan White on 13.04.2022.
//

import UIKit

class WorkoutTableCell:UITableViewCell {
    
    private let backgroundCell:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let backgroundImage:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let imageTable:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        return image
    }()
    
    
    private let labelOne = UILabel(text: "Отжимания", fontName: "Roboto-Medium", fontSize: 21, textColor: .white, opacity: 1)
    
    private let labelTwo = UILabel(text: "Повторений: 10", fontName: "Roboto-Medium", fontSize: 15, textColor: .white, opacity: 0.8)
    
    private let labelThree = UILabel(text: "Подходов: 4", fontName: "Roboto-Medium", fontSize: 15, textColor: .white, opacity: 0.8)
    
    
    private let workoutButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addShadowOnView()
        button.tintColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9294117647, blue: 0, alpha: 1)
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(myFn), for: .touchUpInside)
        return button
    }()
    
    var stackView = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setContrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none /// чтоб ячейка ни как не выделялась
        self.addSubview(backgroundCell)
        self.addSubview(backgroundImage)
        self.addSubview(imageTable)
        self.addSubview(labelOne)
        stackView = UIStackView(arrangedSubviews: [labelTwo, labelThree], axis: .horizontal, spacing: 10)
        self.addSubview(stackView)
        contentView.addSubview(workoutButton)

    }
    
    @objc private func myFn() {
        print("addWorkoutButtonTapped is working...")
    }
    
    private func cellConfigure(model: WorkoutModel) {
        
        labelOne.text = model.workoutName
        
        let (min, sec) = { (secs:Int)-> (Int, Int) in
            return (secs / 60, secs % 60)}(Int(model.workoutTimer))
        
        labelTwo.text = model.workoutTimer == 0 ? "Повторы: \(model.workoutReps)" : "Время: \(min) мин \(sec) сек"
        labelThree.text = "Повторы: \(model.workoutSets)"
        
        if model.workoutStatus {
            workoutButton.setTitle("Выполнено", for: .normal)
            workoutButton.tintColor = .specialYellow
            workoutButton.backgroundColor = .specialDarkBlue
            workoutButton.isEnabled = false
        } else {
            workoutButton.setTitle("Начать", for: .normal)
            workoutButton.tintColor = .specialDarkBlue
            workoutButton.backgroundColor = .specialYellow
            workoutButton.isEnabled = true
        }
        
        guard let imageData = model.workoutImg else { return }
        guard let image = UIImage(data: imageData) else { return }
        
        imageTable.image = image.withRenderingMode(.alwaysTemplate)
    }
    
    public func configureCell(model: WorkoutModel) {
        cellConfigure(model: model)
    }
    
}

// MARK: - setContrains
extension WorkoutTableCell {
    private func setContrains() {
        NSLayoutConstraint.activate([
                    backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                    backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                    backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                    backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
                ])
        
        NSLayoutConstraint.activate([
                    backgroundImage.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 7),
                    backgroundImage.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 7),
                    backgroundImage.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -7),
                    backgroundImage.widthAnchor.constraint(equalToConstant: 85)
                ])
        
        NSLayoutConstraint.activate([
                    imageTable.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 5),
                    imageTable.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 5),
                    imageTable.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -5),
                    imageTable.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -5)
                ])
        
        NSLayoutConstraint.activate([
                    labelOne.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 6),
                    labelOne.leadingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: 9)
                ])
        
        NSLayoutConstraint.activate([
                    stackView.topAnchor.constraint(equalTo: labelOne.bottomAnchor, constant: 5),
                    stackView.leadingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: 9)
                ])
        
        NSLayoutConstraint.activate([
                    workoutButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 7),
                    workoutButton.leadingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: 10),
                    workoutButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
                    workoutButton.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -7)
                ])
    }
}
