//
//  DishContentView.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/29.
//

import UIKit

class DishContentView: UIView {
    //MARK: -公有属性
    public var buttonBlock:(() -> ())?
    public var scrollBlock:((Bool) -> ())?
    public var tableScroll = false
    
    //MARK: -私有属性
    private var dish = Dish()
    private var caloris:Int = 0
    private var data = [Ingredient]()
    
    
    private let ingredientsCellID = "ingredientsCell"
    private let CalorisTotalCellID = "CalorisTotalCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        let attrString = NSMutableAttributedString(string: "鹰嘴豆沙拉")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 19)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "地中海鹰嘴豆沙拉具有香脆的味道，明亮的色彩，大量健康的营养成分以及足够的纤维和蛋白质，可让您数小时饱饱而加油。这是一种非常灵活的食谱，非常适合准备餐食，快速的平日晚餐或令人印象深刻的便餐或野餐。天然无素食和无麸质......")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Light", size: 14)!,.foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    
    private lazy var topRightAddButtonImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "addBack"))
        return imageView
    }()
    
    private lazy var topRightAddButton: UIButton = {
        let button = UIButton(type: .custom)
        let attr = NSAttributedString(string: "添加", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 14)!, .foregroundColor: UIColor.gray])
        let attr2 = NSAttributedString(string: "已添加", attributes: [NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 14)!, .foregroundColor: UIColor.black])
        button.setAttributedTitle(attr, for: UIControl.State.normal)
        button.setAttributedTitle(attr2, for: UIControl.State.selected)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(clickAddButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "食材")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 17)!,.foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()
    //监听滑动
    lazy var ingredientsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ingredientsCell.self, forCellReuseIdentifier: ingredientsCellID)
        tableView.register(CalorisTotalTableViewCell.self, forCellReuseIdentifier: CalorisTotalCellID)
        return tableView
    }()
    
    private lazy var ingredientsBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        return view
    }()
    
    
    //MARK: -公有方法
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    
    public func updateUI(with data: Dish) {
        self.titleLabel.text = data.name
        self.descriptionLabel.text = data.description
        self.caloris = data.totalCaloris
        ingredientsTableView.reloadData()
        self.dish = data
        self.data = data.ingredients
    }
    
    //MARK: -私有方法
    func configUI() {
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(topRightAddButtonImageView)
        self.addSubview(topRightAddButton)
        
        self.addSubview(ingredientsBackView)
        ingredientsBackView.addSubview(ingredientsTitleLabel)
        ingredientsBackView.addSubview(ingredientsTableView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30.fit)
            make.left.equalToSuperview().offset(25.fit)
            make.width.equalTo(150.fit)
            make.height.equalTo(30.fit)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(25.fit)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10.fit)
            make.width.equalTo(CFWidth - 50.fit)
            make.height.equalTo(120.fit)
        }

        topRightAddButtonImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right).offset(150.fit)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.height.equalTo(30.fit)
            make.width.equalTo(70.fit)
        }

        topRightAddButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp.right).offset(150.fit)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.height.equalTo(30.fit)
            make.width.equalTo(70.fit)
        }
        
        ingredientsBackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200.fit)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(206)
            make.width.equalTo(CFWidth)
        }
        
        ingredientsTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(36.fit)
            make.top.equalToSuperview().offset(20.fit)
            make.width.equalTo(40.fit)
            make.height.equalTo(24.fit)
        }

        ingredientsTableView.snp_makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(CFWidth)
            make.top.equalTo(self.ingredientsTitleLabel.snp.bottom).offset(6.fit)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func clickAddButton(){
        self.topRightAddButton.isSelected = !self.topRightAddButton.isSelected
        buttonBlock?()
    }
}

extension DishContentView: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !tableScroll {
            scrollView.contentOffset.y = 0
        } else {
            if scrollView.contentOffset.y <= 0 {
                tableScroll = false
                scrollBlock?(true)
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return data.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ingredientsCellID, for: indexPath) as! ingredientsCell
            cell.updateUI(data[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CalorisTotalCellID, for: indexPath) as! CalorisTotalTableViewCell
            cell.updateUI(caloris)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100.fit
        case 1:
            return 65.fit
        default:
            return 0.fit
        }
    }
}

class bottomScrollView: UIScrollView, UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
