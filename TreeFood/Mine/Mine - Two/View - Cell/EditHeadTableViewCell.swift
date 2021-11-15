//
//  EditBodyTableViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/4.
//

import UIKit

class EditHeadTableViewCell: UITableViewCell {
    
    public func updateUI(with title:String, image: UIImage) {
        self.contentLabel.text = title
        self.userImage.image = image
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var userImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 32
        imageview.clipsToBounds = true
        return imageview
    }()

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "修改头像")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 16)!, .foregroundColor: UIColor(red: 0.57, green: 0.54, blue: 0.54, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()

    func configUI() {
        addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.width.equalTo(64.fit)
            make.height.equalTo(64.fit)
            make.left.equalToSuperview().offset(22.fit)
            make.top.equalToSuperview().offset(19.fit)
        }
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.width.equalTo(100.fit)
            make.height.equalTo(22.fit)
            make.left.equalToSuperview().offset(103.fit)
            make.top.equalToSuperview().offset(40.fit)
        }
    }
}
