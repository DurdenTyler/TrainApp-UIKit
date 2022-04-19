//
//  StaticTableCell.swift
//  TrainApp1
//
//  Created by Ivan White on 14.04.2022.
//

import UIKit

class StaticTableCell:UITableViewCell {
    
    private let labelMain = UILabel(text: "Отжимания", fontName: "Roboto-Medium", fontSize: 26, textColor: .white, opacity: 1)
    
    private let labelTwo = UILabel(text: "Раньше: 2", fontName: "Roboto-Medium", fontSize: 14, textColor: .white, opacity: 0.8)
    
    private let labelThree = UILabel(text: "Сейчас: 4", fontName: "Roboto-Medium", fontSize: 14, textColor: .white, opacity: 0.8)
    
    private let labelNumber = UILabel(text: "+2", fontName: "Roboto-Medium", fontSize: 30, textColor: .specialYellow, opacity: 1)
    
    private let backView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    var stackView = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setContrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none /// чтоб ячейка ни как не выделялась
        self.addSubview(backView)
        self.addSubview(labelMain)
        self.addSubview(labelNumber)
        stackView = UIStackView(arrangedSubviews: [labelTwo, labelThree], axis: .horizontal, spacing: 10)
        self.addSubview(stackView)

    }
    
}

// MARK: - setContrains
extension StaticTableCell {
    private func setContrains() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            labelMain.topAnchor.constraint(equalTo: backView.topAnchor, constant: 11),
            labelMain.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: labelMain.bottomAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            labelNumber.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            labelNumber.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15)
        ])
    }
}
