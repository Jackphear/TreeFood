//
//  PreferenceCollectionViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/20.
//

import UIKit

class PreferenceCollectionViewCell: HomeBaseCollectionViewCell {
    // MARK: - 公有属性

    var cellCallBack: ((Dish, Species) -> Void)?

    // MARK: - 私有属性

    private let preferenceCellID = "preferenceCell"
    private var data = [Dish]()
    private var foodType = [Species]()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        layout.scrollDirection = .horizontal // 横向滚动
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(PreferenceCell.self, forCellWithReuseIdentifier: preferenceCellID)
        return collectionView
    }()

    // MARK: - 公有方法

    public func updateUI(with data: [Dish], FoodType: [Species]) {
        self.data = data
        foodType = FoodType
        collectionView.reloadData()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 私有方法

    private func configUI() {
        titleLabel.text = "最近偏爱"
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(15.fit)
            make.right.equalTo(self)
            make.top.equalTo(self).offset(CellTopOffset - 8.fit)
            make.height.equalTo(180.fit)
        }
    }
}

extension PreferenceCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: preferenceCellID, for: indexPath) as! PreferenceCell
        cell.backgroundColor = UIColor(r: 1, g: 1, b: 1, alpha: 1)
        cell.imageView.image = UIImage(named: data[indexPath.row].image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callBack = cellCallBack {
            callBack(data[indexPath.row], foodType[indexPath.row])
        }
    }
}

extension PreferenceCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 153, height: 164)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

class PreferenceCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()

    override func layoutSubviews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(160.fit)
            make.width.equalTo(160.fit)
        }
    }
}
