//
//  ArchiveFirstViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/9.
//

import UIKit

class AnalyzeFirstViewController: UIViewController {

    // MARK: -私有属性

    private let AnalyzeFirstCellID = "AnalyzeFirstCellID"

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AnalyzeFirstCell.self, forCellReuseIdentifier: AnalyzeFirstCellID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.rowHeight = 300.fit
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: -公有方法

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    // MARK: -私有方法

    private func configUI() {
        navigation.bar.isShadowHidden = true
        navigation.bar.alpha = 0

        view.backgroundColor = UIColor(r: 254, g: 254, b: 254)
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30.fit)
            make.left.bottom.right.equalToSuperview()
        }
    }
}

extension AnalyzeFirstViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnalyzeFirstCellID, for: indexPath) as! AnalyzeFirstCell
        if indexPath.row == 1 {
            cell.backImageView.image = UIImage(named: "Weight")
        } else {
            cell.backImageView.image = UIImage(named: "BMI")
        }
        return cell
    }
}

class AnalyzeFirstCell: UITableViewCell {
    public lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BMI")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var backView: UIView = {
        let layerView = UIView()
        layerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.16).cgColor
        layerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        layerView.layer.shadowOpacity = 1
        layerView.layer.shadowRadius = 6
        // fill
        layerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        layerView.layer.cornerRadius = 20
        return layerView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .white
        selectionStyle = .none
        addSubview(backView)
        backView.backgroundColor = .white
        backView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.fit)
            make.top.equalToSuperview().offset(20.fit)
            make.right.equalToSuperview().offset(-24.fit)
            make.bottom.equalToSuperview()
        }

        backView.addSubview(backImageView)

        backImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(4.fit)
            make.bottom.right.equalToSuperview().offset(-4.fit)
        }
    }
}
