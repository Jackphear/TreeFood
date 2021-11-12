//
//  CalendarHeadViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/12.
//

import UIKit

class CalendarHeadViewCell: UITableViewHeaderFooterView {
    // 标题
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "PingFangSC-Semibold", size: 24.fit)
        label.textColor = UIColor(r: 56, g: 56, b: 56)
        label.text = "6月15日"
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(20.fit)
            make.width.equalTo(300.fit)
            make.height.equalTo(30.fit)
        }
    }
}
