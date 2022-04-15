//
//  StaticViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 14.04.2022.
//

import UIKit

class StaticViewController: UIViewController {
    
    private let staticsLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Статистика"
        label.textColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 28)
        return label
    }()
    
    private let segControl:UISegmentedControl = {
        let titles = ["Неделя", "Месяц"]
        let seg = UISegmentedControl(items: titles)
        let color : UIColor = UIColor.white
        let attributes = [
            NSAttributedString.Key.foregroundColor : color,
            ]
        seg.translatesAutoresizingMaskIntoConstraints = false
        seg.selectedSegmentIndex = 0
        seg.selectedSegmentTintColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        seg.setTitleTextAttributes(attributes, for: .selected)
        return seg
    }()
    
    private let exercicesLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Упражнения"
        label.textColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        label.layer.opacity = 0.7
        return label
    }()
    
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
    
    
    
    private let idStaticTableViewCell = "idStaticTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setContrains()
        setDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(staticsLabel)
        view.addSubview(segControl)
        view.addSubview(exercicesLabel)
        view.addSubview(tableStaticView)
        tableStaticView.register(StaticTableCell.self, forCellReuseIdentifier: idStaticTableViewCell)
    }
    
    
    private func setDelegates() {
        tableStaticView.dataSource = self
        tableStaticView.delegate = self
    }
    
}

extension StaticViewController {
    private func setContrains() {
        NSLayoutConstraint.activate([
            staticsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            staticsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            segControl.topAnchor.constraint(equalTo: staticsLabel.bottomAnchor, constant: 20),
            segControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            segControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            exercicesLabel.topAnchor.constraint(equalTo: segControl.bottomAnchor, constant: 15),
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
        5
    }
    
    func tableView(_ tableStaticView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableStaticView.dequeueReusableCell(withIdentifier: idStaticTableViewCell, for: indexPath) as?
                StaticTableCell else {
                    return UITableViewCell()
                }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension StaticViewController:UITableViewDelegate {
    func tableView(_ tableStaticView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    }
