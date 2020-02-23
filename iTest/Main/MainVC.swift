//
//  MainVC.swift
//  iTest
//
//  Created by 양성훈 on 2020/02/20.
//  Copyright © 2020 양성훈. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class MainVC: UIViewController {

    let urlString = "https://itunes.apple.com/search?term=%ED%95%B8%EB%93%9C%EB%A9%94%EC%9D%B4%EB%93%9C&country=kr&media=software"

    private struct UI {
        static let basicMargin: CGFloat = 10
    }
    //MARK:- Properties
    lazy var dataList:[iTunesSearchResult] = []
    
    //MARK:- UI Properties
    
    lazy var titleLabelV:UILabel = UILabel().then {
        $0.backgroundColor = UIColor.white
        $0.text = "핸드메이드"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    lazy var tableV: UITableView = UITableView().then {
        $0.backgroundColor = UIColor.lightGray
        $0.refreshControl = UIRefreshControl()
        $0.refreshControl?.tintColor = .gray
        $0.separatorStyle = .none
        $0.delaysContentTouches = true
        $0.canCancelContentTouches = false
        $0.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.CellIdentifier)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        [titleLabelV, tableV].forEach { view.addSubview($0) }

        // titleLabelV
        titleLabelV.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(UI.basicMargin)
            } else {
                $0.top.equalToSuperview().offset(UI.basicMargin * 3)
            }
            $0.left.equalToSuperview().offset(UI.basicMargin)
        }

        // tableV
        tableV.snp.makeConstraints {
            $0.top.equalTo(titleLabelV.snp.bottom).offset(UI.basicMargin)
            $0.leading.trailing.equalToSuperview()
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(UI.basicMargin)
            } else {
                $0.bottom.equalToSuperview().offset(UI.basicMargin)
            }
        }
        
        tableV.delegate = self
        tableV.dataSource = self

        tableV.refreshControl?.addTarget(self, action: #selector(refreshCalled), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    
        weak var ws = self
        NetworkProvider.SI.requestContentsData(urlString) { jsonData in
            if let json = jsonData {
                print("response data = \(String(describing: jsonData))")
                ws!.dataList = json
                ws!.tableV.reloadData()
            }
        }
    }

    @objc func refreshCalled() {
        
        weak var ws = self
        
        tableV.refreshControl?.beginRefreshing()
        
        NetworkProvider.SI.requestContentsData(urlString) { jsonData in
            if let json = jsonData {
                print("response data = \(String(describing: jsonData))")
                ws!.dataList = json
                ws!.tableV.reloadData()
            }
            ws?.tableV.refreshControl?.endRefreshing()
        }
    }

}

extension MainVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
//    // Set the spacing between sections
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }
//
//    // Make the background color show through
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.lightGray
//        return headerView
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.width + 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // to do 화면 이동
        let index = indexPath.row

        let vc = DetailContentVC()
        vc.configure(data:dataList[index])

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let index = indexPath.row
        
        if index >= dataList.count {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.CellIdentifier, for: indexPath) as! MainTableViewCell

        // custom select color
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView

        cell.configure(dataList[index])
        
        return cell
    }
}

