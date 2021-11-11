//
//  TopInfoCollectionViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/11.
//

import UIKit

class TopInfoCollectionViewCell: UICollectionViewCell {
    // MARK: - 私有属性

    // 卡片背景视图
    private lazy var backView: UIView = {
        let view = UIView()
        // shadowCode
        view.layer.shadowColor = UIColor(red: 0.35, green: 0.15, blue: 0, alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        // fill
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 24
        view.alpha = 1
        return view
    }()

    // 体重渐变视图
    private lazy var weightGradientView: UIView = {
        let layerView = UIView()
        layerView.frame = CGRect(x: 30.fit, y: 15.fit, width: 44.fit, height: 6.fit)
        // fill
        let bgGradient = CAGradientLayer()
        bgGradient.colors = [UIColor(red: 0.96, green: 0.46, blue: 0.33, alpha: 1).cgColor, UIColor(red: 0.98, green: 0.93, blue: 0.88, alpha: 1).cgColor]
        bgGradient.locations = [0, 1]
        bgGradient.frame = layerView.bounds
        bgGradient.startPoint = CGPoint(x: 0.5, y: 0)
        bgGradient.endPoint = CGPoint(x: 0.5, y: 1)
        layerView.layer.addSublayer(bgGradient)
        layerView.layer.cornerRadius = 3
        layerView.layer.masksToBounds = true
        layerView.alpha = 1
        return layerView
    }()

    // 体重标题标签
    private lazy var weightLabel = getTitleLabel(placeHolder: "体重")

    // 体重数值标签
    private lazy var weightNumberLabel: UILabel = {
        let label = UILabel()
        let weightAttrString = NSMutableAttributedString(string: "1")
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 19)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        weightAttrString.addAttributes(attr, range: NSRange(location: 0, length: weightAttrString.length))
        label.attributedText = weightAttrString
        label.textAlignment = .center
        return label
    }()

    // 体重单位标签
    private lazy var weightUnitLabel: UILabel = {
        let label = UILabel()
        let attributedStr = NSMutableAttributedString(string: "kg")
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 13)!, .foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)]
        attributedStr.addAttributes(attr, range: NSRange(location: 0, length: attributedStr.length))
        label.attributedText = attributedStr
        return label
    }()

    // 体重显示视图
    private lazy var weightView: UIView = {
        let view = UIView()
        view.addSubview(self.weightNumberLabel)
        view.addSubview(self.weightUnitLabel)
        self.weightNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2.fit)
            make.bottom.equalToSuperview().offset(-2.fit)
            make.left.equalToSuperview()
        }

        self.weightUnitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6.fit)
            make.bottom.equalToSuperview().offset(-6.fit)
            make.left.equalTo(self.weightNumberLabel.snp.right).offset(6.fit)
            make.right.equalToSuperview().offset(-4.fit)
        }
        return view
    }()

    // 卡路里渐变视图
    private lazy var caloriesGradientView: UIView = {
        let layerView = UIView()
        layerView.frame = CGRect(x: 30.fit, y: 95.fit, width: 44.fit, height: 6.fit)
        let bgGradient = CAGradientLayer()
        bgGradient.colors = [UIColor(red: 0.26, green: 0.85, blue: 0.8, alpha: 1).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        bgGradient.locations = [0, 1]
        bgGradient.frame = layerView.bounds
        bgGradient.startPoint = CGPoint(x: 0.5, y: 0)
        bgGradient.endPoint = CGPoint(x: 0.5, y: 1)
        layerView.layer.addSublayer(bgGradient)
        layerView.layer.cornerRadius = 3
        layerView.layer.masksToBounds = true
        layerView.alpha = 1
        return layerView
    }()

    // 卡路里标题视图
    private lazy var caloriesLabel = getTitleLabel(placeHolder: "摄入")

    // 卡路里数值视图
    private lazy var caloriesNumberLabel: UILabel = {
        let label = UILabel()
        let caloriesAttrString = NSMutableAttributedString(string: "1")
        let attr2: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 19)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        caloriesAttrString.addAttributes(attr2, range: NSRange(location: 0, length: caloriesAttrString.length))
        label.attributedText = caloriesAttrString
        label.textAlignment = .center
        return label
    }()

    // 卡路里单位视图
    private lazy var caloriesUnitLabel: UILabel = {
        let label = UILabel()
        let attributedStr = NSMutableAttributedString(string: "cal")
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 13)!, .foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)]
        attributedStr.addAttributes(attr, range: NSRange(location: 0, length: attributedStr.length))
        label.attributedText = attributedStr
        return label
    }()

    // 卡路里显示视图
    private lazy var caloriesView: UIView = {
        let view = UIView()
        view.addSubview(self.caloriesNumberLabel)
        view.addSubview(self.caloriesUnitLabel)
        self.caloriesNumberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2.fit)
            make.bottom.equalToSuperview().offset(-2.fit)
            make.left.equalToSuperview()
        }

        self.caloriesUnitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6.fit)
            make.bottom.equalToSuperview().offset(-6.fit)
            make.left.equalTo(self.caloriesNumberLabel.snp.right).offset(6.fit)
            make.right.equalToSuperview().offset(-4.fit)
        }
        return view
    }()

    // 圆环视图
    private lazy var roundView: CircleProgressView = {
        let progressView = CircleProgressView()
        progressView.updateUI(with: 30)
        return progressView
    }()

    // MARK: - 公有方法

    public func updateUI(weight: Int, calories: Int, percent: Int) {
        weightNumberLabel.text = String(weight)
        caloriesNumberLabel.text = String(calories)
        roundView.updateUI(with: percent)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - 私有方法

    func configUI() {
        backView.addSubview(weightGradientView)
        backView.addSubview(weightLabel)
        backView.addSubview(weightView)
        backView.addSubview(caloriesGradientView)
        backView.addSubview(caloriesLabel)
        backView.addSubview(caloriesView)
        backView.addSubview(roundView)
        addSubview(backView)
        
        // layout
        
        weightLabel.snp.makeConstraints { (make) in
            make.width.equalTo(50.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(30.fit)
            make.top.equalTo(self.weightGradientView.snp.bottom).offset(6.fit)
        }
        
        weightView.snp.makeConstraints { (make) in
            make.width.equalTo(60.fit)
            make.height.equalTo(30.fit)
            make.left.equalToSuperview().offset(30.fit)
            make.top.equalTo(self.weightLabel.snp.bottom).offset(4.fit)
        }
        
        caloriesLabel.snp.makeConstraints { (make) in
            make.width.equalTo(50.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(30.fit)
            make.top.equalTo(self.caloriesGradientView.snp.bottom).offset(6.fit)
        }
        
        caloriesView.snp.makeConstraints { (make) in
            make.width.equalTo(60.fit)
            make.height.equalTo(30.fit)
            make.left.equalToSuperview().offset(30.fit)
            make.top.equalTo(self.caloriesLabel.snp.bottom).offset(4.fit)
        }
        
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(20.fit)
            make.right.equalTo(self.snp.right).offset(-20.fit)
            make.top.equalToSuperview().offset(10.fit)
            make.bottom.equalToSuperview().offset(-10.fit)
        }
        
        roundView.snp.makeConstraints { (make) in
            make.width.height.equalTo(140.fit)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-30.fit)
        }
    }

    private func getTitleLabel(placeHolder: String) -> UILabel {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: placeHolder)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }
}
