//
//  MoreSupplementViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/25.
//

import UIKit

class MoreSupplementViewController: UIViewController {
    
    
    // MARK: - 公有属性

    // MARK: - 私有属性
    
    private var data = [Supplement]()
    private let MoreSupplementCellID = "supplementCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MoreSupplementCell.self, forCellReuseIdentifier: MoreSupplementCellID)
        tableView.rowHeight = 100.fit
        return tableView
    }()

    // MARK: - 公有方法

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigation()
    }
    
    public func updatUI(with data: [Supplement], title:String) {
        self.data = data
        tableView.reloadData()
        navigation.item.title = title
    }

    // MARK: - 私有方法
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigation.bar.snp.bottom)
            make.bottom.equalToSuperview().offset(-20.fit)
        }
    }
    
    private func configureNavigation() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        
    }
}

extension MoreSupplementViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreSupplementCellID, for: indexPath) as! MoreSupplementCell
        cell.updateUI(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SupplementDetailViewController()

        vc.updateUI(with: data[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class MoreSupplementCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateUI(_ data: Supplement) {
        leftImageView.image = UIImage(named: data.image)
        nameLabel.text = data.name
        // star
        var base: CGFloat = 0
        for _ in 0 ..< data.star {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "star")
            imageView.tintColor = .orange
            self.backView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.equalTo(self.nameLabel.snp.bottom).offset(10.fit)
                make.left.equalToSuperview().offset(100.fit + base)
                make.width.equalTo(10.fit)
                make.height.equalTo(10.fit)
            }
            base = base + 18.fit
        }
    }
    
    private lazy var backView: UIView = {
        let layerView = UIView()
        return layerView
    }()
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
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
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 15)!,.foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    private lazy var lineView: UIView = {
        let layerView = UIView()
        // strokeCode
        layerView.layer.borderColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1).cgColor
        layerView.layer.borderWidth = 1
        layerView.alpha = 1
        return layerView
    }()
    
    private func configureUI() {
        selectionStyle = .none
        addSubview(backView)
        backView.addSubview(leftImageView)
        backView.addSubview(nameLabel)
        backView.addSubview(lineView)
        
        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.fit)
            make.right.equalToSuperview().offset(-16.fit)
            make.top.bottom.equalToSuperview()
        }
        
        leftImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10.fit)
            make.width.height.equalTo(70.fit)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20.fit)
            make.left.equalToSuperview().offset(100.fit)
            make.width.equalTo(150.fit)
            make.height.equalTo(26.fit)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15.fit)
            make.bottom.equalToSuperview().offset(-9.fit)
            make.height.equalTo(1.fit)
            make.left.equalToSuperview().offset(100.fit)
        }
    }
}
