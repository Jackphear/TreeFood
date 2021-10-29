//
//  ingredientsCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/29.
//

import UIKit

class ingredientsCell: UITableViewCell {
    private lazy var backView: UIView = {
        let layerView = UIView()
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 6
        // fill
        layerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()

    // 左图
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FavCollectionViewCell-1")
        return imageView
    }()

    // 内容
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "生鸡蛋(两个)")
        label.numberOfLines = 0
        label.textAlignment = .left
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Light", size: 15)!, .foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()

    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "backColor")
        return imageView
    }()

    //
    // 用量
    private lazy var useLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "50g")
        label.numberOfLines = 0
        label.textAlignment = .center
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Light", size: 14)!, .foregroundColor: UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()

    // MARK: - 公有方法

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func updateUI(_ data: Ingredient) {
        leftImageView.image = UIImage(named: data.image)
        nameLabel.text = data.name
        useLabel.text = data.dosage
    }

    // MARK: - 私有方法

    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(backView)
        backView.addSubview(leftImageView)
        backView.addSubview(nameLabel)
        backView.addSubview(backImageView)
        backImageView.addSubview(useLabel)

        backView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.fit)
            make.right.equalToSuperview().offset(-24.fit)
            make.bottom.equalToSuperview().offset(-18.fit)
            make.top.equalToSuperview()
        }

        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(62.fit)
            make.left.equalToSuperview().offset(14.fit)
        }

        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.leftImageView.snp.right).offset(10.fit)
            make.width.equalTo(100.fit)
            make.height.equalTo(30.fit)
        }

        backImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.fit)
            make.width.equalTo(100.fit)
            make.centerY.equalToSuperview()
            make.height.equalTo(30.fit)
        }

        useLabel.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
}

class CalorisTotalTableViewCell: UITableViewCell {
    // MARK: - 公有方法

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 更新卡路里数
    /// - Parameter total: 卡路里数
    public func updateUI(_ total: Int) {
        calorisNumberLabel.text = "\(total)"
    }

    // MARK: - 私有方法

    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(totalLabel)
        addSubview(calorisBackImageView)
        calorisBackImageView.addSubview(calorisNumberLabel)
        calorisBackImageView.addSubview(calorisUnitLabel)

        calorisBackImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30.fit)
            make.top.equalToSuperview().offset(10.fit)
            make.width.equalTo(113.fit)
            make.height.equalTo(55.fit)
        }

        calorisNumberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.fit)
            make.width.equalTo(50.fit)
            make.height.equalTo(30.fit)
        }

        calorisUnitLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.fit)
            make.centerY.equalToSuperview().offset(2.fit)
            make.width.equalTo(30.fit)
            make.height.equalTo(20.fit)
        }

        totalLabel.snp.makeConstraints { make in
            make.right.equalTo(self.calorisBackImageView.snp.left).offset(-8.fit)
            make.width.equalTo(35.fit)
            make.height.equalTo(20.fit)
            make.bottom.equalTo(self.calorisBackImageView.snp.bottom).offset(-5.fit)
        }
    }

    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "合计")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 15)!, .foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()

    private lazy var calorisBackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sumRectangle")
        return imageView
    }()

    private lazy var calorisNumberLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "200")
        label.numberOfLines = 0
        label.textAlignment = .center
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 18)!, .foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()

    private lazy var calorisUnitLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "千卡")
        label.numberOfLines = 0
        label.textAlignment = .left
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 12)!, .foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
}
