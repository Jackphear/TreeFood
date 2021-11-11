//
//  WaterIntakeCollectionViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/11.
//

import UIKit

class WaterIntakeCollectionViewCell: UICollectionViewCell {
    // MARK: - 私有变量

    private var target: CGFloat = 2
    private var accomplish: CGFloat = 2

    // 背景
    private var backView: UIView = {
        let layerView = UIView()
        layerView.frame = CGRect(x: 20.fit, y: 10.fit, width: 370.fit, height: 134.fit)
        // fill
        let bgGradient = CAGradientLayer()
        bgGradient.colors = [UIColor(red: 0.96, green: 0.46, blue: 0.33, alpha: 0.3).cgColor, UIColor(red: 0.98, green: 0.93, blue: 0.88, alpha: 0.3).cgColor]
        bgGradient.locations = [0, 1]
        bgGradient.frame = layerView.bounds
        bgGradient.startPoint = CGPoint(x: 0.5, y: 0)
        bgGradient.endPoint = CGPoint(x: 0.5, y: 1)
        layerView.layer.addSublayer(bgGradient)
        layerView.layer.cornerRadius = 8
        layerView.layer.masksToBounds = true
        // layerView.alpha = 0.5
        return layerView
    }()

    // 目标标签
    private var targetLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "目标: \(String(describing: target)) L")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Light", size: 12)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()

    // 完成标签
    private lazy var accomplishLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "\(String(describing: accomplish)) L")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 20)!, .foregroundColor: UIColor(red: 0.96, green: 0.46, blue: 0.33, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()

    private lazy var waterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "water"))
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - 公有方法

    public func updateUI(target: CGFloat, accomplish: CGFloat) {
        self.target = target
        self.accomplish = accomplish
        targetLabel.text = "目标: \(String(describing: self.target)) L"
        accomplishLabel.text = "\(String(describing: self.accomplish)) L"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - 私有方法

    private func configUI() {
        addSubview(backView)
        backView.addSubview(targetLabel)
        backView.addSubview(accomplishLabel)
        backView.addSubview(waterImageView)

        targetLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6.fit)
            make.width.equalTo(80.fit)
            make.height.equalTo(20.fit)
            make.centerX.equalToSuperview()
        }

        accomplishLabel.snp.makeConstraints { make in
            make.top.equalTo(self.targetLabel.snp.bottom).offset(8.fit)
            make.width.equalTo(70.fit)
            make.height.equalTo(30.fit)
            make.centerX.equalToSuperview()
        }

        waterImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.fit)
            make.right.equalToSuperview().offset(-20.fit)
            make.top.equalTo(self.accomplishLabel.snp.bottom).offset(10.fit)
            make.bottom.equalToSuperview().offset(-10.fit)
        }
    }
}
