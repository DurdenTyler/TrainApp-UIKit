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
    
    private var customAlertReps = CustomAlertReps()
    
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
    
    var workoutModel = WorkoutModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setContrains()
        cellConfigure()
        setDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialDarkBlue
        view.addSubview(newWorkoutLabel)
        view.addSubview(viewImage)
        view.addSubview(detailLabel)
        view.addSubview(exercicesSetsReps)
        view.addSubview(finishButton)
        view.addSubview(backButton)
        view.addSubview(customAlertReps)
        customAlertReps.isHidden = true
    }
    
    @objc private func backFuncButton() {
        dismiss(animated: true)
    }
    
    @objc private func finishFuncButton() {
        if countOfSets == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel, bool: true)
        }
    }
    
    private func setDelegates() {
        exercicesSetsReps.delegate = self
        customAlertReps.delegate = self
    }
    
    private var countOfSets = 1
    
    private func cellConfigure() {
        
        exercicesSetsReps.labelName.text = workoutModel.workoutName
        exercicesSetsReps.countOfSetsLabel.text = "\(countOfSets)/\(workoutModel.workoutSets)"
        exercicesSetsReps.countOfRepsLabel.text = "\(workoutModel.workoutReps)"
        
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
        
        NSLayoutConstraint.activate([
            customAlertReps.topAnchor.constraint(equalTo: view.topAnchor),
            customAlertReps.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customAlertReps.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customAlertReps.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - StartWorkoutButtonsProtocol
extension StartWorkoutViewController:StartWorkoutButtonsProtocol {
    func editingButton() {
        customAlertReps.isHidden = false
    }
    
    func nextButton() {
        if countOfSets < workoutModel.workoutSets {
            countOfSets += 1
            exercicesSetsReps.countOfSetsLabel.text = "\(countOfSets)/\(workoutModel.workoutSets)"
        } else {
            alertSimpleOK(title: "Конец упражнения", message: "Нажмите закончить, что бы перейти к следующему упражнению")
        }
    }
}

// MARK: - CustomAlertProtocol
extension StartWorkoutViewController:CustomAlertProtocol {
    
    func backButtonPressed() {
        customAlertReps.removeFromSuperview()
    }
    
    func saveButtonPressed() {
        guard let setsNumber = customAlertReps.setsTextField.text else { return }
        guard let repsNumber = customAlertReps.repsTextField.text else { return }
        if setsNumber != "" && repsNumber != "" {
            exercicesSetsReps.countOfSetsLabel.text = "\(countOfSets)/\(setsNumber)"
            exercicesSetsReps.countOfRepsLabel.text = "\(repsNumber)"
            guard let numbersOfSets = Int(setsNumber) else { return }
            guard let numbersOfReps = Int(repsNumber) else { return }
            RealmManager.shared.updateSetsRepsWorkoutModel(model: workoutModel, sets: numbersOfSets, reps: numbersOfReps)
            customAlertReps.removeFromSuperview()
        }
    }
}
