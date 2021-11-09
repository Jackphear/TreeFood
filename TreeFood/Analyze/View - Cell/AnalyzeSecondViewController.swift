//
//  ArchiveSecondViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/9.
//

import UIKit

class AnalyzeSecondViewController: UIViewController {

    //MARK: -私有属性
    
    let bodyData = [
        BodyInformationModel(imageName: "heartRate", titleName: "心率", timeString: "4月19日 11：18", number: 75, unitString: "次/分", color: UIColor(red: 0.76, green: 0.86, blue: 0.95, alpha: 1)),
        BodyInformationModel(imageName: "bloodPressure", titleName: "血压", timeString: "4月18日 20：28", number: 80, unitString: "mmHg", color: UIColor(red: 0.87, green: 0.93, blue: 0.61, alpha: 1)),
        BodyInformationModel(imageName: "height", titleName: "身高", timeString: "4月7日 11：43", number: 168, unitString: "CM", color: UIColor(red: 0.65, green: 0.86, blue: 0.9, alpha: 1)),
        BodyInformationModel(imageName: "weight", titleName: "体重", timeString: "4月9日 11：18", number: 52, unitString: "KG", color: UIColor(red: 0.96, green: 0.79, blue: 0.56, alpha: 1)),
        BodyInformationModel(imageName: "bmi", titleName: "BMI", timeString: "4月19日 21：18", number: 17.2, unitString: "KG/m2", color: UIColor(red: 0.96, green: 0.57, blue: 0.41, alpha: 1)),
    ]
    
    private let AnalyzeSecondCellID = "AnalyzeSecondCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AnalyzeSecondCell.self, forCellReuseIdentifier: AnalyzeSecondCellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 116.fit
        return tableView
    }()
    
    //MARK: - 公有方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()

    }
    
    //MARK: -私有方法
    
    private func configUI() {
        
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        
        view.backgroundColor =  UIColor(r: 254, g: 254, b: 254)
        view.corner(byRoundingCorners: [.topLeft,.topRight], radii: 20.fit)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20.fit)
            make.left.right.equalToSuperview().offset(0.fit)
            make.bottom.equalToSuperview()
        }
    }

}

extension AnalyzeSecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnalyzeSecondCellID, for: indexPath) as! AnalyzeSecondCell
        cell.updateUI(bodyData[indexPath.row])
        return cell
    }
    
    
    
}




class AnalyzeSecondCell: UITableViewCell {
    
    // MARK: - 私有变量

    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "素食拼盘")
        return imageView
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "心率")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 16)!,.foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "4月19日 11：18")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 11)!,.foregroundColor: UIColor(red: 0.8, green: 0.78, blue: 0.78,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.textAlignment = .center
        label.attributedText = attrString
        label.alpha = 1;
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "75")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 17)!,.foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.textAlignment = .center
        label.alpha = 1;
        return label
    }()
    
    private lazy var unitLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "次/分")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFang SC", size: 11)!,.foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1), ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.textAlignment = .center
        label.alpha = 1;
        return label
    }()
    
    private lazy var rightBackView: UIView = {
        let layerView = UIView()
        layerView.frame = CGRect(x: 0, y: 0, width: 90.fit, height: 96.fit)
        layerView.backgroundColor = UIColor(red: 0.76, green: 0.86, blue: 0.95, alpha: 1)
        layerView.corner(byRoundingCorners: [.topRight, .bottomRight], radii: 12)
        return layerView
    }()
    
    // MARK: - 公有方法
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateUI(_ model: BodyInformationModel) {
        leftImageView.image = UIImage(named: model.imageName)
        titleLabel.text = model.titleName
        timeLabel.text = model.timeString
        unitLabel.text = model.unitString
        numberLabel.text = String(model.number)
        rightBackView.backgroundColor = model.color
    }
    
    // MARK: - 私有方法
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .white
        backView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backView.layer.shadowOpacity = 1
        backView.layer.shadowRadius = 6
        backView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        backView.layer.cornerRadius = 12
        
        addSubview(backView)
        
        backView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(36.fit)
            make.right.equalToSuperview().offset(-36.fit)
            make.top.equalToSuperview().offset(20.fit)
            make.bottom.equalToSuperview()
        }
        
        backView.addSubview(leftImageView)
        backView.addSubview(timeLabel)
        backView.addSubview(titleLabel)
        backView.addSubview(rightBackView)
        
        rightBackView.addSubview(numberLabel)
        rightBackView.addSubview(unitLabel)
        
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20.fit)
            make.centerY.equalToSuperview()
            make.width.equalTo(50.fit)
            make.height.equalTo(50.fit)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(190.fit)
            make.top.equalToSuperview().offset(20.fit)
            make.width.equalTo(50.fit)
            make.height.equalTo(30.fit)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(150.fit)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(-2.fit)
            make.width.equalTo(90.fit)
            make.height.equalTo(30.fit)
        }
        
        rightBackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(90.fit)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(20.fit)
            make.height.equalTo(25.fit)
            make.width.equalTo(80.fit)
        }
        
        unitLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(50.fit)
            make.height.equalTo(20.fit)
            make.top.equalTo(self.numberLabel.snp.bottom).offset(6.fit)
        }
    }
}
