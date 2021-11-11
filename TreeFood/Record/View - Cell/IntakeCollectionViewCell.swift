//
//  IntakeCollectionViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/11.
//

import UIKit

class IntakeCollectionViewCell: UICollectionViewCell {
    // MARK: - 私有属性

    private var type = Species.Breakfast

    private lazy var backView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        // shadowCode
        view.layer.shadowColor = UIColor(red: 0.35, green: 0.15, blue: 0, alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        // fill
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 10
        view.alpha = 1

        return view
    }()

    // 添加按钮
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 1, green: 0.68, blue: 0.5, alpha: 1)
        button.setImage(UIImage(named: "menu_plus"), for: .normal)
        button.addTarget(self, action: #selector(clickAddButton), for: .touchUpInside)
        button.layer.cornerRadius = 20.fit
        return button
    }()

    // 添加标签
    private lazy var addLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "添加")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 12)!, .foregroundColor: UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()

    // 类型标签
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: type.rawValue)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 13)!, .foregroundColor: UIColor(red: 1, green: 0.46, blue: 0.29, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()

    // 左上标视图
    private lazy var leftTopView: UIView = {
        let layerView = UIView()
        // strokeCode
        layerView.layer.borderColor = UIColor(red: 1, green: 0.46, blue: 0.29, alpha: 1).cgColor
        layerView.layer.borderWidth = 1
        layerView.layer.cornerRadius = 10
        layerView.layer.masksToBounds = true
        layerView.alpha = 1
        layerView.addSubview(self.typeLabel)
        self.typeLabel.snp.makeConstraints { make in
            make.width.equalTo(36.fit)
            make.height.equalTo(26.fit)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        return layerView
    }()

    // MARK: - 公有方法
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initWithType(with type: Species) {
        self.type = type
        typeLabel.text = self.type.rawValue
    }

    public func updateUI(with imageString: String?) {
        if let str = imageString {
            backView.image = UIImage(named: str)
            backView.clipsToBounds = true
            addButton.alpha = 0
            addLabel.alpha = 0
            leftTopView.backgroundColor = UIColor(red: 1, green: 0.68, blue: 0.49, alpha: 1)
            leftTopView.layer.borderColor = UIColor(red: 1, green: 0.68, blue: 0.49, alpha: 1).cgColor
            typeLabel.textColor = .white
        }else {
            backView.image = UIImage(named: "")
            backView.clipsToBounds = false
            addLabel.alpha = 1
            addButton.alpha = 1
            leftTopView.backgroundColor = .white
            leftTopView.layer.borderColor = UIColor(red: 1, green: 0.46, blue: 0.29, alpha: 1).cgColor
            typeLabel.textColor = UIColor(red: 1, green: 0.46, blue: 0.29,alpha:1)
        }
    }

    // MARK: - 私有方法

    private func configUI() {
        addSubview(backView)
        backView.addSubview(leftTopView)
        backView.addSubview(addButton)
        backView.addSubview(addLabel)

        leftTopView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(44.fit)
            make.height.equalTo(34.fit)
        }

        backView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right).offset(-20.fit)
            make.top.equalToSuperview().offset(5.fit)
            make.bottom.equalToSuperview().offset(-5.fit)
        }

        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40.fit)
        }

        addLabel.snp.makeConstraints { make in
            make.top.equalTo(self.addButton.snp.bottom).offset(10.fit)
            make.centerX.equalToSuperview()
            make.width.equalTo(28.fit)
            make.height.equalTo(20.fit)
        }
    }

    @objc func clickAddButton() {
    }
}
