//
//  EditHeadTableViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/4.
//

import UIKit

class EditBodyTableViewCell: UITableViewCell {
    public func updateUI(with title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "PingFang SC", size: 16)
        label.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54, alpha: 1)
        label.alpha = 1
        return label
    }()

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "PingFang SC", size: 16)
        label.textColor = UIColor(red: 0.57, green: 0.54, blue: 0.54, alpha: 1)
        label.alpha = 1
        return label
    }()

    func configUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(84.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(22.fit)
            make.top.equalToSuperview().offset(15.fit)
        }
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.width.equalTo(104.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(103.fit)
            make.top.equalToSuperview().offset(15.fit)
        }
    }
}
