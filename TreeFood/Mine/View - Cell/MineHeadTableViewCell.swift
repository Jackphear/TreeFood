//
//  MIneBodyTableViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/3.
//

import UIKit

class MineHeadTableViewCell: UITableViewCell {
    // MARK: -公有属性
    
    var cellCallBack:((UIImage) -> ())?

    // MARK: - 私有属性

    private lazy var userImg: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 40.fit
        view.layer.masksToBounds = true
        view.image = UIImage(named: "mine_img_header")
        view.contentMode = .scaleAspectFill
        return view
    }()

    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "去冰无糖"
        label.textColor = UIColor.black
        label.font = UIFont(name: "PingFangSC-Semibold", size: 18.fit)
        return label
    }()

    private lazy var sexIcon: UIImageView = {
        let img = UIImageView()
        return img
    }()

    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.fit)
        label.text = "52"
        label.textColor = UIColor.orange
        return label
    }()

    private lazy var bodyUnitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.fit)
        label.text = "kg"
        label.textColor = UIColor.black
        return label
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.fit)
        label.text = "168"
        label.textColor = UIColor.orange
        return label
    }()

    private lazy var heightUnitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.fit)
        label.text = "cm"
        label.textColor = UIColor.black
        return label
    }()

    // MARK: - 公有方法

    public func updateUI(with data: MineModel) {
        if let dataImage = UIImage(contentsOfFile: data.userImage) {
            self.userImg.image = dataImage
        }else {
            self.userImg.image = UIImage(named: "mine_img_header")
            cellCallBack?(self.userImg.image!)
        }
        self.userName.text = data.userName
        self.weightLabel.text = data.weight
        self.heightLabel.text = data.height
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 私有方法
    
    private func configUI() {
        addSubview(userImg)
        userImg.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(30.fit)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(80.fit)
            make.width.equalTo(80.fit)
        }
        addSubview(userName)
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(140.fit)
            make.bottom.equalTo(self.snp.centerY).offset(-5.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(100.fit)
        }
        addSubview(sexIcon)
        sexIcon.snp.makeConstraints { (make) in
            make.left.equalTo(userName.snp.right).offset(10.fit)
            make.bottom.equalTo(self.snp.centerY).offset(-10.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(20.fit)
        }
        addSubview(weightLabel)
        weightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(140.fit)
            make.top.equalTo(self.snp.centerY).offset(10.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(25.fit)
        }
        addSubview(bodyUnitLabel)
        bodyUnitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(weightLabel.snp.right).offset(0.fit)
            make.bottom.equalTo(weightLabel.snp.bottom).offset(-5.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(15.fit)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(210.fit)
            make.top.equalTo(self.snp.centerY).offset(15.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(2.fit)
        }
        
        addSubview(heightLabel)
        heightLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp.right).offset(30.fit)
            make.top.equalTo(self.snp.centerY).offset(10.fit)
            make.height.equalTo(30.fit)
            make.width.equalTo(30.fit)
        }
        addSubview(heightUnitLabel)
        heightUnitLabel.snp.makeConstraints { (make) in
            make.left.equalTo(heightLabel.snp.right).offset(0.fit)
            make.bottom.equalTo(heightLabel.snp.bottom).offset(-5.fit)
            make.height.equalTo(20.fit)
            make.width.equalTo(20.fit)
        }
    }
}
