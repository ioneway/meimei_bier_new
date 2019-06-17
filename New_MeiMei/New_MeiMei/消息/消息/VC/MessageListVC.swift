//
//  MessageListVC.swift
//  New_MeiMei
//
//  Created by admin on 2019/6/10.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import ESPullToRefresh

class MessageListVC: NIMSessionListViewController {

    var list: [MessageModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTable()
    }
    
    fileprivate func initTable(){
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear
        self.tableView.register(MessagePersonCell.self, forCellReuseIdentifier: MessagePersonCell.className)
        self.tableView.register(MessageSystemCell.self, forCellReuseIdentifier: MessageSystemCell.className)
        self.tableView.delegate = self
        self.tableView.dataSource = self 
        self.tableView.es.addPullToRefresh {
            self.loadMessageData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.es.startPullToRefresh()
    }
    
    fileprivate func loadMessageData() {
//        MMProvider.request(.Message(.systemMessage(page:1)), completion:  {[weak self] result in
//            switch result{
//            case let .success(response):
//                do {
//                    let repos: MessageResponseModel? = MessageResponseModel(JSON: try response.mapJSON() as! [String : Any])
//                    
//                    if let repos = repos {
//                        if repos.result == 1 {
//                            
//                            self?.list = repos.list
//                            self?.tableView.es.stopPullToRefresh()
//                            self?.refresh()
//                        }
//                    }
//                } catch {
//                    
//                }
//            case let .failure(error):
//                
//                guard let description = error.errorDescription else {
//                    break
//                }
//                print(description)
//            }
//        })
    }
    
    override func refresh() {
        self.tableView.reloadData()
        guard let recentAryy = NIMSDK.shared().conversationManager.allRecentSessions() else{return}
        var number = 0
        for recent in recentAryy{
            number += recent.unreadCount
        }
        UIApplication.shared.applicationIconBadgeNumber = number
    }
}


extension MessageListVC{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = self.recentSessions{
            return self.recentSessions.count + (self.list?.count ?? 0)
        }else{
            return  (self.list?.count ?? 0)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row <  (self.list?.count ?? 0){//系统数据
            if let cell = tableView.dequeueReusableCell(withIdentifier: MessageSystemCell.className, for: indexPath) as? MessageSystemCell {
//                cell.setMessage(self.systemList)
                
                return cell
            }
            
        }else{//用户数据
            if let cell = tableView.dequeueReusableCell(withIdentifier: MessagePersonCell.className, for: indexPath) as? MessagePersonCell {
                let sysCount =  (self.list?.count ?? 0)
                guard let _ = self.recentSessions else{
                    return cell
                }
                
                let recent = self.recentSessions[indexPath.row - sysCount] as! NIMRecentSession
                //               print("090909090",recent,"9009090")
                cell.setData(recent)
//                cell.messageLabel.attributedText = self.content(for: recent)
                return cell
            }
        }
        
        return UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row <  (self.list?.count ?? 0){
//            AppNavHelper.gotoSystemListVC(self.superVC ?? self)
        }else{
            
            let sysCount =  (self.list?.count ?? 0)
            guard let _ = self.recentSessions else{return}
            let recent = self.recentSessions[indexPath.row - sysCount] as! NIMRecentSession
            
//            AppNavHelper.gotoMessageSessionVC(self.superVC ?? self, recent.session ?? NIMSession())
        }
        
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard indexPath.row >=  (self.list?.count ?? 0) else{
            return nil
        }
        
        let action = UITableViewRowAction.init(style: .default, title: "删除") { (action, indexPath) in
            let manager = NIMSDK.shared().conversationManager
            if let recent = self.recentSessions?[indexPath.row -  (self.list?.count ?? 0)] as? NIMRecentSession{
                manager.delete(recent)
            }
            
        }
        return [action]
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard indexPath.row >=  (self.list?.count ?? 0) else{
            return false
        }
        return true
    }
}
