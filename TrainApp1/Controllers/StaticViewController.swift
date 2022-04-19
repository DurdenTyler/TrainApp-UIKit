//
//  StaticViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 14.04.2022.
//

import UIKit

class StaticViewController: UIViewController {
    
    private let staticsLabel = UILabel(text: "Статистика", fontName: "Roboto-Medium", fontSize: 28, textColor: .specialDarkBlue, opacity: 1)
    
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
    
    @objc private func segmentChange() {
        if segControl.selectedSegmentIndex == 0 {
            print("0")
        }else {
            print("1")
        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idStaticTableViewCell, for: indexPath) as?
                StaticTableCell else {
                    return UITableViewCell()
                }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension StaticViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    }
