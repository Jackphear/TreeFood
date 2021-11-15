//
//  AddView.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//

import UIKit

class AddView: UIView {
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isUserInteractionEnabled || isHidden || alpha <= 0.01 {
            return nil
        }
        let resultView = super.hitTest(point, with: event)
        if resultView != nil {
            return resultView
        } else {
            for subView in subviews.reversed() {
                let convertPoint: CGPoint = subView.convert(point, from: self)
                let hitView = subView.hitTest(convertPoint, with: event)
                if hitView != nil {
                    return hitView
                }
            }
        }
        return nil
    }
}
