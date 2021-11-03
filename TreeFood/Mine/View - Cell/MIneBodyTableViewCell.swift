//
//  MineHeadTableViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/3.
//

import UIKit

class MIneBodyTableViewCell: UITableViewCell {
    // MARK: - 私有属性

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.fit)
        label.text = "本周食谱"
        label.textColor = UIColor.black
        return label
    }()

    private lazy var rightIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mineRightArrow"))
        return imageView
    }()

    // MARK: - 公有方法

    public func updateUI(with title: String) {
        titleLabel.text = title
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40.fit)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(30.fit)
            make.width.equalTo(100.fit)
        }
        contentView.addSubview(rightIcon)
        rightIcon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-40.fit)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(16.fit)
            make.width.equalTo(16.fit)
        }
    }
}
