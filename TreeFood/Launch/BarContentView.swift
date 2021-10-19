//
//  BarContentView.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//用于实现tabBar点击动画和颜色选项

import UIKit
import ESTabBarController_swift


class BarContentView: ESTabBarItemContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 96/255.0, green: 114/255.0, blue: 255/255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor(red: 0.98, green: 0.59, blue: 0.48, alpha: 1)
    }
    
    convenience init(frame: CGRect, postion:String) {
        self.init(frame: frame)
        if postion == "left"{
            self.insets = UIEdgeInsets.init(top:20.fit, left: 0, bottom: 0, right: 20.fit)
        }else{
            self.insets = UIEdgeInsets.init(top:20.fit, left: 0, bottom: 0, right: -20.fit)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = 0.3 * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}
