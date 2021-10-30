//
//  SupplementViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/30.
//

import UIKit

class SupplementDetailViewController: UIViewController {
    // MARK: - 公有属性

    // MARK: - 私有属性
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 30
        view.alpha = 1
        return view
    }()
    
    lazy var backgroundImage: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.image = UIImage(named: "乳清蛋白粉")
        return img
    }()
    
    lazy var heartView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "hot")
        return imageView
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let attrString = NSMutableAttributedString(string: "4065")
        label.frame = CGRect(x: 313, y: 401, width: 37, height: 22)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 17)!, .foregroundColor: UIColor(red: 0.9, green: 0.36, blue: 0.36, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    lazy var useBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        view.layer.cornerRadius = 2
        view.alpha = 1
        return view
    }()
    
    lazy var useView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 14
        view.alpha = 1
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 6
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let attrString = NSMutableAttributedString(string: "乳清蛋白粉")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 22)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    lazy var introducelabel: UILabel = {
        let label = UILabel(frame: .zero)
        let attrString = NSMutableAttributedString(string: "乳清蛋白粉是采用先进工艺从牛奶分离提取出来的珍贵蛋白质，以其纯度高、吸收率高、氨基酸组成最合理等诸多优势被推为“蛋白之王”。乳清蛋白不但容易消化，而且还具有高生物价、高消化率、高蛋白质功效比和高利用率，是蛋白质中的精品。含有人体所需的所有氨基酸，其氨基酸组成模式与骨骼肌中的氨基酸组成模式几乎完全一致，极其容易被人体吸收。")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-light", size: 14)!, .foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    lazy var useWayLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let attrString = NSMutableAttributedString(string: "服用方法")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 20)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    lazy var useThingTopLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let attrString = NSMutableAttributedString(string: "【标准用法】")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    lazy var useThingBottomLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let attrString = NSMutableAttributedString(string: "【注意事项】")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    lazy var standardLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let attrString = NSMutableAttributedString(string: "运动后30~40分钟内，喝1~2份约22-45克）乳清蛋白")
        label.numberOfLines = 0
        
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    lazy var attenionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        let attrString = NSMutableAttributedString(string: "兑乳清蛋白粉的水，不要使用滚开水，会破坏营养成分；另外酸性物质也会使蛋白质变性，产生絮状沉淀，影响氨基酸被人体的 吸收率，所以也尽量避免果汁等酸性饮料相兑。")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()
    
    // MARK: - 顶部导航栏
    lazy var titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 390, height: kNavBarHeight))
        view.addSubview(self.leftBackImageView)
        view.addSubview(self.leftButton)
        view.addSubview(self.rightShareImageView)
        view.addSubview(self.rightButton)
        return view
    }()

    lazy var leftBackImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = CGRect(x: 10.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        return imageView
    }()

    lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .touchUpInside)
        return button
    }()

    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 390 - 40.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        button.addTarget(self, action: #selector(clickRightShareButton), for: .touchUpInside)
        return button
    }()

    lazy var rightShareImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "share"))
        imageView.frame = CGRect(x: 390 - 40.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        return imageView
    }()

    // MARK: - 公有方法

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
    }
    
    public func updateUI(with data: Supplement) {
        backgroundImage.image = UIImage(named: data.image)
        nameLabel.text = data.name
        introducelabel.text = data.description
        standardLabel.text = data.usage
        let attrString = NSMutableAttributedString(string: data.precautions)
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.24, green: 0.24, blue: 0.24, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        var size = attrString.size()
        size.height = size.height * ceil(size.width / 250)
        attenionLabel.text = data.precautions
        attenionLabel.snp.updateConstraints { (make) in
            make.height.equalTo(size.height)
        }
    }

    // MARK: - 私有方法
    
    func configUI(){
        view.backgroundColor = .white
        view.addSubview(backgroundImage)
        view.addSubview(scrollView)
        
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(heartView)
        backgroundView.addSubview(useBackgroundView)
        backgroundView.addSubview(numberLabel)
        backgroundView.addSubview(nameLabel)
        backgroundView.addSubview(introducelabel)
        
        useBackgroundView.addSubview(useView)
        useBackgroundView.addSubview(useWayLabel)
        
        useView.addSubview(useThingTopLabel)
        useView.addSubview(useThingBottomLabel)
        useView.addSubview(standardLabel)
        useView.addSubview(attenionLabel)
        
        backgroundImage.snp.makeConstraints { make in
            make.height.equalTo(400.fit)
            make.width.equalTo(CFWidth.fit)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints{ make in
            make.top.left.right.bottom.equalToSuperview()
            //只需要size大于frame即可符合原设计
            scrollView.contentSize = CGSize(width: CFWidth, height: CFHeight + 1)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(280.fit)
            make.width.equalTo(CFWidth.fit)
            make.height.equalTo(400.fit)
        }
        
        useBackgroundView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(CFWidth)
            make.top.equalToSuperview().offset(250.fit)
            make.height.equalTo(360.fit)
        }
        useView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.fit)
            make.right.equalToSuperview().offset(-24.fit)
            make.top.equalToSuperview().offset(54.fit)
            make.bottom.equalToSuperview().offset(-30.fit)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(26.fit)
            make.width.equalTo(130.fit)
            make.left.equalToSuperview().offset(26.fit)
            make.top.equalToSuperview().offset(35.fit)
        }
        heartView.snp.makeConstraints { make in
            make.height.equalTo(14.fit)
            make.width.equalTo(16.fit)
            make.left.equalTo(nameLabel.snp.right).offset(175.fit)
            make.top.equalToSuperview().offset(40.fit)
        }
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35.fit)
            make.left.equalTo(self.heartView.snp.right).offset(4.fit)
            make.width.equalTo(50.fit)
            make.height.equalTo(22.fit)
        }
        introducelabel.snp.makeConstraints { make in
            make.width.equalTo(354.fit)
            make.bottom.equalTo(useBackgroundView.snp.top).offset(-25.fit)
            make.top.equalTo(nameLabel.snp.bottom).offset(14.fit)
            make.left.equalTo(30.fit)
        }
        useWayLabel.snp.makeConstraints { make in
            make.height.equalTo(24.fit)
            make.width.equalTo(380.fit)
            make.top.equalTo(useBackgroundView.snp.top).offset(20.fit)
            make.left.equalTo(useBackgroundView.snp.left).offset(36.fit)
        }
        useThingTopLabel.snp.makeConstraints { make in
            make.height.equalTo(24.fit)
            make.width.equalTo(90.fit)
            make.top.equalTo(useView.snp.top).offset(25.fit)
            make.left.equalTo(useView.snp.left).offset(6.fit)
        }
        
        useThingBottomLabel.snp.makeConstraints { make in
            make.height.equalTo(24.fit)
            make.width.equalTo(90.fit)
            make.top.equalTo(useThingTopLabel.snp.bottom).offset(70.fit)
            make.left.equalTo(useView.snp.left).offset(6.fit)
        }
        standardLabel.snp.makeConstraints { make in
            make.height.equalTo(45.fit)
            make.top.equalTo(useThingTopLabel.snp.top)
            make.right.equalTo(useView.snp.right).offset(-10.fit)
            make.left.equalTo(useThingTopLabel.snp.right).offset(10.fit)
        }
        attenionLabel.snp.makeConstraints { make in
            make.top.equalTo(useThingBottomLabel.snp.top)
            make.right.equalToSuperview().offset(-10.fit)
            make.left.equalTo(useThingBottomLabel.snp.right).offset(10.fit)
        }
    }
    
    func configNavbar() {
        navigation.bar.isShadowHidden = true
        navigation.bar.alpha = 0
        // 顶部导航
        navigation.bar.backBarButtonItem = nil
        navigation.item.titleView = titleView
    }

    // 返回按钮事件
    @objc func clickLeftBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc func clickRightShareButton() {
        // TODO: - 分享
    }
}
