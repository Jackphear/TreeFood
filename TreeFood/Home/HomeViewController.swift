//
//  HomeViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//

import SnapKit
import UIKit

import HandyJSON
import SwiftyJSON

//today is my birthday ,just for fun, fighting

class HomeViewController: UIViewController {
    
    var homeData = HomeData()
    // MARK: - 私有属性

    fileprivate let SearchCellID = "SearchCollectionViewCell"
    fileprivate let RecommendCellID = "RecommendCollectionViewCell"
    fileprivate let SupplementCellID = "SupplementCollectionViewCell"
    fileprivate let SuggesttCellID = "SuggestCollectionViewCell"
    fileprivate let PreferenceCellID = "PreferenceCollectionViewCell"
    fileprivate let SectionHeadCellID = "SectionHeadCell"

    
    private var searchData = [Dish]()
    private var recommendData = [Dish]()
    private var supplements = [Supplement]()
    private var FoodType = [Species]()

    // MARK: - 界面初始化

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        view.backgroundColor = .black
        setUpUI()
        setNaviBar()
        configCenterButton()
        setUpData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fanMenu.updateNode()
    }

    // MARK: - 控件

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collcetionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collcetionView.backgroundColor = .white
        collcetionView.showsVerticalScrollIndicator = false

        collcetionView.delegate = self
        collcetionView.dataSource = self

        collcetionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCellID)
        collcetionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCellID)
        collcetionView.register(SupplementCollectionViewCell.self, forCellWithReuseIdentifier: SupplementCellID)
        collcetionView.register(SuggestCollectionViewCell.self, forCellWithReuseIdentifier: SuggesttCellID)
        collcetionView.register(PreferenceCollectionViewCell.self, forCellWithReuseIdentifier: PreferenceCellID)
        collcetionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeadCellID)
        return collcetionView
    }()
    
    private var fanMenu = AddMenu.getsharedInstance().fanMenu
    
    lazy var addView: AddView = {
        let view = AddView()
        return view
    }()

    // MARK: - 私有方法

    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalToSuperview()
            make.top.equalTo(self.navigation.bar.snp.top).offset(0.fit)
        }
    }
    
    private func configCenterButton() {
        self.tabBarController?.tabBar.addSubview(addView)
        // 设置按钮的位置
        let rect = self.tabBarController?.tabBar.frame
        let value = rect!.width / CGFloat(5)
        addView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(1.5 * value)
            make.height.equalTo(value)
        }
        addView.addSubview(fanMenu)
        fanMenu.snp.makeConstraints { (make) in
            make.centerX.equalTo(addView.snp.centerX)
            make.centerY.equalTo(addView.snp.top).offset(0.fit)
            make.height.equalTo(value*5)
            make.width.equalTo(CFWidth)
        }
        fanMenu.onItemDidClick = {button in
            switch button.id {
            case "早餐":
                print("11")
            case "午餐":
                print("11")
            case "晚餐":
                print("11")
            case "小食":
                print("11")
            default:
                break
            }
        }
    }

    private func setNaviBar() {
        navigation.bar.isHidden = true
        navigation.bar.isShadowHidden = true
        navigation.bar.alpha = 0
        navigation.bar.statusBarStyle = .darkContent
    }

    private func setUpData() {
        // 文件路径
        let path = Bundle.main.path(forResource: "homeList", ofType: "json")
        // json转NSData
        let jsonData = NSData(contentsOfFile: path!)
        // 解析json
        let json = JSON(jsonData!)
        homeData = JSONDeserializer<HomeData>.deserializeFrom(json: json["data"].description)!
        
        //搜索数据
        for item in homeData.dishes {
            for dish in item.content {
                self.searchData.append(dish)
            }
        }

        // 营养补充
        for item in homeData.nutritionalSupplement {
            for supplement in item.supplements {
                supplements.append(supplement)
            }
        }

        // 每日推荐根据时间推荐
        for item in homeData.dishes {
            let date = Date()
            let type = date.getSpecie()
            switch type {
            case .Breakfast:
                if item.speciesName == type.rawValue {
                    for dish in item.content {
                        recommendData.append(dish)
                        FoodType.append(type)
                    }
                }
            case .Launch:
                if item.speciesName == type.rawValue {
                    for dish in item.content {
                        recommendData.append(dish)
                        FoodType.append(type)
                    }
                }
            case .Dinner:
                if item.speciesName == type.rawValue {
                    for dish in item.content {
                        recommendData.append(dish)
                        FoodType.append(type)
                    }
                }
            case .Snacks:
                if item.speciesName == type.rawValue {
                    for dish in item.content {
                        recommendData.append(dish)
                        FoodType.append(type)
                    }
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCellID, for: indexPath) as! SearchCollectionViewCell
            cellAnimation(cell: cell, interval: 0.25)
            cell.searchCallBack = { ()
                let vc = SearchViewController()
                vc.searchController.isActive = true
                vc.updateUI(with: self.searchData)
                self.navigationController?.pushViewController(vc, animated: true)
                vc.cellCallBack = { data, type in
                    let vc = DishDetailViewController()
                    vc.updateUI(with: data, types: type)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            cell.cellCallBack = { type in
                switch type {
                case .Breakfast:
                    let vc = DishViewController()
                    vc.updateUI(with: self.homeData.dishes[0], type: type)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .Launch:
                    let vc = DishViewController()
                    vc.updateUI(with: self.homeData.dishes[1], type: type)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .Dinner:
                    let vc = DishViewController()
                    vc.updateUI(with: self.homeData.dishes[2], type: type)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .Snacks:
                    let vc = DishViewController()
                    vc.updateUI(with: self.homeData.dishes[3], type: type)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            cell.updateUI(with: homeData.dishes)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCellID, for: indexPath) as! RecommendCollectionViewCell
            cellAnimation(cell: cell, interval: 0.25)
            cell.moreButtonBlock = { ()
                let vc = MoreDishViewController()
                vc.updateUI(with: self.recommendData, title: "每日推荐")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.cellCallBack = { data, type in
                let vc = DishDetailViewController()
                vc.updateUI(with: data, types: type)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.updateUI(with: recommendData, FoodType: FoodType)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupplementCellID, for: indexPath) as! SupplementCollectionViewCell
            cellAnimation(cell: cell, interval: 0.25)
            cell.moreButtonBlock = {
                let vc = MoreSupplementViewController()
                vc.updatUI(with: self.supplements, title: "营养补给")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.cellCallBack = { (data) in
                let vc = SupplementDetailViewController()
                vc.updateUI(with: data)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.updateUI(with: homeData.nutritionalSupplement)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggesttCellID, for: indexPath) as! SuggestCollectionViewCell
            cellAnimation(cell: cell, interval: 0.25)
            cell.moreButtonBlock = {
                let vc = MoreSupplementViewController()
                vc.updatUI(with: self.supplements, title: "建议补充")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.cellCallBack = { data in
                let vc = SupplementDetailViewController()
                vc.updateUI(with: data)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.updateUI(with: homeData.suggestSupplement)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceCellID, for: indexPath) as! PreferenceCollectionViewCell
            cellAnimation(cell: cell, interval: 0.25)
            cell.moreButtonBlock = {
                let vc = MoreDishViewController()
                vc.updateUI(with: self.recommendData, title: "最近偏爱")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            cell.cellCallBack = { (data, type) in
                switch type {
                case .Breakfast:
                    let vc = DishDetailViewController()
                    vc.updateUI(with: data, types: type)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .Launch:
                    let vc = DishDetailViewController()
                    vc.updateUI(with: data, types: type)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .Dinner:
                    let vc = DishDetailViewController()
                    vc.updateUI(with: data, types: type)
                    self.navigationController?.pushViewController(vc, animated: true)
                case .Snacks:
                    let vc = DishDetailViewController()
                    vc.updateUI(with: data, types: type)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            cell.updateUI(with: recommendData, FoodType: FoodType)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceCellID, for: indexPath) as! PreferenceCollectionViewCell
            cell.backgroundColor = .black
            cellAnimation(cell: cell, interval: 1)
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: CFWidth, height: 175.fit)
        case 1:
            return CGSize(width: CFWidth, height: 300.fit)
        case 2:
            return CGSize(width: CFWidth, height: 310.fit)
        case 3:
            return CGSize(width: CFWidth, height: 275.fit)
        case 4:
            return CGSize(width: CFWidth, height: 230.fit)
        default:
            return CGSize(width: CFWidth, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeadView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeadCellID, for: indexPath)
        sectionHeadView.backgroundColor = UIColor(red: 0.99, green: 0.98, blue: 0.98, alpha: 1)
        return sectionHeadView
    }

    // section头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: CFWidth, height: 0)
        }
        return CGSize(width: CFWidth, height: 15.fit)
    }

    // section内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.fit, left: 0, bottom: 15.fit, right: 0)
    }

    // section间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.fit
    }
}

// MARK: - 动画

extension HomeViewController {
    func cellAnimation(cell: UICollectionViewCell, interval: TimeInterval) {
        UIView.animate(withDuration: 0.0) {
            cell.transform = CGAffineTransform(translationX: CFWidth, y: 0.0)
        }
        delay(by: interval) {
            UIView.animate(withDuration: interval + 0.1) {
                cell.transform = CGAffineTransform.identity
            }
        }
    }

    func delay(by delay: TimeInterval, code block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(delay * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC),
            execute: block)
    }
}
