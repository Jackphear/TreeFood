//
//  HomeBaseCollectionViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/20.
//

import UIKit

class HomeBaseCollectionViewCell: UICollectionViewCell {
    private let TopSpacing = 14.fit

    // 更多按钮回调
    public var moreButtonBlock: (() -> ())?

    public func updateUI(with text: String) {
        titleLabel.text = text
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 控件初始化

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangSC-Semibold", size: 20.fit)
        label.textColor = UIColor(r: 56, g: 56, b: 56)
        return label
    }()

    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(more), for: .touchUpInside)
        return button
    }()

    lazy var moreLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "更多")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Light", size: 15)!, .foregroundColor: UIColor(red: 0.98, green: 0.59, blue: 0.48, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()

    lazy var moreImageView: UIView = {
        let image = UIImage(systemName: "chevron.right")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 15, weight: .bold))
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor(red: 0.98, green: 0.59, blue: 0.48, alpha: 1)
        return imageView
    }()

    // MARK: - 私有方法

    private func setUpUI() {
        addSubview(titleLabel)
        addSubview(moreLabel)
        addSubview(moreImageView)
        addSubview(moreButton)

        moreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(TopSpacing)
            make.width.equalTo(40.fit)
            make.height.equalTo(28.fit)
            make.right.equalToSuperview().offset(-30.fit)
        }

        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(28.fit)
            make.width.equalTo(200.fit)
            make.left.equalToSuperview().offset(15.fit)
            make.top.equalToSuperview().offset(TopSpacing)
        }

        moreImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18.fit)
            make.width.equalTo(16.fit)
            make.height.equalTo(16.fit)
            make.right.equalToSuperview().offset(-12.fit)
        }

        moreButton.snp.makeConstraints { make in
            make.height.equalTo(28.fit)
            make.width.equalTo(40.fit)
            make.right.equalToSuperview().offset(-12.fit)
            make.top.equalToSuperview().offset(TopSpacing)
        }
    }

    @objc func more() {
        if let block = moreButtonBlock {
            block()
        }
    }
}
