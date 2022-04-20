//
//  DateAndRepeatView.swift
//  TrainApp1
//
//  Created by Ivan White on 18.04.2022.
//

import UIKit
import RealmSwift


class DateAndRepeatView:UIView {
    
    private let labelDate = UILabel(text: "Дата", fontName: "Roboto-Medium", fontSize: 23, textColor: .specialDarkBlue, opacity: 1)
    
    private let datePicker:UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.tintColor = .specialDarkBlue
        return picker
        }()
    
    private let stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let repLabel = UILabel(text: "Напомнить через 7 дней", fontName: "Roboto-Medium", fontSize: 23, textColor: .specialDarkBlue, opacity: 1)
    
    private let switchRep:UISwitch = {
        let switchRep = UISwitch()
        switchRep.translatesAutoresizingMaskIntoConstraints = false
        switchRep.isOn = true
        switchRep.onTintColor = .specialDarkBlue
        return switchRep
        }()
    
    private let stackView2:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setContrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.addSubview(stackView)
        self.addSubview(stackView2)
        stackView.addArrangedSubview(labelDate)
        stackView.addArrangedSubview(datePicker)
        stackView2.addArrangedSubview(repLabel)
        stackView2.addArrangedSubview(switchRep)
    }
    
    private func getDateAndRepeat() -> (Date, Bool) {
        (datePicker.date, switchRep.isOn)
    }
    
    public func setDateAndRepeat() -> (Date, Bool) {
        getDateAndRepeat()
    }
}

// MARK: - setContrains
extension DateAndRepeatView {
    private func setContrains() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackView2.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            stackView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
   }
}
