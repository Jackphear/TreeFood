//
//  AddViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/15.
//

import HandyJSON
import SwiftyJSON
import UIKit

class AddViewController: UIViewController {
    // MARK: - 私有属性

    private var type = Species.Breakfast
    private var data = AddModel()
    private var cellData = [Ingredient]()

    private var bagData = [BagFood]()
    private var bagCount = 0
    private var totalCaloris = 0

    private lazy var leftBarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark")!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.black
        button.tintColor = UIColor.black
        button.setImage(imageView.image, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: UIControl.Event.touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()

    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.showsVerticalScrollIndicator = false
        tableview.separatorStyle = .none
        tableview.register(AddTableViewCell.classForCoder(), forCellReuseIdentifier: "reusedcell")
        return tableview
    }()

    lazy var bottomBarView: UIView = {
        let layerView = UIView()
        layerView.backgroundColor = UIColor(red: 0.99, green: 0.91, blue: 0.85, alpha: 1)
        layerView.layer.cornerRadius = 26
        layerView.alpha = 1
        return layerView
    }()

    lazy var countNumberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 1, green: 0.32, blue: 0.32, alpha: 1)
        label.layer.cornerRadius = 15.fit
        label.text = "\(self.bagCount)"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = .white
        label.alpha = 1
        return label
    }()

    lazy var calorisLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "\(self.totalCaloris)千卡")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 16)!, .foregroundColor: UIColor(red: 0.3, green: 0.29, blue: 0.27, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        label.textAlignment = .left
        return label
    }()

    lazy var achieveButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0.fit, y: 0.fit, width: 116.fit, height: 50.fit)
        button.backgroundColor = UIColor(red: 1, green: 0.68, blue: 0.5, alpha: 1)
        button.corner(byRoundingCorners: [.topRight, .bottomRight], radii: 26)
        let attrString = NSMutableAttributedString(string: "完成")
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Semibold", size: 18)!, .foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        button.setAttributedTitle(attrString, for: .normal)
        button.addTarget(self, action: #selector(archieveButtonClick), for: .touchUpInside)
        return button
    }()

    // MARK: - 公有方法

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configData(with: type)
        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(addItem), name: NSNotification.Name("addBag"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteItem), name: NSNotification.Name("deleteBag"), object: nil)
    }

    convenience init(with type: Species) {
        self.init()
        self.type = type
    }

    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "addBag"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "deleteBag"), object: nil)
    }

    // MARK: - 私有方法

    private func configUI() {
        view.backgroundColor = .white
        definesPresentationContext = true
        view.backgroundColor = UIColor.white

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.title = type.rawValue

        view.addSubview(tableView)
        view.addSubview(bottomBarView)
        bottomBarView.addSubview(countNumberLabel)
        bottomBarView.addSubview(calorisLabel)
        bottomBarView.addSubview(achieveButton)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.fit)
            make.bottom.equalToSuperview().offset(-80.fit)
            make.left.right.equalToSuperview()
        }

        bottomBarView.snp.makeConstraints { make in
            make.height.equalTo(50.fit)
            make.left.equalToSuperview().offset(16.fit)
            make.right.equalToSuperview().offset(-16.fit)
            make.bottom.equalToSuperview().offset(-30.fit)
        }

        countNumberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16.fit)
            make.width.height.equalTo(30.fit)
        }

        calorisLabel.snp.makeConstraints { make in
            make.left.equalTo(self.countNumberLabel.snp.right).offset(14.fit)
            make.centerY.equalToSuperview()
            make.width.equalTo(80.fit)
            make.height.equalTo(24.fit)
        }

        achieveButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(116.fit)
        }
    }

    private func configData(with type: Species) {
        let path = Bundle.main.path(forResource: "add", ofType: "json")
        // 2 获取json文件里面的内容,NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        // 3 解析json内
        let json = JSON(jsonData!)
        data = JSONDeserializer<AddModel>.deserializeFrom(json: json["data"].description)!

        switch type {
        case .Breakfast:
            cellData = data.eats[0].content
        case .Launch:
            cellData = data.eats[1].content
        case .Dinner:
            cellData = data.eats[2].content
        case .Snacks:
            cellData = data.eats[3].content
        }
        tableView.reloadData()
    }

    @objc private func leftButtonClick() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func archieveButtonClick() {
        var str: String?
        for item in bagData {
            str = item.name
        }
        let mesaage = [type: str]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addFood"), object: mesaage)
        dismiss(animated: true, completion: nil)
    }

    @objc private func addItem(_ notification: Notification) {
        let userInfo = notification.userInfo as! [String: Any]
        let value = userInfo["caloris"] as! Int
        let name = userInfo["name"] as! String
        let food = BagFood(name: name, caloris: value)
        var isHasFood = false
        for hasFood in bagData {
            if food.name == hasFood.name && food.caloris == hasFood.caloris {
                isHasFood = true
            }
        }
        if !isHasFood {
            bagData.append(food)
            bagCount = bagCount + 1
            totalCaloris = totalCaloris + value
            countNumberLabel.text = "\(bagCount)"
            calorisLabel.text = "\(totalCaloris)千卡"
        }
    }

    @objc private func deleteItem(_ notification: Notification) {
        let userInfo = notification.userInfo as! [String: Any]
        let value = userInfo["caloris"] as! Int
        let name = userInfo["name"] as! String
        let food = BagFood(name: name, caloris: value)
        var isHasFood = false
        var deleteIndex = 0
        for (index, hasFood) in bagData.enumerated() {
            if food.name == hasFood.name && food.caloris == hasFood.caloris {
                isHasFood = true
                deleteIndex = index
            }
        }
        if isHasFood {
            bagData.remove(at: deleteIndex)
            bagCount = bagCount - 1
            totalCaloris = totalCaloris - value
            countNumberLabel.text = "\(bagCount)"
            calorisLabel.text = "\(totalCaloris)千卡"
        }
    }
}

extension AddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusedcell") as! AddTableViewCell
        cell.cellCallBack = { view in
            var rect = tableView.rectForRow(at: indexPath)
            rect.origin.y = rect.origin.y - tableView.contentOffset.y

            var viewRect = view.frame
            viewRect.origin.y = rect.origin.y + viewRect.origin.y

            AddAnimation().start(view: view, rect: viewRect, finishPoint: CGPoint(x: self.view.frame.size.width / 4 * 3, y: self.view.frame.size.height - 49)) { _ in
                print("to do")
            }
        }
        cell.updateUI(with: cellData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
