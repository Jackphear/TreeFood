//
//  EditPickerView.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/6.
//

import UIKit

class EditPickerView: UIView {
    // MARK: - 私有属性

    private var numArray = [Int](0 ... 300)
    private var sexArray = ["男", "女"]
    private var years: [String]
    private var months: [String]
    private var days: [String]

    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("确定", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    lazy var pickView: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - 公有方法

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 私有方法

    func configUI() {
        alpha = 0.7
        backgroundColor = .lightGray
        addSubview(backgroundView)
        backgroundView.addSubview(borderView)
        borderView.addSubview(confirmButton)
        borderView.addSubview(cancelButton)
        backgroundView.addSubview(pickView)
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(650)
            make.bottom.right.left.equalToSuperview()
        }

        borderView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }

        pickView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(borderView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }

        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(70)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }

        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(70)
            make.right.equalTo(borderView.snp.right).offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}

extension EditPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
