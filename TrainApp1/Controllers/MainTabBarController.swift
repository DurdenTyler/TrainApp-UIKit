//
//  MainTabBarController.swift
//  TrainApp1
//
//  Created by Ivan White on 18.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViews()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialDarkBlue
        tabBar.tintColor = .specialYellow
        tabBar.unselectedItemTintColor = .white
        tabBar.layer.borderColor = #colorLiteral(red: 0, green: 0.6529316306, blue: 1, alpha: 1)
        tabBar.layer.borderWidth = 1
    }
    
    private func setupViews() {
        let mainVC = MainViewController()
        let staticVS = StaticViewController()
        let profileVC = ProfileViewController()
        
        setViewControllers([mainVC, staticVS, profileVC], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Главная"
        items[0].image = UIImage(systemName: "square.text.square")
        
        items[1].title = "Статистика"
        items[1].image = UIImage(systemName: "doc.plaintext")
        
        items[2].title = "Профиль"
        items[2].image = UIImage(systemName: "person.crop.circle.fill")
        
    }

}
