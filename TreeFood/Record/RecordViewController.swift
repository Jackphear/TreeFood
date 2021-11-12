//
//  RecordViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//

import HandyJSON
import SwiftyJSON
import UIKit

class RecordViewController: UIViewController {
    // MARK: - 私有属性

    fileprivate let topCellID = "topCell"
    fileprivate let intakeCellID = "intakeCell"
    fileprivate let waterCellID = "waterCell"
    fileprivate let headCellID = "headCell"

    private var imageString:String? = nil
    private let cellType = [Species.Breakfast, .Launch, .Dinner, .Snacks]
    private var index = -1
    private var recorderData = RecoderDataClass()
    private var datas = Today()

    private lazy var titleView: RecordTitleView = {
        let view = RecordTitleView(frame: CGRect(x: 0, y: 0, width: CFWidth, height: kNavBarHeight))
        view.clickAddButtonBlock = {
             let calendarVC = CalendarViewController()
             self.navigationController?.pushViewController(calendarVC, animated: true)
        }
        view.clickCalendarButtonBlock = {
        }
        view.clickRightArrowButtonBlock = {
            guard self.index > -1 else {
                return
            }
            view.showLeftButton()
            self.index -= 1
            guard self.index != -1 else {
                self.updateUI(with: self.recorderData.today)
                view.hiddenRightButton()
                return
            }
            self.updateUI(with: self.recorderData.old_datas[self.index])
        }
        view.clickLeftArrowButtonBlock = {
            guard self.index < self.recorderData.old_datas.count - 1 else {
                return
            }
            view.showRightButton()
            self.index += 1
            self.updateUI(with: self.recorderData.old_datas[self.index])
            if self.index == self.recorderData.old_datas.count - 1 {
                view.hiddenLeftButton()
            }
        }
        view.hiddenRightButton()
        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(TopInfoCollectionViewCell.self, forCellWithReuseIdentifier: topCellID)
        collectionView.register(IntakeCollectionViewCell.self, forCellWithReuseIdentifier: intakeCellID)
        collectionView.register(WaterIntakeCollectionViewCell.self, forCellWithReuseIdentifier: waterCellID)
        collectionView.register(RecodeCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headCellID)

        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        
    }

    // MARK: - 私有方法

    private func updateUI(with data: Today) {
        datas = data
        titleView.updateTilte(with: datas.time)
        collectionView.reloadData()
    }

    private func configUI() {
        navigation.item.titleView = titleView
        navigation.bar.isShadowHidden = true
        navigation.bar.alpha = 1

        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.equalToSuperview()
            make.top.equalTo(self.navigation.bar.snp.bottom).offset(0.fit)
        }
    }

    private func configData() {
        // 1 获取json文件路径
        let path = Bundle.main.path(forResource: "record", ofType: "json")
        // 2 获取json文件里面的内容,NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        // 3 解析json内容
        let json = JSON(jsonData!)

        recorderData = JSONDeserializer<RecoderDataClass>.deserializeFrom(json: json["data"].description)!
        updateUI(with: recorderData.today)
    }
}

extension RecordViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return 1
        default:
            return 0
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCellID, for: indexPath) as! TopInfoCollectionViewCell
            cell.updateUI(weight: Int(datas.body.weight), calories: Int(datas.body.attract), percent: Int(datas.body.rest))
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: intakeCellID, for: indexPath) as! IntakeCollectionViewCell
            cell.initWithType(with: cellType[indexPath.row])
            cell.updateUI(with: imageString)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: waterCellID, for: indexPath) as! WaterIntakeCollectionViewCell
            cell.updateUI(target: CGFloat(datas.water_attract.target), accomplish: CGFloat(datas.water_attract.attracted))
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: CFWidth, height: 190.fit)
        case 1:
            return CGSize(width: 194.fit, height: 140.fit)
        case 2:
            return CGSize(width: CFWidth, height: 150.fit)
        case 3:
            return CGSize(width: CFWidth, height: 280.fit)
        case 4:
            return CGSize(width: CFWidth, height: 250.fit)
        default:
            return CGSize(width: CFWidth, height: 0)
        }
    }

    // 头部
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headCellID, for: indexPath) as? RecodeCollectionReusableView else {
            return UICollectionReusableView()
        }
        if indexPath.section == 1 {
            headerView.titleLabel.text = "今日摄入"
        } else if indexPath.section == 2 {
            headerView.titleLabel.text = "水分摄入"
        }
        headerView.backgroundColor = .clear
        return headerView
    }

    // 头部高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: CFWidth, height: 0)
        } else if section == 1 {
            return CGSize(width: CFWidth, height: 25.fit)
        } else if section == 2 {
            return CGSize(width: CFWidth, height: 25.fit)
        }
        return CGSize(width: CFWidth, height: 10.fit)
    }

    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets(top: 10.fit, left: 0.fit, bottom: 10.fit, right: 0.fit)
        case 1:
            return UIEdgeInsets(top: 10.fit, left: 20.fit, bottom: 10.fit, right: 0)
        case 2:
            return UIEdgeInsets(top: 10.fit, left: 0.fit, bottom: 10.fit, right: 0.fit)
        default:
            return UIEdgeInsets(top: 10.fit, left: 0.fit, bottom: 10.fit, right: 0.fit)
        }
    }

    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return 0.fit
        }
        return 10.fit
    }

    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.fit
    }
}
