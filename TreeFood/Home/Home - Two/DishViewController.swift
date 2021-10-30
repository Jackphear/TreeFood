//
//  DIshDetailViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/25.
//

import UIKit

class DishViewController: UIViewController {
    // MARK: - 公有属性

//    var cellCallBack: ((Dish) -> ())?

    // MARK: - 私有属性

    private var data = Dishes()
    private var foodType = Species.Breakfast
    private let DishCellID = "DishCell"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        layout.scrollDirection = .vertical
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(DishCell.self, forCellWithReuseIdentifier: DishCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - 公有方法

    public func updateUI(with data: Dishes, type: Species) {
        self.data = data
        foodType = type
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    // MARK: - 私用方法

    private func configUI() {
        navigation.bar.isShadowHidden = true
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(10.fit)
            make.bottom.equalToSuperview()
        }
    }
}

extension DishViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCellID, for: indexPath) as! DishCell
        cell.updateUI(with: data.content[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DishDetailViewController()
        vc.updateUI(with: data.content[indexPath.row], types: foodType)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DishViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180.fit, height: 291.fit)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.fit
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 21, left: 13, bottom: 0, right: 13)
    }
    
}

class DishCell: UICollectionViewCell {
    public func updateUI(with data: Dish) {
        namelabel.text = data.name
        materialslabel.text = data.description
        contentimage.image = UIImage(named: data.image)
    }

    lazy var contentimage: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "素食拼盘")
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        return imageview
    }() // 菜品图片

    lazy var namelabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "素食拼盘")
        label.numberOfLines = 2
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }() // 菜品名字

    lazy var materialslabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "用料：牛油果、鸡蛋、青菜、山楂")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 12)!, .foregroundColor: UIColor(red: 0.71, green: 0.68, blue: 0.68, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }() // 原料内容

    override func layoutSubviews() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOffset = CGSize(width: 0.fit, height: 5.fit)
        layer.shadowOpacity = 1
        layer.shadowRadius = 6
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 8
        addSubview(contentimage)
        addSubview(namelabel)
        addSubview(materialslabel)
        contentimage.snp.makeConstraints { make in
            make.height.equalTo(201.fit)
            make.width.equalTo(180.fit)
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        namelabel.snp.makeConstraints { make in
            make.height.equalTo(20.fit)
            make.width.equalTo(160.fit)
            make.left.equalToSuperview().offset(13.fit)
            make.top.equalTo(self.contentimage.snp.bottom).offset(14.fit)
        }

        materialslabel.snp.makeConstraints { make in
            make.height.equalTo(40.fit)
            make.width.equalTo(160.fit)
            make.left.equalToSuperview().offset(13.fit)
            make.top.equalTo(self.namelabel.snp.bottom).offset(0.fit)
        }
    }
}
