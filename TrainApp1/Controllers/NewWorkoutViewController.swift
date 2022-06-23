//
//  NewWorkoutViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 18.04.2022.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    
    private let newWorkoutLabel = UILabel(text: "Новая тренировка", fontName: "Roboto-Medium", fontSize: 28, textColor: .white, opacity: 1)
    
    private let nameLabel = UILabel(text: "Название", fontSize: 12 ,textColor: .specialYellow, opacity: 0.7)
    
    private let nameTextField:UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.textColor = .specialDarkBlue
        field.layer.cornerRadius = 8
        field.borderStyle = .none
        field.font = UIFont(name: "Roboto-Medium", size: 20)
        field.clearButtonMode = .always
        field.returnKeyType = .done /// Кнопка синего цвета на экранной клаве done
        
        /// Что бы был небольшой отступ у правого края при начале ввода
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let imgButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .specialDarkBlue
        button.backgroundColor = .specialYellow
        button.setTitle("Изображение", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 14)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(imgFuncButton), for: .touchUpInside)
        return button
    }()
    
    private let dateLabel = UILabel(text: "Дата и напоминание", fontSize: 12, textColor: .specialYellow, opacity: 0.7)
    
    private let dateAndRepeatView = DateAndRepeatView()
    
    private let timerLabel = UILabel(text: "Повторения или время", fontSize: 12, textColor: .specialYellow, opacity: 0.7)
    
    private let repsOrTimer = RepsOrTimerView()
    
    private var workoutModel = WorkoutModel()
    
    private var testImage = UIImage(named: "dumbbell")
    
    private let saveButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .specialDarkBlue
        button.backgroundColor = .specialYellow
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(saveFuncButton), for: .touchUpInside)
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
        setDelegates()
        setContrains()
        addTaps()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialDarkBlue
        view.addSubview(newWorkoutLabel)
        view.addSubview(nameLabel)
        view.addSubview(imgButton)
        view.addSubview(dateLabel)
        view.addSubview(nameTextField)
        view.addSubview(dateAndRepeatView)
        view.addSubview(timerLabel)
        view.addSubview(repsOrTimer)
        view.addSubview(saveButton)
        view.addSubview(backButton)
    }
    
    private func setDelegates() {
        nameTextField.delegate = self
    }
    
    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapScreen)
        
        let swipeScreen = UISwipeGestureRecognizer(target: self, action: #selector(swipeHideKeyboard))
        swipeScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeScreen)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func swipeHideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func backFuncButton() {
        dismiss(animated: true)
    }
    
    private func setModel() {
        guard let nameWorkout = nameTextField.text else { return }
        workoutModel.workoutName = nameWorkout
        
        let dateFromPicker = dateAndRepeatView.setDateAndRepeat().0
        workoutModel.workoutDate = dateFromPicker.localDate()
        workoutModel.workoutNumberOfDay = dateFromPicker.getWeekdayNumber()
        
        workoutModel.workoutRepeat = dateAndRepeatView.setDateAndRepeat().1
        workoutModel.workoutSets = repsOrTimer.setDateAndRepeat().0
        workoutModel.workoutReps = repsOrTimer.setDateAndRepeat().1
        workoutModel.workoutTimer = repsOrTimer.setDateAndRepeat().2
        
        guard let imageData = testImage?.pngData() else { return }
        workoutModel.workoutImg = imageData
    }
    
    private func saveModel() {
        guard let text = nameTextField.text else { return }
        let textCount = text.filter {$0.isNumber || $0.isLetter}.count
        
        if textCount != 0 && (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            RealmManager.shared.saveWorkoutModel(model: workoutModel)
            createNotifications()
            // Самое важное что нам нужно создать уведмлоние выше строки что ниже
            workoutModel = WorkoutModel()
            alertSimpleOK(title: "Успешно", message: nil)
            refreshObjects()
        }else {
            alertSimpleOK(title: "Ошибка", message: "Заполните данные")
        }
    }
    
    @objc private func saveFuncButton() {
        setModel()
        saveModel()
    }
    
    private func refreshObjects() {
        dateAndRepeatView.refreshDatepickerAndSwitch()
        repsOrTimer.refreshAllSlidersAndLabels()
        nameTextField.text = ""
        testImage = UIImage(named: "dumbbell")
    }
    
    private func createNotifications() {
        // создаем уведомление
        let notifications = Notifications()
        // получаем строку нашей даты
        let stringDate = workoutModel.workoutDate.ddMMyyyyFromDate()
        // далее вызываю метод наше расписание
        notifications.scheduleDateNotifications(date: workoutModel.workoutDate, id: "workout" + stringDate)
    }
    
    @objc private func imgFuncButton() {
        alertPhotoOrCamera { [weak self] source in
            guard let self = self else { return }
            self.chooseImagePicker(source: source)
        }
    }
    
}

// MARK: - setContrains
extension NewWorkoutViewController {
    private func setContrains() {
        NSLayoutConstraint.activate([
            newWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: newWorkoutLabel.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalToConstant: 220),
            nameTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            imgButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            imgButton.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 10),
            imgButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            imgButton.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            dateAndRepeatView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            dateAndRepeatView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateAndRepeatView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dateAndRepeatView.heightAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: dateAndRepeatView.bottomAnchor, constant: 40),
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            repsOrTimer.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 5),
            repsOrTimer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            repsOrTimer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            repsOrTimer.heightAnchor.constraint(equalToConstant: 293)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: repsOrTimer.bottomAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            saveButton.widthAnchor.constraint(equalToConstant: 120),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: repsOrTimer.bottomAnchor, constant: 40),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 120),
            backButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}


// MARK: UITextFieldDelegate
extension NewWorkoutViewController:UITextFieldDelegate {
    // этот метод срабатывает когда мы нажимаем на клавиатуре на готово
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder() // типо убираем с основного плана
    }
}


// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension NewWorkoutViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // что будем выбирать, камеру или галлерею
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    // Этот метод срабатывает когда мы закрываем imagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        testImage = image
        imgButton.setTitle("Изображение выбрано", for: .normal)
        imgButton.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 10)
        dismiss(animated: true)
    }
}
