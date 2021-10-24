//
//  MoreDishViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/24.
//

import UIKit

class MoreDishViewController: UIViewController {
    // MARK: - 公有属性

    var cellCallBack: ((Dish) -> Void)?

    // MARK: - 私有属性

    private var data = [Dish]()
    private var foodType = [Species]()
    private let MoreDishCellID = "MoreDishCell"
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MoreDishCell.self, forCellWithReuseIdentifier: MoreDishCellID)
        return collectionView
    }()

    // MARK: - 公有方法

    public func updateUI(with data: [Dish], types: [Species]) {
        self.data = data
        self.foodType = types
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavbar()
    }

    // MARK: - 私有方法

    private func configUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ (make) in
            make.height.equalTo(CFHeight - 120.fit)
            make.width.equalTo(CFWidth - 60.fit)
            make.top.equalToSuperview().offset(110.fit)
            make.left.equalToSuperview().offset(30.fit)
        }
    }
    
    private func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.item.title = "每日推荐"
    }
}

extension MoreDishViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreDishCellID, for: indexPath) as! MoreDishCell
        cell.updataUI(with: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("moredishcell to do")
    }
    
}

extension MoreDishViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 345.fit, height: 175.fit)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60.fit
    }
    
}


class MoreDishCell: UICollectionViewCell {
    func updataUI(with data: Dish) {
        contentImage.image = UIImage(named: data.image)
        nameLabel.text = data.name
    }

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        let attrString = NSMutableAttributedString(string: "素食拼盘")
        label.numberOfLines = 2
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Regular", size: 15)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()

    lazy var contentImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configUI() {
        addSubview(contentImage)
        addSubview(nameLabel)
        contentImage.snp.makeConstraints { make in
            make.height.equalTo(175.fit)
            make.width.equalTo(345.fit)
            make.left.equalToSuperview().offset(0.fit)
            make.top.equalToSuperview().offset(0.fit)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(18.fit)
            make.width.equalTo(260.fit)
            make.left.equalToSuperview().offset(0.fit)
            make.top.equalToSuperview().offset(190.fit)
        }
    }
}
