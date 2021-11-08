//
//  AboutViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/8.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 1
        self.navigation.item.title = "关于"
        // Do any additional setup after loading the view.
    }

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "app"))
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "树食"
        label.textAlignment = .center
        label.font = UIFont.init(name: "PingFangSC-Semibold", size: 20.fit)
        return label
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Version 1.5.0"
        label.textAlignment = .center
        label.font = UIFont.init(name: "PingFangSC-Regual", size: 20.fit)
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "树食是一款可和Apple Watch交互获得用户体参数来科学规划用户一日三餐的智能饮食推荐的 App。无论是日常的饮食需求，还是在健身计划化中，人们都需要规划饮食，调整日进食摄入量。亦或者只是单纯不知道吃什么，想来一顿营养又美味的午餐。这时候“树食”就能轻松地帮您规划饮食。"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.init(name: "PingFangSC-Regual", size: 20.fit)
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Designed From OuYangZiQian's Team"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.init(name: "PingFangSC-Regual", size: 16.fit)
        return label
    }()
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(contentLabel)
        view.addSubview(versionLabel)
        view.addSubview(bottomLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(180.fit)
            make.width.height.equalTo(60.fit)
            make.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(10.fit)
            make.width.equalTo(100.fit)
            make.height.equalTo(40.fit)
        }
    
        versionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.label.snp.bottom).offset(2.fit)
            make.width.equalTo(100.fit)
            make.height.equalTo(40.fit)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(versionLabel.snp.bottom).offset(10.fit)
            make.left.equalToSuperview().offset(20.fit)
            make.right.equalToSuperview().offset(-20.fit)
            make.height.equalTo(200.fit)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20.fit)
            make.width.equalTo(300.fit)
            make.height.equalTo(40.fit)
        }
    }
}
