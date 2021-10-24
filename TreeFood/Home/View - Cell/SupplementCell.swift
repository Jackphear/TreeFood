//
//  SupplementCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/24.
//

import UIKit

class SupplementCell: UICollectionViewCell {
    public func updateUI(with data: Supplement) {
        leftImageView.image = UIImage(named: data.image)
        nameLabel.text = data.name

        // star
        var base: CGFloat = 0
        for _ in 0 ..< data.star {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "star")
            imageView.tintColor = .orange
            addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.equalTo(self.nameLabel.snp.bottom).offset(10.fit)
                make.left.equalToSuperview().offset(130.fit + base)
                make.width.equalTo(10.fit)
                make.height.equalTo(10.fit)
            }
            base = base + 18.fit
        }
    }

    private lazy var backView: UIView = {
        let layerView = UIView()
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.22).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 6
        // fill
        layerView.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.99, alpha: 1)
        layerView.alpha = 0.35
        layerView.layer.cornerRadius = 4
        return layerView
    }()

    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.alpha = 1
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "乳清蛋白粉")
        label.frame = CGRect(x: 126, y: 691, width: 78, height: 21)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        addSubview(leftImageView)
        addSubview(nameLabel)

        backView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18.fit)
            make.right.equalToSuperview().offset(-18.fit)
            make.top.equalToSuperview().offset(4.fit)
            make.bottom.equalToSuperview().offset(-4.fit)
        }

        leftImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.fit)
            make.width.equalTo(90.fit)
            make.top.equalToSuperview().offset(4.fit)
            make.bottom.equalToSuperview().offset(-4.fit)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.fit)
            make.left.equalToSuperview().offset(130.fit)
            make.width.equalTo(150.fit)
            make.height.equalTo(26.fit)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
