//
//  EditPickerView.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/6.
//

import UIKit

class EditPickerView: UIView {
    // MARK: - 公有属性
    public var data = MineModel()
    public var callBack: ((MineModel) -> ())?
    // MARK: - 私有属性

    private var viewType = editType.sex

    private var numArray = [Int](0 ... 300)
    private var sexArray = ["男", "女"]
    private var years = [Int]()
    private var months = [Int](1 ... 12)
    private var days = [Int](1 ... 31)

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
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
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

    public func updateUI(with type: editType, data: MineModel) {
        viewType = type
        self.data = data
        switch viewType {
        case .sex:
            if self.data.sex == "男" {
                pickView.selectRow(0, inComponent: 0, animated: true)
            } else {
                pickView.selectRow(1, inComponent: 0, animated: true)
            }
        case .height:
            pickView.selectRow(Int(self.data.height)!, inComponent: 0, animated: true)
        case .weight:
            pickView.selectRow(Int(self.data.weight)!, inComponent: 0, animated: true)
        case .date:
            let year = Int(self.data.birthday.prefix(4))!
            let month = Int(self.data.birthday.prefix(7).suffix(2))!
            let day = Int(self.data.birthday.suffix(2))!
            pickView.selectRow(year - 1949, inComponent: 0, animated: true)
            pickView.selectRow(month - 1, inComponent: 1, animated: true)
            pickView.selectRow(day - 1, inComponent: 2, animated: true)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        configDate()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 私有方法

    @objc func add() {
        switch viewType {
        case .sex:
            let sex = sexArray[pickView.selectedRow(inComponent: 0)]
            data.sex = sex
        case .height:
            let height = String(numArray[pickView.selectedRow(inComponent: 0)])
            data.height = height
        case .date:
            let year = String(years[pickView.selectedRow(inComponent: 0)])
            var month = String(months[pickView.selectedRow(inComponent: 1)])
            var day = String(days[pickView.selectedRow(inComponent: 2)])
            if months[pickView.selectedRow(inComponent: 1)] < 10 {
                month = "0" + month
            }
            if days[pickView.selectedRow(inComponent: 2)] < 10 {
                day = "0" + day
            }
            let date = year + "-" + month + "-" + day
            data.birthday = date
        case .weight:
            let weight = String(numArray[pickView.selectedRow(inComponent: 0)])
            data.height = weight
        }
        callBack!(data)
        self.removeFromSuperview()
    }
    
    @objc func cancel() {
        self.removeFromSuperview()
    }

    func configDate() {
        let date = Date()
        let year = date.year()
        years = [Int](1949 ... year)
    }

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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch viewType {
        case .date:
            let year = years[pickerView.selectedRow(inComponent: 0)]
            let month = months[pickerView.selectedRow(inComponent: 1)]
            let day = days[pickerView.selectedRow(inComponent: 2)]
            if month == 2 {
                if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0) {
                    if day > 28 {
                        pickerView.selectRow(27, inComponent: 2, animated: true)
                    }
                } else {
                    if day > 29 {
                        pickerView.selectRow(28, inComponent: 2, animated: true)
                    }
                }
            } else {
                if month == 2 || month == 4 || month == 6 || month == 9 {
                    if day > 30 {
                        pickerView.selectRow(29, inComponent: 2, animated: true)
                    }
                }
            }
        default:
            break
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        switch viewType {
        case .sex:
            label.text = sexArray[row]
        case .height:
            label.text = String(numArray[row])
        case .weight:
            label.text = String(numArray[row])
        default:
            switch component {
            case 0:
                label.text = String(years[row])
            case 1:
                label.text = String(months[row])
            default:
                label.text = String(days[row])
            }
        }
        return label
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch viewType {
        case .sex:
            return 1
        case .height:
            return 1
        case .weight:
            return 1
        default:
            return 3
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch viewType {
        case .sex:
            return sexArray.count
        case .weight:
            return numArray.count
        case .height:
            return numArray.count
        default:
            switch component {
            case 0:
                return years.count
            case 1:
                return months.count
            default:
                return days.count
            }
        }
    }
}
