//
//  AddTableViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/15.
//

import UIKit

class AddTableViewCell: UITableViewCell {
    
    //MARK: - 公有属性
    
    public var cellCallBack: ((UIImageView) -> Void)?
    
    // MARK: - 公有方法

    
    public func updateUI(with data: Ingredient) {
        self.data = data
        foodImageView.image = UIImage(named: data.image)
        namelabel.text = "\(data.image) (\(data.dosage))"
        heatlabel.text = "\(data.calorisNumber) 千卡"
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }

    // MARK: - 私有属性

    private var data = Ingredient()

    // 监听按钮点击
    private var isClickAddButton = false {
        didSet {
            if isClickAddButton {
                self.addButtonImageView.image = UIImage(named: "achieveAdd")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addBag"), object: self, userInfo: ["caloris": self.data.calorisNumber, "name": self.data.name])
            } else {
                self.addButtonImageView.image = UIImage(named: "achieveAdd1")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteBag"), object: self, userInfo: ["caloris": self.data.calorisNumber, "name": self.data.name])
            }
        }
    }

    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "素食拼盘")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var namelabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "苹果")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 15)!, .foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        label.textAlignment = .left
        return label
    }()

    lazy var heatlabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "53千卡/100g")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 14)!, .foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()

    lazy var addbutton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        return button
    }()

    lazy var addButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "achieveAdd1")
        return imageView
    }()

    lazy var lineView: UIView = {
        let layerView = UIView()
        // strokeCode
        layerView.layer.borderColor = UIColor(red: 0.96, green: 0.92, blue: 0.92, alpha: 1).cgColor
        layerView.layer.borderWidth = 1
        layerView.alpha = 1
        return layerView
    }()

    @objc private func add() {
        isClickAddButton = !isClickAddButton
        cellCallBack!(foodImageView)
    }

    private func configUI() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(heatlabel)
        contentView.addSubview(namelabel)
        contentView.addSubview(lineView)
        contentView.addSubview(addButtonImageView)
        contentView.addSubview(addbutton)

        foodImageView.snp.makeConstraints { make in
            make.height.equalTo(60.fit)
            make.width.equalTo(60.fit)
            make.top.equalToSuperview().offset(10.fit)
            make.left.equalToSuperview().offset(16.fit)
        }

        namelabel.snp.makeConstraints { make in
            make.height.equalTo(20.fit)
            make.width.equalTo(300.fit)
            make.top.equalToSuperview().offset(20.fit)
            make.left.equalToSuperview().offset(96.fit)
        }

        heatlabel.snp.makeConstraints { make in
            make.height.equalTo(20.fit)
            make.width.equalTo(300.fit)
            make.top.equalToSuperview().offset(44.fit)
            make.left.equalToSuperview().offset(96.fit)
        }

        addButtonImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-26.fit)
            make.width.equalTo(28.fit)
            make.height.equalTo(28.fit)
        }

        addbutton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-26.fit)
            make.width.equalTo(28.fit)
            make.height.equalTo(28.fit)
        }

        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.fit)
            make.right.equalToSuperview().offset(-16.fit)
            make.height.equalTo(1.fit)
            make.bottom.equalToSuperview().offset(-2.fit)
        }
    }
}
