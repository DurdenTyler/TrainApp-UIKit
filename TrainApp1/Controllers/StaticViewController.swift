//
//  StaticViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 14.04.2022.
//

import UIKit
import RealmSwift
import SwiftUI

class StaticViewController: UIViewController {
    
    private let staticsLabel = UILabel(text: "Статистика", fontName: "Roboto-Medium", fontSize: 28, textColor: .specialDarkBlue, opacity: 1)
    
    private let symbol_Question:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .specialDarkBlue
        button.setImage(UIImage(systemName: "person.fill.questionmark"), for: .normal )
        button.addTarget(self, action: #selector(func_symbol_Quest), for: .touchUpInside)
        return button
    }()
    
    private let segControl:UISegmentedControl = {
        let titles = ["Неделя", "Месяц"]
        let seg = UISegmentedControl(items: titles)
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.selectedSegmentIndex = 0
        
        seg.backgroundColor = .specialDarkBlue
        seg.selectedSegmentTintColor = .specialYellow
        
        seg.setTitleTextAttributes([.foregroundColor : UIColor.specialDarkBlue], for: .selected)
        seg.setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
        
        seg.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
        return seg
    }()
    
    private let exercicesLabel = UILabel(text: "Упражнения",textColor: .specialDarkBlue, opacity: 0.7)
    
    private let tableStaticView:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .none
        table.separatorStyle = .none
        table.bounces = false
        table.showsVerticalScrollIndicator = false
        table.delaysContentTouches = false
        return table
    }()
    
    private let nameTextField:UITextField = {
        let field = UITextField()
        field.backgroundColor = .specialYellow
        field.placeholder = "Поиск"
        field.textColor = .specialDarkBlue
        field.layer.cornerRadius = 8
        field.borderStyle = .none
        field.font = UIFont(name: "Roboto-Medium", size: 20)
        field.clearButtonMode = .always
        field.returnKeyType = .done
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let idStaticTableViewCell = "idStaticTableViewCell"
    
    private let localRealm = try! Realm()
    
    private var workoutArray: Results<WorkoutModel>!
    
    private var differenceArray = [DifferenceWorkout]()
    
    private var filtredArray = [DifferenceWorkout]()
    
    private var isFiltred = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setContrains()
        setDelegates()
        setStartScreen()
        addTaps()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        differenceArray = [DifferenceWorkout]()
        setStartScreen()
        tableStaticView.reloadData()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(staticsLabel)
        view.addSubview(segControl)
        view.addSubview(exercicesLabel)
        view.addSubview(tableStaticView)
        view.addSubview(nameTextField)
        view.addSubview(symbol_Question)
        tableStaticView.register(StaticTableCell.self, forCellReuseIdentifier: idStaticTableViewCell)
    }
    
    
    private func setDelegates() {
        tableStaticView.dataSource = self
        tableStaticView.delegate = self
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
    
    @objc private func segmentChange() {
        
        let dateToday = Date().localDate()
        differenceArray = [DifferenceWorkout]()
        
        if segControl.selectedSegmentIndex == 0 {
            let dateStart = dateToday.offsetDays(days: 7)
            getDifferenceModel(dateStart: dateStart)
        }else {
            let dateStart = dateToday.offsetMonth(month: 1)
            getDifferenceModel(dateStart: dateStart)
        }
        
        tableStaticView.reloadData()
    }
    
    
    private func getWorkoutNames() -> [String] {
        var namesArray = [String]()
        workoutArray = localRealm.objects(WorkoutModel.self)
        
        for workoutModel in workoutArray {
            if !namesArray.contains(workoutModel.workoutName) {
                namesArray.append(workoutModel.workoutName)
            }
        }
        
        return namesArray
    }
    
    private func getDifferenceModel(dateStart: Date) {
        let dateEnd = Date().localDate()
        let namesArray = getWorkoutNames()
        
        for name in namesArray {
            let predicateDifference = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateDifference).sorted(byKeyPath: "workoutDate")
            
            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else {
                      return
                  }
            
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first)
            differenceArray.append(differenceWorkout)
        }
    }
    
    private func setStartScreen() {
        let dateStart = Date().localDate()
        getDifferenceModel(dateStart: dateStart.offsetDays(days: 7))
        tableStaticView.reloadData()
    }
    
    private func filtringArray(text: String) {
        for i in differenceArray {
            if i.name.lowercased().contains(text.lowercased()) {
                filtredArray.append(i)
            }
        }
    }
    
    @objc private func func_symbol_Quest() {
        alertSimpleOK(title: "Статистика?", message: "Здесь вы можете увидеть прогресс или регресс количества повторений в упражнении")
    }
    
}

// MARK: - setContrains
extension StaticViewController {
    private func setContrains() {
        NSLayoutConstraint.activate([
            staticsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            staticsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            symbol_Question.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            symbol_Question.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            symbol_Question.heightAnchor.constraint(equalToConstant: 50),
            symbol_Question.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            segControl.topAnchor.constraint(equalTo: staticsLabel.bottomAnchor, constant: 20),
            segControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            segControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: segControl.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            exercicesLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            exercicesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tableStaticView.topAnchor.constraint(equalTo: exercicesLabel.bottomAnchor, constant: 5),
            tableStaticView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableStaticView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableStaticView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
    }
}

// MARK: - UITableViewDataSource
extension StaticViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltred ? filtredArray.count : differenceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idStaticTableViewCell, for: indexPath) as?
                StaticTableCell else {
                    return UITableViewCell()
                }
        let differenceWorkout = isFiltred ? filtredArray[indexPath.row] : differenceArray[indexPath.row]
        cell.configureCell(differenceWorkout: differenceWorkout)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension StaticViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
}

// MARK: UITextFieldDelegate
extension StaticViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            filtredArray = [DifferenceWorkout]()
            isFiltred = updatedText.count > 0
            filtringArray(text: updatedText)
            tableStaticView.reloadData()
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        isFiltred = false
        differenceArray = [DifferenceWorkout]()
        
        if segControl.selectedSegmentIndex == 0 {
            let dateToday = Date().localDate()
            getDifferenceModel(dateStart: dateToday.offsetDays(days: 7))
        }else {
            let dateToday = Date().localDate()
            getDifferenceModel(dateStart: dateToday.offsetMonth(month: 1))
        }
        tableStaticView.reloadData()
        return true
    }
}
