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

    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collect = UICollectionView(frame: CGRect(x: -10, y: 0, width: CFWidth, height: 300.fit), collectionViewLayout: layout)
        collect.backgroundColor = .clear
        collect.dataSource = self
        collect.delegate = self
        collect.register(SupplementCell.self, forCellWithReuseIdentifier: supplementCellID)
        return collect
    }()

    // MARK: - 公有方法

    convenience init(data: [Supplement]) {
        self.init()
        self.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collection)
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
