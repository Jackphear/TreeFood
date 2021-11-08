//
//  FeedbackViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/8.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    
    //MARK: -私有属性
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 120, width: 50, height: 50))
        imageView.image = #imageLiteral(resourceName: "mine_img_header")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 90, y: 120, width: 270, height: 270))
        textView.backgroundColor = .clear
        textView.text = "请输入你的反馈"
        textView.textColor = UIColor.black
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    
    
    lazy var button1: UIButton = {
        let button = UIButton(frame: CGRect(x: 20, y: 620, width: 30, height: 30))
        button.setImage(UIImage(named: "Camera-1"), for: .normal)
        return button
    }()
    
    lazy var button2: UIButton = {
        let button = UIButton(frame: CGRect(x: 65, y: 620, width: 30, height: 30))
        button.setImage(UIImage(named: "Search-1"), for: .normal)
        return button
    }()
    
    lazy var button3: UIButton = {
        let button = UIButton(frame: CGRect(x: 110, y: 620, width: 30, height: 30))
        button.setImage(#imageLiteral(resourceName: "Paper"), for: .normal)
        return button
    }()
    
    lazy var button4: UIButton = {
        let button = UIButton(frame: CGRect(x: 155, y: 620, width: 30, height: 30))
        button.setImage(#imageLiteral(resourceName: "GPS"), for: .normal)
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: CFWidth - 80, y: 620, width: 60, height: 30))
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(red: 60/255, green: 67/255, blue: 207/255, alpha: 1.0)
        label.text = "100"
        return label
    }()
    
    //MARK: -公有方法
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    //MARK: -私有方法
    
    
    func setupView() {
        
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 1
        self.navigation.item.title = "反馈"
        
        view.backgroundColor = .white
        view.addSubview(avatarImageView)
        view.addSubview(textView)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(label)
    }

    
    

}

extension FeedbackViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let length = textView.text.count + text.count - range.length
        if length > 100 {
            return false
        } else {
            label.text = String(100 - length)
            return true
        }
    }
}
