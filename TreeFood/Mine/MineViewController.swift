//
//  MineViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//

import HandyJSON
import Macaw
import SwiftyJSON
import UIKit

class MineViewController: UIViewController {
    // MARK: - 私有属性

    private var mineData = MineModel()
    private var preferenceData = [Dish]()
    private var foodType = [Species]()

    private let MineHeadCellID = "MineHeadCell"
    private let MineBodyCellID = "MineBodyCell"

    private lazy var rightBarButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
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

    private lazy var tableView: UITableView = {
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

    // MARK: - 公有方法

    override func viewDidLoad() {
        super.viewDidLoad()
        configData()
        configNavbar()
        configUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        archiveData(data: mineData)
    }

    // MARK: - 私有方法

    func configData() {
        mineData = getLocalData()
        let path = Bundle.main.path(forResource: "homeList", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        let json = JSON(jsonData!)
        preferenceData = JSONDeserializer<HomeData>.deserializeFrom(json: json["data"].description)!.favorite.dishes
    }

    func configNavbar() {
        navigation.item.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        navigation.bar.isShadowHidden = true
        navigation.bar.alpha = 0
    }

    func configUI() {
        view.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.height.equalTo(270.fit)
            make.top.equalTo(self.navigation.bar.snp.top).offset(-kStatusBarHeight - 5)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(5.fit)
            make.right.equalTo(view.snp.right).offset(-5.fit)
            make.top.equalTo(backgroundImage.snp.bottom).offset(-80.fit)
            make.bottom.equalTo(view.snp.bottom)
        }

        if let dataImage = UIImage(contentsOfFile: mineData.backgroundImage) {
            backgroundImage.image = dataImage
        } else {
            backgroundImage.image = UIImage(named: "mine_img_bg")
            mineData.backgroundImage = archivImage(image: backgroundImage.image!, type: "backgroundImage")
        }

        if let image = UIImage(contentsOfFile: mineData.userImage) {
            mineData.userImage = archivImage(image: image, type: "userImage")
        } else {
            let image = UIImage(named: "mine_img_header")
            mineData.userImage = archivImage(image: image!, type: "userImage")
        }
    }

    @objc func changeBackgroundImage() {
    }
}

extension MineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let vc = EditViewController()
            vc.editCallBack = { data in
                self.mineData = data
                self.tableView.reloadData()
            }
            vc.updateUI(with: mineData)
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            if indexPath.row == 0 {
                print("1 0")
            } else {
                let vc = MoreDishViewController()
                vc.updateUI(with: preferenceData, title: "最近偏爱")
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            if indexPath.row == 0 {
                print("1 0")
            } else {
                print("1 1")
            }
        }
    }
}

extension MineViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 2
        case 2:
            return 2
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineHeadCellID, for: indexPath) as! MineHeadTableViewCell
            cell.cellCallBack = { image in
                self.mineData.userImage = archivImage(image: image, type: "userImage")
            }
            cell.updateUI(with: mineData)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineBodyCellID, for: indexPath) as! MIneBodyTableViewCell
            let arr = ["本周食谱", "最近偏爱"]
            cell.updateUI(with: arr[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MineBodyCellID, for: indexPath) as! MIneBodyTableViewCell
            let arr = ["反馈", "关于"]
            cell.updateUI(with: arr[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100.fit
        }
        return 60.fit
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vi = UIView()
        vi.backgroundColor = .clear
        return vi
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.fit
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
        if let data = NSArray(contentsOfFile: path) {
            let dic = data[0] as! NSDictionary
            let model = MineModel.deserialize(from: dic, designatedPath: "")!
            return model
        } else {
            return MineModel(backgroundImage: "", userImage: "", userName: "去冰无糖", sex: "女", weight: "52", height: "168", birthday: "2000-01-01")
        }
    }
}

extension MineViewController {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 圆角角度
        let radius: CGFloat = 10.fit
        // 设置cell 背景色为透明
        cell.backgroundColor = UIColor.clear
        // 创建两个layer
        let normalLayer = CAShapeLayer()
        let selectLayer = CAShapeLayer()
        // 获取显示区域大小
        let bounds = cell.bounds.insetBy(dx: 20.fit, dy: 0)
        // cell的backgroundView
        let normalBgView = UIView(frame: bounds)
        // 获取每组行数
        let rowNum = tableView.numberOfRows(inSection: indexPath.section)
        // 贝塞尔曲线
        var bezierPath: UIBezierPath?

        if rowNum == 1 {
            // 一组只有一行（四个角全部为圆角）
            bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
            normalBgView.clipsToBounds = false
        } else {
            normalBgView.clipsToBounds = true
            if indexPath.row == 0 {
                normalBgView.frame = bounds.inset(by: UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0))
                let rect = bounds.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
                // 每组第一行（添加左上和右上的圆角）
                bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
            } else if indexPath.row == rowNum - 1 {
                normalBgView.frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -5, right: 0))
                let rect = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
                // 每组最后一行（添加左下和右下的圆角）
                bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            } else {
                // 每组不是首位的行不设置圆角
                bezierPath = UIBezierPath(rect: bounds)
            }
        }

        // 阴影
        normalLayer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        normalLayer.shadowOpacity = 0.2
        normalLayer.shadowOffset = CGSize(width: 0, height: 0)
        normalLayer.path = bezierPath?.cgPath
        normalLayer.shadowPath = bezierPath?.cgPath

        // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
        normalLayer.path = bezierPath?.cgPath
        selectLayer.path = bezierPath?.cgPath

        // 设置填充颜色
        normalLayer.fillColor = UIColor.white.cgColor
        // 添加图层到nomarBgView中
        normalBgView.layer.insertSublayer(normalLayer, at: 0)
        normalBgView.backgroundColor = UIColor.clear
        cell.backgroundView = normalBgView

        // 替换cell点击效果
        let selectBgView = UIView(frame: bounds)
        selectLayer.fillColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        selectBgView.layer.insertSublayer(selectLayer, at: 0)
        selectBgView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = selectBgView
    }
}
