//
//  ViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 05.04.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    private let userImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "cinema")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let workoutTodayLabel = UILabel(text: "Сегодняшняя тренировка", textColor: .specialDarkBlue, opacity: 0.7)
    
    private let userNameLabel = UILabel(text: "Ваше Имя", fontName: "Roboto-Medium", fontSize: 20, textColor: .specialDarkBlue, opacity: 1)
    
    /// Создаем таблицу
    private let tableView:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .none
        table.separatorStyle = .none /// что бы не было разделителя по дефолту
        table.bounces = false /// что бы нельзя было оттягивать таблицу сверху
        table.showsVerticalScrollIndicator = false
        table.delaysContentTouches = false
        return table
    }()
    
    private let noTrainingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "workout")
        return imageView
    }()
    
    /// Создаем идентификатор для ячейки таблицы
    private let idWorkoutTableViewCell = "idWorkoutTableViewCell"
    
    private let addWorkoutButton = AddWorkoutButton()

    private let calendarView = CalendarView()
    
    private let whatWeather = WhatWeather()
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    private var userArray: Results<UserModel>!
    
    
    
    /// Существуют разные методы что срабатывают в разное время загрузки экрана
    /// и вот когда срабатывает viewDidLayoutSubView у всех объектов уже определены границы
    /// Функция что доводит штрихи
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /// Здесь мы квадратный вью превращаем круг
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        noTrainingImageView.layer.cornerRadius = noTrainingImageView.frame.width / 2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setContrains()
        setDelegates()
        userArray = localRealm.objects(UserModel.self)
        getWather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWorkout(date: Date())
        tableView.reloadData()
        loadUserInfo()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(noTrainingImageView)
        view.addSubview(whatWeather)
        view.addSubview(calendarView)
        view.addSubview(userImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkoutButton)
        view.addSubview(workoutTodayLabel)
        view.addSubview(tableView)
        tableView.register(WorkoutTableCell.self, forCellReuseIdentifier: idWorkoutTableViewCell)
        addWorkoutButton.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        calendarView.cellCollectionViewDelegate = self
    }
    
    @objc private func addWorkoutButtonTapped() {
        let newWorkoutViewController = NewWorkoutViewController()
        newWorkoutViewController.modalPresentationStyle = .fullScreen /// Выбираем на весь экран или как модальное окно
        present(newWorkoutViewController, animated: true)
    }
    
    private func getWorkout(date: Date) {
        let weekday = date.getWeekdayNumber()
        let dateStart = date.starEndDate().0
        let dateEnd = date.starEndDate().1
        
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeat = true")
        let predicateUnRepeat = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnRepeat])
        
        workoutArray = localRealm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")
        // такой вот записью мы получим все записи по нашей модели WorkoutModel
        // затем эти записи мы хотим отфильтровать
        // и затем мы хотим отсортировать их по имени
        
        checkWorkouts()
        tableView.reloadData()
        // затем каждый раз перезагржаем таблицу что бы данные обновились
    }
    
    private func checkWorkouts() {
        if workoutArray.count == 0 {
            noTrainingImageView.isHidden = false
            tableView.isHidden = true
            workoutTodayLabel.text = "Никаких упражнений на сегодня нет"
        } else {
            noTrainingImageView.isHidden = true
            tableView.isHidden = false
            workoutTodayLabel.text = "Сегодняшняя тренировка"
        }
    }
    
    private func loadUserInfo() {
        if !userArray.isEmpty {
            userNameLabel.text = "\(userArray[0].userFirstName) \(userArray[0].userLastName)"
            guard let data = userArray[0].userImg else { return }
            guard let image = UIImage(data: data) else { return }
            userImageView.image = image
            userImageView.contentMode = .scaleAspectFit
            userImageView.layer.borderWidth = 5
            userImageView.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private func getWather() {
        // первое это мы получаем погоду
        NetworkDataFetch.shared.fetchWeather { [weak self] result, error in
            guard let self = self else { return }
            if let model = result {
                self.whatWeather.setWeather(model: model)
                NetworkImageRequest.shared.requestData(id: model.weather[0].icon) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let data):
                        self.whatWeather.setWeatherImage(data: data)
                    case .failure(let error):
                        print("Error \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
}

// MARK: - setContrains
extension MainViewController {
    private func setContrains() {

        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: userImageView.centerYAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 74)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            whatWeather.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 10),
            whatWeather.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            whatWeather.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            whatWeather.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 20),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
            
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            noTrainingImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 65),
            noTrainingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            noTrainingImageView.heightAnchor.constraint(equalToConstant: 300),
            noTrainingImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idWorkoutTableViewCell, for: indexPath) as? WorkoutTableCell else {
            return UITableViewCell()
        }
        let model = workoutArray[indexPath.row]
        cell.configureCell(model: model)
        cell.cellStartWorkoutDelegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        105
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            let deleteModel = self.workoutArray[indexPath.row]
            RealmManager.shared.deleteWorkoutModel(model: deleteModel)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        action.backgroundColor = .white
        action.image = UIImage(named: "delete")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

//MARK: - SelectCollectionViewItemProtocol
extension MainViewController:SelectCollectionViewItemProtocol {
    func selectItem(date: Date) {
        getWorkout(date: date)
    }
}


//MARK: - SelectCollectionViewItemProtocol
extension MainViewController:StartWorkoutProtocol {
    func startButtonTapped(model: WorkoutModel) {
        if model.workoutTimer == 0 {
            let startWorkoutVC = StartWorkoutViewController()
            startWorkoutVC.modalPresentationStyle = .fullScreen
            startWorkoutVC.workoutModel = model
            present(startWorkoutVC, animated: true)
        } else {
            let startWorkoutTimerVC = StartWorkoutTimerViewController()
            startWorkoutTimerVC.modalPresentationStyle = .fullScreen
            startWorkoutTimerVC.workoutModel = model
            present(startWorkoutTimerVC, animated: true)
        }
    }
}
