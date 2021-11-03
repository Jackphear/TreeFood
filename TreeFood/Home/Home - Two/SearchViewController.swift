//
//  SearchViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: -公有属性
    public var cellCallBack: ((Dish, Species) -> ())?
    public var data = [Dish]()
    public var out = true
    
    //MARK: -私有属性
    
    private var resultData = [Dish]()
    private let cellID = "cell"
    
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.delegate = self
        controller.searchBar.delegate = self
        return controller
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: -公有方法
    
    public func updateUI(with data: [Dish]) {
        self.data = data
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    //用于键盘主动弹起
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }
    
    //MARK: -私有方法
    func configUI() {
        self.tableView.tableHeaderView = searchController.searchBar
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.top.left.right.equalToSuperview()
        }
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true;
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true;
    }
}

extension SearchViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let inputStr = searchController.searchBar.text
        if resultData.count > 0 {
            resultData.removeAll()
        }
        for item in data {
            if((item.name.lowercased() as NSString).range(of: inputStr?.lowercased() ?? "").location != NSNotFound) {
                resultData.append(item)
            }
        }
        self.tableView.reloadData()
    }

    func didPresentSearchController(_ searchController: UISearchController) {
        
        if out {
            searchController.searchBar.becomeFirstResponder()
            self.out = false
        }
        
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        if out {
            cell.textLabel?.text = self.data[indexPath.row].name
        } else {
            if self.searchController.isActive {
                cell.textLabel?.text = self.resultData[indexPath.row].name
            } else {
                cell.textLabel?.text = self.data[indexPath.row].name
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive {
            return resultData.count
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true) {
            if self.searchController.isActive {
                self.cellCallBack!(self.resultData[indexPath.row], getType(name: self.resultData[indexPath.row].name))
            } else {
                self.cellCallBack!(self.data[indexPath.row], getType(name: self.data[indexPath.row].name))
            }
        }
        
    }
}



