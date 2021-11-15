//
//  BaseNavigationController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UIBarButtonItem.appearance()
        appearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0.0, vertical: 0), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = UIColor(red: 250 / 255.0, green: 250 / 255.0, blue: 250 / 255.0, alpha: 0.8)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 38 / 255.0, green: 38 / 255.0, blue: 38 / 255.0, alpha: 1.0), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]
        navigationBar.tintColor = UIColor(red: 38 / 255.0, green: 38 / 255.0, blue: 38 / 255.0, alpha: 1.0)

        // 开启单独导航栏
        navigation.configuration.isEnabled = true
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}
