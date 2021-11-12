//
//  CalendarCollectionViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/12.
//

import UIKit

class CalendarCollectionViewCell: UITableViewCell {
    lazy var father: UIView = {
        let vi = UIView(frame: CGRect(x: 145, y: 15, width: 244, height: 190))
        vi.backgroundColor = .clear
        return vi
    }()

    lazy var content: UIView = {
        let layerView = UIView()
        layerView.frame = CGRect(x: 0, y: 0, width: 245, height: 36)
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0.98, green: 0.82, blue: 0.78, alpha: 1).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 5
        // fill
        layerView.backgroundColor = UIColor(red: 0.96, green: 0.79, blue: 0.56, alpha: 1)
        layerView.layer.cornerRadius = 7
        layerView.alpha = 1
        return layerView
    }()

    lazy var title: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "早餐")
        label.frame = CGRect(x: 12, y: 6, width: 35, height: 24)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 17)!, .foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()

    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 199, y: 0, width: 46, height: 36))
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 0.96, green: 0.46, blue: 0.33, alpha: 1)
        button.cornerRadius = 10
        return button
    }()

    @objc func click() {
    }

    lazy var textView: UITextView = {
        let textfield = UITextView()
        textfield.frame = CGRect(x: 0.fit, y: 24.fit, width: 244.fit, height: 177.fit)
        // shadowCode
        textfield.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        textfield.layer.shadowOffset = CGSize(width: 0, height: 3)
        textfield.layer.shadowOpacity = 1
        textfield.layer.shadowRadius = 6
        // fill
        textfield.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.97, alpha: 1)
        textfield.layer.cornerRadius = 34
        textfield.alpha = 0.8
        textfield.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        textfield.showsVerticalScrollIndicator = false
        textfield.font = UIFont(name: "PingFang SC", size: 15)
        textfield.text = "一杯牛奶，一片面包，一根香肠，一片吐司，一个蛋挞"
        return textfield
    }()

    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 25, y: 15, width: 79, height: 20))
        let attrString = NSMutableAttributedString(string: "7:30 AM")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.29, green: 0.28, blue: 0.26, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configUI() {
        content.addSubview(title)
        content.addSubview(button)
        father.addSubview(textView)
        father.addSubview(content)
        addSubview(father)
        addSubview(label)
    }
}
