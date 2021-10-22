//
//  HomeViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//

import UIKit
import SnapKit

import HandyJSON
import SwiftyJSON

class HomeViewController: UIViewController {
    // MARK: - 私有属性

    fileprivate let SearchCellID = "SearchCollectionViewCell"
    fileprivate let RecommendCellID = "RecommendCollectionViewCell"
    fileprivate let SupplementCellID = "SupplementCollectionViewCell"
    fileprivate let SuggesttCellID = "SuggestCollectionViewCell"
    fileprivate let PreferenceCellID = "PreferenceCollectionViewCell"
    fileprivate let SectionHeadCellID = "SectionHeadCell"
    
    private var homeData = HomeData()
    private var recommendData = [Dish]()
    private var supplements = [Supplement]()


    // MARK: - 界面初始化

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setUpUI()

        setUpData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    //MARK: -私有方法
    func setUpUI(){
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalToSuperview()
            make.top.equalTo(self.navigation.bar.snp.top).offset(0.fit)
        }
    }
    
    func setUpData(){
        //文件路径
        let path = Bundle.main.path(forResource: "homeList", ofType: "json")
        //json转NSData
        let jsonData = NSData(contentsOfFile: path!)
        //解析json
        let json = JSON(jsonData!)
        homeData = JSONDeserializer<HomeData>.deserializeFrom(json: json["data"].description)!
        
        //营养补充
        for item in self.homeData.nutritionalSupplement {
            for supplement in item.supplements {
                self.supplements.append(supplement)
            }
        }
        
        //每日推荐根据时间推荐
        for item in self.homeData.dishes {
            let date = Date()
            let nowHour = date.hour()
            if nowHour > 5 && nowHour < 10 {
                if item.speciesName == "早餐" {
                    for dish in item.content {
                        self.recommendData.append(dish)
                    }
                }
            }else if nowHour >= 10 && nowHour < 17 {
                if item.speciesName == "午餐" {
                    for dish in item.content {
                        self.recommendData.append(dish)
                    }
                }
            }else {
                if item.speciesName == "晚餐" {
                    for dish in item.content {
                        self.recommendData.append(dish)
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

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCellID, for: indexPath) as! SearchCollectionViewCell
            cell.backgroundColor = .black
            cellAnimation(cell: cell, interval: 1)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCellID, for: indexPath) as! RecommendCollectionViewCell
            cell.backgroundColor = .black
            cellAnimation(cell: cell, interval: 1)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupplementCellID, for: indexPath) as! SupplementCollectionViewCell
            cell.backgroundColor = .black
            cellAnimation(cell: cell, interval: 1)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggesttCellID, for: indexPath) as! SuggestCollectionViewCell
            cell.backgroundColor = .black
            cellAnimation(cell: cell, interval: 1)
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreferenceCellID, for: indexPath) as! PreferenceCollectionViewCell
            cell.backgroundColor = .black
            cellAnimation(cell: cell, interval: 1)
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

//MARK: - 动画
extension HomeViewController{
    func cellAnimation(cell: UICollectionViewCell, interval: TimeInterval){
        UIView.animate(withDuration: 0.0) {
            cell.transform = CGAffineTransform(translationX: CFWidth, y: 0.0)
        }
        delay(by: interval) {
            UIView.animate(withDuration: interval + 0.1) {
                cell.transform = CGAffineTransform.identity
            }
        }
    }
    
    func delay(by delay: TimeInterval, code block: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(delay * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC),
            execute: block)
    }
    
    
}
