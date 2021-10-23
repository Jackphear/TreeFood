//
//  SearchCollectionViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/20.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    // MARK: - 公有属性

    public var cellCallBack: ((Species) -> Void)?
    public var searchCallBack: (() -> Void)?

    // MARK: - 私有属性

    private var data = [Dishes]()
    fileprivate let searchCellID = "searchCell"

    // 背景
    private lazy var searchView: UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        vi.layer.cornerRadius = 20.fit
        vi.layer.masksToBounds = true
        return vi
    }()

    //
    private lazy var searchBarBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.textAlignment = .left
        btn.addTarget(self, action: #selector(searchBarClick), for: .touchUpInside)
        return btn
    }()

    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "search"))
        return imageView
    }()

    // 文本框
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.fit)
        label.textColor = UIColor(r: 56, g: 56, b: 56)
        label.text = "搜索"
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false // 隐藏滑动条
        collectionView.alwaysBounceHorizontal = true
        collectionView.delegate = self
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: searchCellID)
        return collectionView
    }()

    // MARK: - 公有方法

    public func updateUI(with data: [Dishes]) {
        self.data = data
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
        backgroundColor = .white
        addSubview(collectionView)
        addSubview(searchView)
        searchView.addSubview(searchImageView)
        searchView.addSubview(titleLabel)
        searchView.addSubview(searchBarBtn)

        collectionView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16.fit)
            make.right.equalToSuperview()
            make.top.equalTo(self.searchView.snp.bottom).offset(18.fit)
            make.height.equalTo(110.fit)
        }

        searchView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(20.fit)
            make.right.equalTo(self).offset(-20.fit)
            make.top.equalTo(self).offset(10.fit)
            make.height.equalTo(40.fit)
        }

        searchImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(32.fit)
            make.width.equalTo(20.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(20.fit)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.searchImageView.snp.right).offset(6.fit)
            make.width.equalTo(40.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(30.fit)
        }

        searchBarBtn.snp.makeConstraints { make in
            make.left.equalTo(self).offset(70.fit)
            make.right.equalTo(self).offset(-90.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(30.fit)
        }
    }

    @objc func searchBarClick() {
        if let callback = searchCallBack {
            callback()
        }
    }
}

extension SearchCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCellID, for: indexPath) as! SearchCell
        switch indexPath.row {
        case 0:
            cell.updateUI(with: .Breakfast)
        case 1:
            cell.updateUI(with: .Launch)
        case 2:
            cell.updateUI(with: .Dinner)
        case 3:
            cell.updateUI(with: .Snacks)
        default:
            cell.updateUI(with: .Breakfast)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callBack = cellCallBack {
            switch indexPath.row {
            case 0:
                callBack(.Breakfast)
            case 1:
                callBack(.Launch)
            case 2:
                callBack(.Dinner)
            case 3:
                callBack(.Snacks)
            default:
                break
            }
        }
    }

    // cell大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.fit, height: 100.fit)
    }

    // cell间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.fit
    }
}

// MARK: - 列表cell

class SearchCell: UICollectionViewCell {
    public func updateUI(with type: Species) {
        imageView.image = UIImage(named: type.rawValue)
        infoLabel.text = type.rawValue
    }

    private lazy var backView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 6
        layerView.backgroundColor = UIColor(red: 0.99, green: 0.98, blue: 0.97, alpha: 1)
        layerView.layer.cornerRadius = 14
        layerView.alpha = 1
        return layerView
    }()

    private lazy var imageView: UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.backgroundColor = .clear
        imageVIew.image = UIImage(named: "header")
        imageVIew.contentMode = .scaleAspectFill
        return imageVIew
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "早餐")
        label.frame = CGRect(x: 45, y: 184, width: 27, height: 18)
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Medium", size: 13)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.textAlignment = .center
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .clear

        addSubview(backView)
        backView.addSubview(infoLabel)
        backView.addSubview(imageView)

        backView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(4.fit)
            make.bottom.right.equalToSuperview().offset(-4.fit)
        }

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(14.fit)
            make.width.height.equalTo(40.fit)
        }

        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(40.fit)
            make.height.equalTo(20.fit)
            make.top.equalTo(self.imageView.snp.bottom).offset(8.fit)
        }
    }
}
