//
//  SupplementCollectionViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/20.
//

import DNSPageView
import UIKit

class SupplementCollectionViewCell: HomeBaseCollectionViewCell {
    // MARK: - 公有属性

    var cellCallBack: ((Supplement) -> Void)?

    // MARK: - 私有属性

    private var Pageview: PageView!

    lazy var style: PageStyle = {
        let style = PageStyle()
        style.isShowCoverView = true
        style.coverViewBackgroundColor = UIColor(red: 0.97, green: 0.58, blue: 0.48, alpha: 1)
        style.coverViewAlpha = 1
        style.coverViewRadius = 13
        style.coverViewHeight = 25
        style.coverMargin = 8
        style.titleSelectedColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        return style
    }()

    // MARK: - 公有方法

    public func updateUI(with data: [NutritionalSupplement]) {
        var titles = [String]()
        var controllers = [UIViewController]()
        for item in data {
            titles.append(item.categoryName)
            let vc = SupplementViewController(data: item.supplements)
            if let callback = cellCallBack {
                vc.cellCallBack = callback
            }
            controllers.append(vc)
        }
        Pageview = PageView(frame: CGRect(x: 12.fit, y: CellTopOffset - 10.fit, width: Int(CFWidth) - 24.fit, height: 300.fit), style: style, titles: titles, childViewControllers: controllers)
        addSubview(Pageview)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 私有方法

    func configUI() {
        titleLabel.text = "营养补给"
    }
}

class SupplementViewController: UIViewController {
    // MARK: - 公有属性

    var cellCallBack: ((Supplement) -> Void)?

    // MARK: - 私有属性

    var supplementCellID = "supplementCell"
    var data = [Supplement]()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: -10, y: 0, width: CFWidth, height: 300.fit), collectionViewLayout: layout)
        // 禁止滑动
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SupplementCell.self, forCellWithReuseIdentifier: supplementCellID)
        return collectionView
    }()

    // MARK: - 公有方法

    convenience init(data: [Supplement]) {
        self.init()
        self.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }

    // MARK: - 私有方法
}

extension SupplementViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: supplementCellID, for: indexPath) as! SupplementCell
        cell.updateUI(with: data[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callBack = cellCallBack {
            callBack(data[indexPath.row])
        }
    }
}

extension SupplementViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CFWidth, height: 100.fit)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
}


class SupplementCell: UICollectionViewCell {
    public func updateUI(with data: Supplement) {
        leftImageView.image = UIImage(named: data.image)
        nameLabel.text = data.name

        // star
        var base: CGFloat = 0
        for _ in 0 ..< data.star {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "star")
            imageView.tintColor = .orange
            addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.equalTo(self.nameLabel.snp.bottom).offset(10.fit)
                make.left.equalToSuperview().offset(130.fit + base)
                make.width.equalTo(10.fit)
                make.height.equalTo(10.fit)
            }
            base = base + 18.fit
        }
    }

    private lazy var backView: UIView = {
        let layerView = UIView()
        // shadowCode
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.22).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 6
        // fill
        layerView.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.99, alpha: 1)
        layerView.alpha = 0.35
        layerView.layer.cornerRadius = 4
        return layerView
    }()

    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
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
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 15)!, .foregroundColor: UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backView)
        addSubview(leftImageView)
        addSubview(nameLabel)

        backView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18.fit)
            make.right.equalToSuperview().offset(-18.fit)
            make.top.equalToSuperview().offset(4.fit)
            make.bottom.equalToSuperview().offset(-4.fit)
        }

        leftImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.fit)
            make.width.equalTo(90.fit)
            make.top.equalToSuperview().offset(4.fit)
            make.bottom.equalToSuperview().offset(-4.fit)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.fit)
            make.left.equalToSuperview().offset(130.fit)
            make.width.equalTo(150.fit)
            make.height.equalTo(26.fit)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
