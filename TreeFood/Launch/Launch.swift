//
//  Launch.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//

import Foundation
import ESTabBarController_swift
import UIKit

func Launch() -> ESTabBarController {
    //集成VC
    let tabBarController = ESTabBarController()
    let homeVC = HomeViewController()
    let recordVC = RecordViewController()
    let mineVC = MineViewController()
    let analyzeVC = AnalyzeViewController()
    let addVC = UIViewController()
    
    
    homeVC.tabBarItem = ESTabBarItem.init(BarContentView(frame: .zero, postion: "left"), title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
    recordVC.tabBarItem = ESTabBarItem.init(BarContentView(frame: .zero, postion: "left"), title: "", image: UIImage(named: "recoder"), selectedImage: UIImage(named: "recoder"))
    mineVC.tabBarItem = ESTabBarItem.init(BarContentView(frame: .zero, postion: "right"), title: "", image: UIImage(named: "mine"), selectedImage: UIImage(named: "mine"))
    analyzeVC.tabBarItem = ESTabBarItem.init(BarContentView(frame: .zero, postion: "right"), title: "", image: UIImage(named: "archive"), selectedImage: UIImage(named: "archive"))
    addVC.tabBarItem = ESTabBarItem.init(BarContentView(frame: .zero, postion: "right"), title: "", image: UIImage(), selectedImage: UIImage())
    
    let homeNavi = BaseNavigationController(rootViewController: homeVC)
    let recordNavi = BaseNavigationController(rootViewController: recordVC)
    let mineNavi = BaseNavigationController(rootViewController: mineVC)
    let analyzeNavi = BaseNavigationController(rootViewController: analyzeVC)
    let addNavi = BaseNavigationController(rootViewController: addVC)
    
    tabBarController.viewControllers = [homeNavi, recordNavi, addNavi, analyzeNavi, mineNavi]
    
    UITabBar.appearance().isTranslucent = false
    UITabBar.appearance().tintColor = .white
    tabBarController.tabBar.barStyle = .default
    tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
    tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: -3.fit)
    tabBarController.tabBar.layer.shadowOpacity = 0.2
    tabBarController.tabBar.backgroundColor = .white
    tabBarController.tabBar.shadowImage = UIImage(named: "background")
    tabBarController.tabBar.barTintColor = UIColor.red
    tabBarController.tabBar.backgroundImage = UIImage(named: "background")

    
    return tabBarController
}
