//
//  MineViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//

import UIKit
import HandyJSON
import SwiftyJSON

class MineViewController: UIViewController {
    //MARK: -私有属性

    private var mineData = MineModel(backgroundImage: "", userImage: "", userName: "去冰无糖", sex: "女", weight: "52", height: "168")
    private var preferenceData = [Dish]()
    private var foodType = [Species]()
    
    private let MineHeadCellID = "MineHeadCell"
    private let MineBodyCellID = "MineBodyCell"
    
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x:10, y:0, width:30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mine_icon_set")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.black
        button.tintColor = UIColor.black
        button.setImage(imageView.image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(changeBackgroundImage), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    lazy var backgroundImage: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "mine_img_bg")
        return img
    }()
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(MineHeadTableViewCell.self, forCellReuseIdentifier: MineHeadCellID)
        tableview.register(MIneBodyTableViewCell.self, forCellReuseIdentifier: MineBodyCellID)
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.showsVerticalScrollIndicator = false
        tableview.isScrollEnabled = false
        return tableview
    }()
 
    //MARK: -公有方法
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -私有方法
    
    func configData() {
        
        
        
        let path = Bundle.main.path(forResource: "homelist", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        let json = JSON(jsonData!)
        preferenceData = JSONDeserializer<HomeData>.deserializeFrom(json: json["data"].description)!.favorite.dishes
    }
    
    func configNavbar() {
        self.navigation.item.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
    }
    
    func configUI() {
        self.view.backgroundColor = UIColor.init(r: 245, g: 245, b: 245)
        self.view.addSubview(self.backgroundImage)
        self.backgroundImage.snp.makeConstraints{ (make) in
             make.left.equalTo(self.view.snp.left).offset(0)
             make.right.equalTo(self.view.snp.right).offset(0)
            make.height.equalTo(270.fit)
            make.top.equalTo(self.navigation.bar.snp.top).offset(-kStatusBarHeight)
         }
        self.view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(5.fit)
            make.right.equalTo(view.snp.right).offset(-5.fit)
            make.top.equalTo(backgroundImage.snp.bottom).offset(-80.fit)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        if let dataImage = UIImage(contentsOfFile: mineData.backgroundImage) {
            self.backgroundImage.image = dataImage
        } else { return }
    }
    
    @objc func changeBackgroundImage() {
        
    }
}

extension MineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension MineViewController {
    func archiveData(data: MineModel) {
        let dic = NSDictionary(dictionary: data.toJSON()!)
        let path = NSHomeDirectory().appending("/Documents/user.plist")
        let arr = NSMutableArray()
        arr.add(dic)
        arr.write(toFile: path, atomically: true)
    }
    
    func getLocalData() -> MineModel {
        let path = NSHomeDirectory().appending("/Documents/user.plist")
        let data = NSArray(contentsOfFile: path)!
        let dic = data[0] as! NSDictionary
        let model = MineModel.deserialize(from: dic, designatedPath: "")!
        return model
    }
}
