//
//  StartWorkoutControllerView.swift
//  TrainApp1
//
//  Created by Ivan White on 21.04.2022.
//

import UIKit
import RealmSwift

class StartWorkoutViewController: UIViewController {
    
    private let newWorkoutLabel = UILabel(text: "Тренировка", fontName: "Roboto-Medium", fontSize: 28, textColor: .white, opacity: 1)
    
    private let viewImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "GirlTraining")
        return image
    }()
    
    private let detailLabel = UILabel(text: "Упражнение", fontSize: 12 ,textColor: .specialYellow, opacity: 0.7)
    
    private let exercicesSetsReps = ExercicesSetsRepsView()
    
    private let finishButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .specialDarkBlue
        button.backgroundColor = .specialYellow
        button.setTitle("Закончить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(finishFuncButton), for: .touchUpInside)
        return button
    }()
    
    private let backButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .specialDarkBlue
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(backFuncButton), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setContrains()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialDarkBlue
        view.addSubview(newWorkoutLabel)
        view.addSubview(viewImage)
        view.addSubview(detailLabel)
        view.addSubview(exercicesSetsReps)
        view.addSubview(finishButton)
        view.addSubview(backButton)
    }
    
    @objc private func backFuncButton() {
        dismiss(animated: true)
    }
    
    @objc private func finishFuncButton() {
        ///
    }
    
}

// MARK: - setContrains
extension StartWorkoutViewController {
    private func setContrains() {
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            viewImage.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 30),
            viewImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: viewImage.bottomAnchor, constant: 15),
            detailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            exercicesSetsReps.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 5),
            exercicesSetsReps.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            exercicesSetsReps.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            exercicesSetsReps.heightAnchor.constraint(equalToConstant: 290)
        ])
        
        NSLayoutConstraint.activate([
            finishButton.topAnchor.constraint(equalTo: exercicesSetsReps.bottomAnchor, constant: 40),
            finishButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            finishButton.widthAnchor.constraint(equalToConstant: 120),
            finishButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: exercicesSetsReps.bottomAnchor, constant: 40),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 120),
            backButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
