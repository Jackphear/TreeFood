//
//  AddAnimation.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/15.
//

import UIKit

class AddAnimation: NSObject {
    
    var finishBlock: ((Bool) -> Void)?
    private var layer: CALayer?
    
    func start(view: UIView, rect: CGRect, finishPoint: CGPoint, finishBlock : @escaping ((Bool) -> Void)) -> Void {
        layer = CALayer()
        layer?.contents = view.layer.contents
        layer?.contentsGravity = CALayerContentsGravity.resize
        layer?.frame = rect
        
        let window: UIView = view.window!
        window.layer.addSublayer(layer!)
        
        let path = UIBezierPath()
        path.move(to: (layer?.position)!)
        path.addQuadCurve(to: finishPoint, controlPoint: CGPoint(x: window.frame.size.width/2, y: rect.origin.y - 40))
        
        //负责曲线运动
        let pathAnimation : CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")//位置的平移
        pathAnimation.path = path.cgPath
        //负责旋转 rotation
        let basicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        basicAnimation.isRemovedOnCompletion = true
        basicAnimation.fromValue = NSNumber(value: 0)
        basicAnimation.toValue = NSNumber(value: 3 * 2 * Double.pi)//这里是旋转的角度 （2 * PI）是一圈
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        //组合动画
        let groups : CAAnimationGroup = CAAnimationGroup()
        groups.animations = [pathAnimation,basicAnimation]
        groups.duration = 0.5//国际单位制 S
        groups.fillMode = CAMediaTimingFillMode.forwards
        groups.isRemovedOnCompletion = false
        groups.delegate = self
        
        self.layer?.add(groups, forKey: "groups")
        self.finishBlock = finishBlock
    }
}
extension AddAnimation: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == layer!.animation(forKey: "groups") {
            layer?.removeFromSuperlayer()
            layer = nil
            if (finishBlock != nil) {
                finishBlock!(true)
            }
        }
    }
    
}
