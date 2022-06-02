//
//  EditingProfileViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 01.06.2022.
//

import UIKit

class EditingProfileViewController: UIViewController {
    
    private let editingProfileElements = EditingProfileElements()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
        setDelegates()
    }
    
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(editingProfileElements)
    }
    
    private func setDelegates() {
        editingProfileElements.delegate = self
    }
    
}

// MARK: - setConstrains
extension EditingProfileViewController {
    private func setConstrains() {

        NSLayoutConstraint.activate([
            editingProfileElements.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            editingProfileElements.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            editingProfileElements.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 5),
            editingProfileElements.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}


// MARK: - EditingProfileElementsDelegate
extension EditingProfileViewController: EditingProfileElementsDelegate {
    
    func button_back_press() {
        dismiss(animated: true)
    }
    
    func button_save_press() {
        print("Tapped")
    }
}
