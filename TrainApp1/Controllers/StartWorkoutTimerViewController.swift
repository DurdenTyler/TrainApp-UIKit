//
//  StartWorkoutTimerViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 21.04.2022.
//

import UIKit
import RealmSwift
import SwiftUI

class StartWorkoutTimerViewController: UIViewController {
    
    private let newWorkoutLabel = UILabel(text: "Тренировка", fontName: "Roboto-Medium", fontSize: 28, textColor: .white, opacity: 1)
    
    private let viewImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Ellipse")
        return image
    }()
    
    private let timerLabel = UILabel(text: "01:30", fontName: "Roboto-Medium", fontSize: 38, textColor: .white, opacity: 1)
    
    private let detailLabel = UILabel(text: "Упражнение", fontSize: 12 ,textColor: .specialYellow, opacity: 0.7)
    
    private let exercicesSetsReps = ExercicesSetsTimerView()
    
    private var customAlertTimer = CustomAlertTimer()
    
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
    
    private var durationTimer = 0
    private var numberOfSets = 0
    
    private var shapeLayer = CAShapeLayer()
    
    private var timer = Timer()
    
    override func viewDidLayoutSubviews() {
        animationCircular()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setContrains()
        cellConfigure()
        addTaps()
        setDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialDarkBlue
        view.addSubview(newWorkoutLabel)
        view.addSubview(viewImage)
        view.addSubview(timerLabel)
        view.addSubview(detailLabel)
        view.addSubview(exercicesSetsReps)
        view.addSubview(finishButton)
        view.addSubview(backButton)
        view.addSubview(customAlertTimer)
        customAlertTimer.isHidden = true
    }
    
    @objc private func backFuncButton() {
        dismiss(animated: true)
        timer.invalidate()
    }
    
    @objc private func finishFuncButton() {
        if numberOfSets == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.updateStatusWorkoutModel(model: workoutModel, bool: true)
        }
        timer.invalidate()
    }
    
    private func setDelegates() {
        exercicesSetsReps.delegate = self
        customAlertTimer.delegate = self
    }
    
    
    private func addTaps() {
        let byTap = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(byTap)
    }
    
    @objc private func startTimer() {
        exercicesSetsReps.editingButton.isEnabled = false
        exercicesSetsReps.nextSetButton.isEnabled = false
        
        if numberOfSets == workoutModel.workoutSets {
            alertSimpleOK(title: "Конец упражнения", message: "Нажмите закончить, что бы перейти к следующему упражнению")
        } else {
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func timerAction() {
        durationTimer -= 1
        print(durationTimer)
        
        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = workoutModel.workoutTimer
            numberOfSets += 1
            exercicesSetsReps.countOfSetsLabel.text = "\(numberOfSets)/\(workoutModel.workoutSets)"
            
            exercicesSetsReps.editingButton.isEnabled = true
            exercicesSetsReps.nextSetButton.isEnabled = true
        }
        
        let(min, sec) = durationTimer.convertSeconds()
        timerLabel.text = "\(min):\(sec.setZeroForSecond())"
    }
    
    
    private func cellConfigure() {
        exercicesSetsReps.labelName.text = workoutModel.workoutName
        exercicesSetsReps.countOfSetsLabel.text = "\(numberOfSets)/\(workoutModel.workoutSets)"
        let(min, sec) = workoutModel.workoutTimer.convertSeconds()
        exercicesSetsReps.countOfRepsLabel.text = "\(min) мин \(sec) сек"
        
        timerLabel.text = "\(min):\(sec.setZeroForSecond())"
        durationTimer = workoutModel.workoutTimer
    }
    
}

// MARK: - setContrains
extension StartWorkoutTimerViewController {
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
            timerLabel.centerXAnchor.constraint(equalTo: viewImage.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: viewImage.centerYAnchor)
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
            customAlertTimer.topAnchor.constraint(equalTo: view.topAnchor),
            customAlertTimer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customAlertTimer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customAlertTimer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - StartWorkoutTimerButtonsProtocol
extension StartWorkoutTimerViewController:StartWorkoutTimerButtonsProtocol {
    func editingButton() {
        customAlertTimer.isHidden = false
    }
    
    func nextButton() {
        if numberOfSets < workoutModel.workoutSets {
            numberOfSets += 1
            exercicesSetsReps.countOfSetsLabel.text = "\(numberOfSets)/\(workoutModel.workoutSets)"
        } else {
            alertSimpleOK(title: "Конец упражнения", message: "Нажмите закончить, что бы перейти к следующему упражнению")
        }
    }
}

// MARK: - CustomAlertTimerProtocol
extension StartWorkoutTimerViewController:CustomAlertTimerProtocol {
    
    func backButtonPressed() {
        customAlertTimer.removeFromSuperview()
    }
    
    func saveButtonPressed() {
        guard let setsNumber = customAlertTimer.setsTextField.text else { return }
        guard let minutesNumbers = customAlertTimer.minutesTextField.text else { return }
        guard let secondsNumbers = customAlertTimer.secondsTextField.text else { return }
        if setsNumber != "" && minutesNumbers != "" {
            exercicesSetsReps.countOfSetsLabel.text = "\(numberOfSets)/\(setsNumber)"
            exercicesSetsReps.countOfRepsLabel.text = "\(minutesNumbers) мин \(secondsNumbers) сек"
            guard let numbersOfSets = Int(setsNumber) else { return }
            guard let numbersOfMinutes = Int(minutesNumbers) else { return }
            guard let numbersOfSeconds = Int(secondsNumbers) else { return }
            let numbersOfTimer = numbersOfMinutes * 60 + numbersOfSeconds
            RealmManager.shared.updateSetsTimerWorkoutModel(model: workoutModel, sets: numbersOfSets, seconds: numbersOfTimer)
            timerLabel.text = "\(minutesNumbers):\(secondsNumbers)"
            durationTimer = workoutModel.workoutTimer
            customAlertTimer.removeFromSuperview()
        }
    }
}


// MARK: - func animationCircular
extension StartWorkoutTimerViewController {
    private func animationCircular() {
        
        let center = CGPoint(x: viewImage.frame.width / 2, y: viewImage.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circularPath = UIBezierPath(arcCenter: center, radius: 115, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = .round
        shapeLayer.strokeColor = UIColor.specialYellow.cgColor
        viewImage.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}
