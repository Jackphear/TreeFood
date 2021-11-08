//
//  EditViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/4.
//

import UIKit
import CoreMIDI

class EditViewController: UIViewController {
    // MARK: - 公有属性

    var editCallBack: ((MineModel) -> Void)?

    // MARK: - 私有属性

    private var data = MineModel()
    private let editHeadCellID = "editHeadCell"
    private let editBodyCellID = "editBodyCell"
    private var UserImage: UIImage?

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

    private lazy var alertController: UIAlertController = {
        let alert = UIAlertController(title: "更换头像", message: nil, preferredStyle: .alert)
        let pickFromCamera = UIAlertAction(title: "拍照选取", style: .default, handler: { action in
            self.pickFrom(with: action.title!)
        })
        let pickFromAlbum = UIAlertAction(title: "从相册选取", style: .default, handler: { action in
            self.pickFrom(with: action.title!)
        })
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(pickFromAlbum)
        alert.addAction(pickFromCamera)
        alert.addAction(cancel)
        return alert
    }()
    
//    private lazy var pickView: EditPickerView = {
//        let view = EditPickerView()
//        view.callBack = { data in
//            print(data)
////            self.data.sex = data.sex
////            self.data.weight = data.weight
////            self.data.height = data.height
////            self.data.birthday = data.birthday
//            
//            //self.tableView.reloadData()
//        }
//        return view
//    }()

    // MARK: - 公有方法

    public func updateUI(with data: MineModel) {
        self.data = data
        UserImage = UIImage(contentsOfFile: data.userImage)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.editCallBack!(data)
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

    private func pickFrom(with type: String) {
        if type == "拍照选取" {
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
                self.imagePickController.sourceType = .camera
                self.imagePickController.showsCameraControls = true
                self.imagePickController.cameraDevice = .front
            }
        } else {
            self.imagePickController.sourceType = .photoLibrary
        }
        self.present(self.imagePickController, animated: true, completion: nil)
    }
    
    private func pick(with type: editType) {
        let pickView = EditPickerView()
        pickView.updateUI(with: type, data: self.data)
        self.view.addSubview(pickView)
        pickView.snp.makeConstraints{ make in
            make.left.right.top.bottom.equalToSuperview()
        }
        pickView.callBack = { data in
            self.data = data
            self.tableView.reloadData()
        }
        
    }
}

extension EditViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.UserImage = info[.originalImage] as? UIImage
        self.tableView.reloadData()
        self.dismiss(animated: true) {
            self.data.userImage = archivImage(image: self.UserImage!, type: "userImage")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension EditViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.present(alertController, animated: true, completion: nil)
        case 1:
            let vc = EditNameViewController()
            vc.callBack = { name in
                self.data.userName = name
                self.tableView.reloadData()
            }
            vc.updateUI(with: self.data)
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            pick(with: .height)
        case 3:
            pick(with: .weight)
        case 4:
            pick(with: .sex)
        case 5:
            pick(with: .date)
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: editHeadCellID, for: indexPath) as! EditHeadTableViewCell
            cell.updateUI(with: "修改头像", image: UserImage!)
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
