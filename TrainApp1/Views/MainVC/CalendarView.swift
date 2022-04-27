//
//  CalendarView.swift
//  TrainApp1
//
//  Created by Ivan White on 06.04.2022.
//

import UIKit

protocol SelectCollectionViewItemProtocol: AnyObject {
    func selectItem(date: Date)
}


class CalendarView:UIView {
    
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 3 /// минимальное растояние между itemami
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .none /// прозрачный бэкграунд сделали
        
        return collection
    }()
    
    private let cell = CalendarCollectionCell()
    
    /// тут мы делаем идентификатор ячейки
    private let idCalendarCell = "idCalendarCell"
    
    weak var cellCollectionViewDelegate: SelectCollectionViewItemProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setContrains()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.3764705882, blue: 0.6941176471, alpha: 1)
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addShadowOnView() /// расширение что добавляет тень которое мы написали сами
        self.addSubview(collectionView)
        
        /// регистрируем ячейку
        collectionView.register(CalendarCollectionCell.self, forCellWithReuseIdentifier: idCalendarCell)
    }
    
    /// Устанавливаем делегаты
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - setContrains
extension CalendarView {
    private func setContrains() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 105),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4)
            
        ])
   }
}


/// мы должны реализовать обязательные протоколы что бы поработать с коллекцией
/// сперва мы должны подписаться под 2 протокола

// MARK: - UICollectionViewDataSource
extension CalendarView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCalendarCell, for: indexPath) as? CalendarCollectionCell else {
            return UICollectionViewCell()
        }
        
        let dateTimeZone = Date().localDate()
        let weekArray = dateTimeZone.getWeekArray()
        cell.dateForCell(numberMonth: weekArray[1][indexPath.item], dayWeek: weekArray[0][indexPath.item])
        
        if indexPath.item == 6 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CalendarView:UICollectionViewDelegate {
    /// здесь мы создадим метод что будет отвечать когда мы будем нажимать на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dateTimeZone = Date()
        switch indexPath.item {
        case 0:
            cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDays(days: 6))
        case 1:
            cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDays(days: 5))
        case 2:
            cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDays(days: 4))
        case 3:
            cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDays(days: 3))
        case 4:
            cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDays(days: 2))
        case 5:
            cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDays(days: 1))
        default:
            cellCollectionViewDelegate?.selectItem(date: dateTimeZone.offsetDays(days: 0))
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarView:UICollectionViewDelegateFlowLayout {
    /// здесь мы указываем размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 8, height: collectionView.frame.height - 13)
    }
}
