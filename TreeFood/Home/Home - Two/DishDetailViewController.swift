//
//  DishDetailViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/27.
//

import UIKit

class DishDetailViewController: UIViewController {
    
    //MARK: -公有属性
    
    
    //MARK: -私有属性
    
    
    private var data = Dish()
    private var viewScroll = true
    private var foodType = [Species]()
    
    private lazy var scrollView: bottomScrollView = {
        let view = bottomScrollView()
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.delegate = self
        return view
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: CFWidth, height: kNavBarHeight))
        view.addSubview(self.leftBackImageView)
        view.addSubview(self.leftButton)
        view.addSubview(self.rightShareImageView)
        view.addSubview(self.rightButton)
        return view
    }()
    
    private lazy var leftBackImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "back"))
        imageView.frame = CGRect(x: 10.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        return imageView
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 10.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        button.addTarget(self, action: #selector(clickLeftBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: CFWidth - 55.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        button.addTarget(self, action: #selector(clickRightShareButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightShareImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "share"))
        imageView.frame = CGRect(x: CFWidth - 55.fit, y: 7.fit, width: 30.fit, height: 30.fit)
        return imageView
    }()
    
    private lazy var backImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "素食拼盘"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var dishView: DishContentView = {
        let view = DishContentView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        return view
    }()
    
    

    //MARK: -公有方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
        configNavbar()
        configUI()
        self.scrollView.contentSize = CGSize(width: CFWidth, height: CFHeight + 200)
        dishView.scrollBlock = { [weak self] (scroll) in
            self?.viewScroll = scroll
        }
    }
    
    public func updateUI(with data:Dish, types:[Species]) {
        dishView.updateUI(with: data)
        self.data = data
        self.foodType = types
        self.backImageView.image = UIImage(named: data.image)
    }

    //MARK: -私有方法
    
    private func configNavbar() {
        self.navigation.bar.isShadowHidden = true
        self.navigation.bar.alpha = 0
        self.navigation.bar.backBarButtonItem = nil
        // 顶部导航栏
        self.navigation.item.titleView = titleView
        // 状态栏白色
        self.navigation.bar.statusBarStyle = .lightContent
    }
    
    private func configUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        scrollView.addSubview(backImageView)
        scrollView.addSubview(dishView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-91)
            make.left.equalToSuperview()
            make.width.equalTo(CFWidth)
            make.height.equalTo(200)
        }
        
        dishView.snp.makeConstraints { (make) in
            make.top.equalTo(backImageView.snp.bottom).offset(-15)
            make.left.equalToSuperview()
            make.width.equalTo(CFWidth)
            make.height.equalTo(CFHeight)
        }
    }
    
    func addButton(){
        dishView.buttonBlock = {
            print("addbutton")
        }
    }

    @objc func clickLeftBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func clickRightShareButton(){
        
    }
    
}

extension DishDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxOffset: CGFloat = 300
        if !viewScroll {
            scrollView.contentOffset.y = maxOffset
        } else {
            if scrollView.contentOffset.y >= maxOffset {
                scrollView.contentOffset.y = maxOffset
                viewScroll = false
                dishView.tableScroll = true
                
            }
        }
    }
}
