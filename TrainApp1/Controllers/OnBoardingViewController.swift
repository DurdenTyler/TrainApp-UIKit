//
//  OnBoardingViewController.swift
//  TrainApp1
//
//  Created by Ivan White on 08.06.2022.
//

import UIKit


class OnBoardingViewController: UIViewController {
    
    private lazy var button_Next: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 20)
        button.tintColor = .specialDarkBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(func_button_Next), for: .touchUpInside)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        pageControl.isEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let onBoarding_Collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.isScrollEnabled = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let onBoardingIdCell = "onBoardingIdCell"
    
    private var onBoardingArray = [Slide]()
    
    // Какой слайд у нас загружается
    private var collectionItem = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
        setDelegates()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialDarkBlue
        view.addSubview(button_Next)
        view.addSubview(pageControl)
        view.addSubview(onBoarding_Collection)
        onBoarding_Collection.register(OnBoardingViewCell.self, forCellWithReuseIdentifier: onBoardingIdCell)
        
        guard let image_One = UIImage(named: "Slide1"),
              let image_Two = UIImage(named: "Slide2"),
              let image_Three = UIImage(named: "Slide3")
        else { return }
        
        let firstScreen = Slide(topLabel: "Хочешь быть в тонусе?", bottomLabel: "Одно приложение для вашей лучшей формы", image: image_One, fone_Size: 24)
        let secondScreen = Slide(topLabel: "Или хочешь накачать мышцы?", bottomLabel: "Составляй тренировки под свои цели", image: image_Two, fone_Size: 20)
        let thirdScreen = Slide(topLabel: "Быстро и просто", bottomLabel: "Отслеживай свой прогресс с подробной статистикой", image: image_Three, fone_Size: 24)
        
        onBoardingArray = [firstScreen, secondScreen, thirdScreen]
    }
    
    private func setDelegates() {
        onBoarding_Collection.dataSource = self
        onBoarding_Collection.delegate = self
    }
    
    @objc private func func_button_Next() {
        if collectionItem == 1 {
            button_Next.setTitle("Вперед", for: .normal)
            button_Next.addTarget(self, action: #selector(func_new_mean), for: .touchUpInside)
        }
        
        if collectionItem == 2 {
            saveUserDefaults()
        } else {
            collectionItem += 1
            let index: IndexPath = [0, collectionItem]
            onBoarding_Collection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = collectionItem
        }
    }
    
    private func saveUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnBoardingWasViewed")
    }
    
    @objc private func func_new_mean() {
        let mainTabBarVC = MainTabBarController()
        mainTabBarVC.modalPresentationStyle = .fullScreen
        present(mainTabBarVC, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onBoardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: onBoardingIdCell, for: indexPath) as! OnBoardingViewCell
        let slide = onBoardingArray[indexPath.row]
        cell.cellConfigure(slide: slide)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}

extension OnBoardingViewController {
    
    private func setConstrains() {

        NSLayoutConstraint.activate([
            button_Next.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button_Next.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button_Next.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            button_Next.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: button_Next.topAnchor, constant: -20),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageControl.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            onBoarding_Collection.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            onBoarding_Collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            onBoarding_Collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            onBoarding_Collection.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20)
        ])
    }
}
