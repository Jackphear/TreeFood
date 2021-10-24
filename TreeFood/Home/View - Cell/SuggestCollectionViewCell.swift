//
//  SuggestCollectionViewCell.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/20.
//

import UIKit

class SuggestCollectionViewCell: HomeBaseCollectionViewCell {
    // MARK: - 公有属性

    var cellCallBack: ((Supplement) -> Void)?

    // MARK: - 私有属性

    var data = SuggestSupplement()
    private let suggestCellID = "suggestCell"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let colletcionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletcionView.isScrollEnabled = false
        colletcionView.backgroundColor = .clear
        colletcionView.dataSource = self
        colletcionView.delegate = self
        colletcionView.register(SupplementCell.self, forCellWithReuseIdentifier: suggestCellID)
        colletcionView.showsVerticalScrollIndicator = false
        return colletcionView
    }()

    // MARK: - 公有方法

    public func updateUI(with data: SuggestSupplement) {
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
        titleLabel.text = "建议补充"

        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(CellTopOffset)
            make.bottom.equalToSuperview().offset(-5.fit)
        }
    }
}

extension SuggestCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: suggestCellID, for: indexPath) as! SupplementCell
        cell.updateUI(with: data.supplements[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callBack = cellCallBack {
            callBack(data.supplements[indexPath.row])
        }
    }
}

extension SuggestCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CFWidth, height: 100.fit)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.fit
    }
}
