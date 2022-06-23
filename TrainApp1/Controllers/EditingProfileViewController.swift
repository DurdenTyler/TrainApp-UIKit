//
//  EditingProfileViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 01.06.2022.
//

import UIKit
import RealmSwift

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
            editingProfileElements.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            editingProfileElements.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            editingProfileElements.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}


// MARK: - EditingProfileElementsDelegate
extension EditingProfileViewController: EditingProfileElementsDelegate {
    func button_add_photo() {
        alertPhotoOrCamera { [weak self] source in
            guard let self = self else { return }
            self.chooseImagePicker(source: source)
        }
    }
    
    
    func button_back_press() {
        dismiss(animated: true)
    }
    
    func button_save_press() {
        //
    }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditingProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        editingProfileElements.userImageView.image = image
        editingProfileElements.userImageView.contentMode = .scaleAspectFit
        dismiss(animated: true)
    }
}
