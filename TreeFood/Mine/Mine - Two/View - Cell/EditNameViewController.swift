//
//  EditNameViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/11/8.
//

import UIKit
import Macaw

class EditNameViewController: UIViewController {
    // MARK: - 公有属性

    public var callBack: ((String) -> Void)?

    // MARK: - 私有属性

    private var data = MineModel()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "   请设置2-24个字符")
        label.numberOfLines = 0
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 16)!, .foregroundColor: UIColor(red: 0.6, green: 0.56, blue: 0.56, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        label.alpha = 1
        return label
    }()

    lazy var textField: UITextField = {
        let textfield = UITextField()
        var information: String = data.userName
        let attrString = NSMutableAttributedString(string: information)
        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFang SC", size: 17)!, .foregroundColor: UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        textfield.attributedText = attrString
        textfield.backgroundColor = UIColor.white
        textfield.alpha = 1
        textfield.keyboardType = .default
        return textfield
    }()

    // MARK: - 公有方法

    public func updateUI(with data: MineModel) {
        self.data = data
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavBar()
        hideKeyboard()
    }

    // MARK: - 私有方法
    
    func configNavBar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 1
        self.navigation.item.title = "修改名字"
        self.navigation.item.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(confirmButton))
        self.navigation.item.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(cancel))
    }

    func configUI() {
        self.view.backgroundColor = UIColor.init(r: 247, g: 247, b: 247)
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.width.equalTo(CFWidth)
            make.height.equalTo(62.fit)
            make.top.equalToSuperview().offset(146.fit)
            make.left.equalToSuperview().offset(0)
        }

        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(200.fit)
            make.height.equalTo(22.fit)
            make.top.equalToSuperview().offset(105.fit)
            make.left.equalToSuperview().offset(0.fit)
        }
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func confirmButton() {
        callBack!(textField.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
