//
//  ProfileViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 31.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let proflieElements = ProfileElements()
    
    private let trainingsCollection:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .none
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    private let idTrainingsCollectionCell = "idTrainingsCollectionCell"
    
    private let text_Target = UILabel(text: "Цель: 20 тренировок", fontName: "Roboto-Medium", fontSize: 18, textColor: .specialDarkBlue, opacity: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
        setDelegates()
    }
    
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(proflieElements)
        view.addSubview(trainingsCollection)
        trainingsCollection.register(ProfileCollectionCell.self, forCellWithReuseIdentifier: idTrainingsCollectionCell)
        view.addSubview(text_Target)
    }
    
    
    private func setDelegates() {
        trainingsCollection.delegate = self
        trainingsCollection.dataSource = self
        proflieElements.delegate = self
    }
}

// MARK: - setConstrains
extension ProfileViewController {
    private func setConstrains() {

        NSLayoutConstraint.activate([
            proflieElements.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            proflieElements.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            proflieElements.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            proflieElements.heightAnchor.constraint(equalToConstant: 260)
        ])
        
        NSLayoutConstraint.activate([
            trainingsCollection.topAnchor.constraint(equalTo: proflieElements.bottomAnchor, constant: 25),
            trainingsCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            trainingsCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            trainingsCollection.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        NSLayoutConstraint.activate([
            text_Target.topAnchor.constraint(equalTo: trainingsCollection.bottomAnchor, constant: 20),
            text_Target.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15)
        ])
    }
}

// MARK: - ProfileViewController:UICollectionViewDataSource
extension ProfileViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idTrainingsCollectionCell, for: indexPath) as? ProfileCollectionCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: trainingsCollection.frame.width / 2.2, height: trainingsCollection.frame.height / 2.2)
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

