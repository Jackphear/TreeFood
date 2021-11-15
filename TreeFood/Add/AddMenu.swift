//
//  AddMenu.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/15.
//

import DKCamera
import FanMenu
import HandyJSON
import Macaw
import SwiftyJSON
import UIKit

class AddMenu: NSObject {
    // 单例
    private static var _sharedInstance: AddMenu?

    override private init() {
    }

    class func getsharedInstance() -> AddMenu {
        guard let instance = _sharedInstance else {
            _sharedInstance = AddMenu()
            return _sharedInstance!
        }
        return instance
    }

    public lazy var fanMenu: FanMenu = {
        let fanMenu = FanMenu()
        let items = [
            ("早餐", 0xFFFFFF),
            ("午餐", 0xFFFFFF),
            ("晚餐", 0xFFFFFF),
            ("小食", 0xFFFFFF),
        ]

        fanMenu.button = FanMenuButton(
            id: "main",
            image: UIImage(named: "menu_plus"),
            color: Color(val: 0xF57555)
        )

        fanMenu.items = items.map { button in
            FanMenuButton(
                id: button.0,
                image: UIImage(named: "\(button.0)"),
                color: Color(val: button.1)
            )
        }

        fanMenu.menuRadius = 120.0
        fanMenu.duration = 0.2
        fanMenu.interval = (Double.pi + Double.pi / 6, Double.pi + 5 * Double.pi / 6)
        fanMenu.radius = 25.0
        fanMenu.delay = 0.0
        fanMenu.backgroundColor = .clear
        return fanMenu
    }()
}
