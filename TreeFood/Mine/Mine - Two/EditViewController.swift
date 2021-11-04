//
//  EditViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/4.
//

import UIKit

class EditViewController: UIViewController {
    // MARK: - 公有属性

    var editCallBack: (() -> Void)?

    // MARK: - 私有属性

    private var data = MineModel()
    private let editHeadCellID = "editHeadCell"
    private let editBodyCellID = "editBodyCell"

    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.isScrollEnabled = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        tableview.register(EditBodyTableViewCell.classForCoder(), forCellReuseIdentifier: editBodyCellID)
        tableview.register(EditHeadTableViewCell.classForCoder(), forCellReuseIdentifier: editHeadCellID)
        return tableview
    }()

    private lazy var editLabel: UILabel = {
        let label = UILabel()
        label.text = "编辑资料"
        label.numberOfLines = 0.fit
        label.font = UIFont(name: "PingFang SC", size: 16.fit)
        label.textColor = UIColor(red: 0.57.fit, green: 0.54.fit, blue: 0.54.fit, alpha: 1.fit)
        label.alpha = 1.fit
        return label
    }()
    
    private lazy var imagePickController: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.allowsEditing = true
        return controller
    }()

    // MARK: - 公有方法
    
    public func updateUI(with data: MineModel) {
        self.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
    }

    // MARK: - 私有方法

    private func configUI() {
        view.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(140.fit)
            make.left.right.equalToSuperview()
            make.height.equalTo(CFHeight)
        }
        view.addSubview(editLabel)
        editLabel.snp.makeConstraints { make in
            make.width.equalTo(128.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(22.fit)
            make.top.equalToSuperview().offset(100.fit)
        }
    }

    private func configNavbar() {
        navigation.bar.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        navigation.bar.isShadowHidden = true
        navigation.bar.alpha = 1
        navigation.item.title = "编辑资料"
    }
}

extension EditViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
}

extension EditViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: editHeadCellID, for: indexPath) as! EditHeadTableViewCell
            cell.updateUI(with: "修改头像", imageString: data.userImage)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: editBodyCellID, for: indexPath) as! EditBodyTableViewCell
            cell.updateUI(with: "姓名", content: data.userName)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: editBodyCellID, for: indexPath) as! EditBodyTableViewCell
            cell.updateUI(with: "身高", content: data.height + "cm")
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: editBodyCellID, for: indexPath) as! EditBodyTableViewCell
            cell.updateUI(with: "体重", content: data.weight + "kg")
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: editBodyCellID, for: indexPath) as! EditBodyTableViewCell
            cell.updateUI(with: "性别", content: data.sex)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: editBodyCellID, for: indexPath) as! EditBodyTableViewCell
            cell.updateUI(with: "生日", content: data.birthday)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100.fit
        } else {
            return 50.fit
        }
    }
}
