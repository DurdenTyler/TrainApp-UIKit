//
//  RepsOrTimer.swift
//  TrainApp1
//
//  Created by Ivan White on 18.04.2022.
//

import UIKit

class RepsOrTimerView:UIView {
    
    private let setsLabel = UILabel(text: "Подходы", fontName: "Roboto-Medium", fontSize: 23, textColor: .specialDarkBlue, opacity: 1)
    
    private let countOfSetsLabel = UILabel(text: "0", fontName: "Roboto-Medium", fontSize: 23, textColor: .specialDarkBlue, opacity: 1)
    
    private let stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var slider:UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 20
        slider.minimumTrackTintColor = .specialDarkBlue
        slider.maximumTrackTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(slider1Func), for: .valueChanged)
        return slider
    }()
    
    
    private let chooseLabel = UILabel(text: "Количество повторений или таймер", fontName: "Roboto-Medium", fontSize: 12, textColor: .specialDarkBlue, opacity: 0.7)
    
    private let repsLabel = UILabel(text: "Повторения", fontName: "Roboto-Medium", fontSize: 23, textColor: .specialDarkBlue, opacity: 1)
    
    private let countOfRepsLabel = UILabel(text: "1", fontName: "Roboto-Medium", fontSize: 23, textColor: .specialDarkBlue, opacity: 1)
    
    private let stackView2:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var slider2:UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 50
        slider.minimumTrackTintColor = .specialDarkBlue
        slider.maximumTrackTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(slider2Func), for: .valueChanged)
        return slider
    }()
    
    
    private let timerLabel = UILabel(text: "Таймер", fontName: "Roboto-Medium", fontSize: 23, textColor: .specialDarkBlue, opacity: 1)
    
    private let timeLabel = UILabel(text: "0 сек", fontName: "Roboto-Medium", fontSize: 23, textColor: .specialDarkBlue, opacity: 1)
    
    private let stackView3:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var slider3:UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 300
        slider.minimumTrackTintColor = .specialDarkBlue
        slider.maximumTrackTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(slider3Func), for: .valueChanged)
        return slider
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
        stackView.addArrangedSubview(setsLabel)
        stackView.addArrangedSubview(countOfSetsLabel)
        self.addSubview(slider)
        self.addSubview(chooseLabel)
        self.addSubview(stackView2)
        stackView2.addArrangedSubview(repsLabel)
        stackView2.addArrangedSubview(countOfRepsLabel)
        self.addSubview(slider2)
        self.addSubview(stackView3)
        stackView3.addArrangedSubview(timerLabel)
        stackView3.addArrangedSubview(timeLabel)
        self.addSubview(slider3)
    }
    
    @objc private func slider1Func() {
        countOfSetsLabel.text = "\(Int(slider.value))"
    }
    
    @objc private func slider2Func() {
        countOfRepsLabel.text = "\(Int(slider2.value))"
        setNegative(label: timerLabel, numberLabel: timeLabel, slider: slider3)
        setActive(label: repsLabel, numberLabel: countOfRepsLabel, slider: slider2)
    }
    
    @objc private func slider3Func() {
        
        let (min, sec) = { (secs:Int)-> (Int, Int) in
            return (secs / 60, secs % 60)}(Int(slider3.value))
        
        setNegative(label: repsLabel, numberLabel: countOfRepsLabel, slider: slider2)
        setActive(label: timerLabel, numberLabel: timeLabel, slider: slider3)
        
        guard (min) != 0 else { return timeLabel.text = (min) == 0 ? "\(sec) сек" : "\(min) мин \(sec) сек" }
        timeLabel.text = (sec) == 0 ? "\(min) мин" : "\(min) мин \(sec) сек"
    }
    
    private func setNegative(label:UILabel, numberLabel:UILabel, slider:UISlider) {
        label.alpha = 0.5
        numberLabel.alpha = 0.5
        slider.alpha = 0.5
        slider.value = 0
        guard numberLabel != timeLabel else { return numberLabel.text = "0 сек" }
        numberLabel.text = "0"
    }
    
    private func setActive(label:UILabel, numberLabel:UILabel, slider:UISlider) {
        label.alpha = 1
        numberLabel.alpha = 1
        slider.alpha = 1
    }
    
    private func getSetsAndRepsOrTimer() -> (Int, Int, Int) {
        let setsSliderValue = Int(slider.value)
        let repsSliderValue = Int(slider2.value)
        let timerSliderValue = Int(slider3.value)
        return (setsSliderValue, repsSliderValue, timerSliderValue)
    }
    
    public func setDateAndRepeat() -> (Int, Int, Int) {
        getSetsAndRepsOrTimer()
    }
    
    private func refreshData() {
        slider.value = 0
        slider2.value = 0
        slider3.value = 0
        countOfSetsLabel.text = "0"
        countOfRepsLabel.text = "0"
        timeLabel.text = "0"
    }
    
    public func refreshAllSlidersAndLabels() {
        refreshData()
    }
    
    
}

// MARK: - setContrains
extension RepsOrTimerView {
    private func setContrains() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            chooseLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 15),
            chooseLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView2.topAnchor.constraint(equalTo: chooseLabel.bottomAnchor, constant: 20),
            stackView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            slider2.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 8),
            slider2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            slider2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackView3.topAnchor.constraint(equalTo: slider2.bottomAnchor, constant: 20),
            stackView3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            slider3.topAnchor.constraint(equalTo: stackView3.bottomAnchor, constant: 8),
            slider3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            slider3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
   }
}
