//
//  ProfileViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 31.05.2022.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    
    private let localRealm = try! Realm()
    
    private var resultWorkout = [ResultWorkout]()
    private var userArray: Results<UserModel>!
    
    private let proflieElements = ProfileElements()
    
    
    private let trainingsCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .none
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private var workoutArray: Results<WorkoutModel>!
    
    private let idTrainingsCollectionCell = "idTrainingsCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
        setDelegates()
        userArray = localRealm.objects(UserModel.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultWorkout = [ResultWorkout]()
        getWorkoutGeneralCount()
        trainingsCollection.reloadData()
        loadUserInfo()
    }
    
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(proflieElements)
        view.addSubview(trainingsCollection)
        trainingsCollection.register(ProfileCollectionCell.self, forCellWithReuseIdentifier: idTrainingsCollectionCell)
    }
    
    
    private func setDelegates() {
        trainingsCollection.delegate = self
        trainingsCollection.dataSource = self
        proflieElements.delegate = self
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
    
    private func getWorkoutGeneralCount() {
        let dateEnd = Date().localDate()
        let dateStart = Date().localDate().offsetDays(days: 7)
        let namesArray = getWorkoutNames()
        
        for name in namesArray {
            let predicateName = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateName).sorted(byKeyPath: "workoutName")
            var result = 0
            var image: Data?
            workoutArray.forEach { model in
                result += model.workoutReps * model.workoutSets
                image = model.workoutImg
            }
            
            let resultModel = ResultWorkout(name: name, result: result, imageData: image)
            resultWorkout.append(resultModel)
        }
    }
    
    private func loadUserInfo() {
        if !userArray.isEmpty {
            proflieElements.text_Name.text = "\(userArray[0].userFirstName) \(userArray[0].userLastName)"
            proflieElements.text_Height.text = "Рост: \(userArray[0].userHeight) см"
            proflieElements.text_Weight.text = "Вес: \(userArray[0].userWidth) кг"
            
            guard let data = userArray[0].userImg else { return }
            guard let image = UIImage(data: data) else { return }
            proflieElements.userImageView.image = image
            proflieElements.userImageView.contentMode = .scaleAspectFit
            proflieElements.userImageView.layer.borderWidth = 5
            proflieElements.userImageView.layer.borderColor = UIColor.white.cgColor
        }
    }
}

// MARK: - setConstrains
extension ProfileViewController {
    private func setConstrains() {

        NSLayoutConstraint.activate([
            proflieElements.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            proflieElements.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            proflieElements.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            proflieElements.heightAnchor.constraint(equalToConstant: 320)
        ])
        
        NSLayoutConstraint.activate([
            trainingsCollection.topAnchor.constraint(equalTo: proflieElements.bottomAnchor, constant: 50),
            trainingsCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            trainingsCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            trainingsCollection.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
}

// MARK: - ProfileViewController:UICollectionViewDataSource
extension ProfileViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultWorkout.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idTrainingsCollectionCell, for: indexPath) as? ProfileCollectionCell else {
            return UICollectionViewCell()
        }
        let model = resultWorkout[indexPath.row]
        cell.cellConfigure(model: model)
        cell.backgroundColor = (indexPath.row % 4 == 0 || indexPath.row % 4 == 3 ? .specialDarkBlue : .specialRed)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: trainingsCollection.frame.width / 2.2, height: trainingsCollection.frame.height / 2.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}

// MARK: - ProfileElementsDelegate
extension ProfileViewController: ProfileElementsDelegate {
    
    func button_Editing_press() {
        let editingProfileVC = EditingProfileViewController()
        editingProfileVC.modalPresentationStyle = .fullScreen
        present(editingProfileVC, animated: true)
    }
}

