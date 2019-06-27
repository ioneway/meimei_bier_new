//
//  NearByVC.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/25.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import SDCycleScrollView

class NearByVC: BaseViewController {
    
    var list: [NearbyModel]?
    
    lazy var scrollView: SDCycleScrollView? = {
        let temp = SDCycleScrollView.init(frame: CGRect(x: 0.0, y: 0.0, width: kSCREEN_WIDTH, height: 150.0), delegate: self, placeholderImage: ImageAsset.scroll_bg.value)
        temp?.showPageControl = true
        temp?.pageControlBottomOffset = -8
        temp?.currentPageDotImage = ImageAsset.ic_banner_dot_sel.value
        temp?.pageDotImage = ImageAsset.ic_banner_dot.value
        temp?.bannerImageViewContentMode = .scaleToFill
        temp?.autoScroll = true
        temp?.backgroundColor = .white
        return temp
    }()
    
    private lazy var _tableView: UITableView = {
        let temp = UITableView()
        temp.delegate = self
        temp.dataSource = self
        temp.registerClass(NearByCell.self)
        temp.separatorStyle = .singleLine
        temp.tableFooterView = UIView()
        let headerview = scrollView
        temp.tableHeaderView = headerview
        temp.separatorInset = UIEdgeInsets.zero
        temp.rowHeight = 80
        return temp
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadBannerData()
        self.loadNearbyData()
        self.navigationBar?.hide = true
        self.view.addSubview(_tableView)
        _tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.bottom.equalToSuperview().offset(-kBottom_HEIGHT)
        }
    }
    
    func loadBannerData() {
        
        MMProvider.request(.LCVC(.banner), completion:  {[weak self] result in
            switch result{
            case let .success(response):
                do {
                    let repos: BannerResponseModel? = BannerResponseModel(JSON: try response.mapJSON() as! [String : Any])

                    if let repos = repos {
                        if repos.result == 1 {

                          let list =  repos.banners.map{ $0.img_link }
                          self?.scrollView?.imageURLStringsGroup = list

                        }
                    }
                } catch {

                }
            case let .failure(error):

                guard let description = error.errorDescription else {
                    break
                }
                print(description)
            }
        })
    }
    
    func loadNearbyData() {
        
        MMProvider.request(.LCVC(.nearby(page: 1)), completion:  {[weak self] result in
            switch result{
            case let .success(response):
                do {
                    let repos: NearbyResponseModel? = NearbyResponseModel(JSON: try response.mapJSON() as! [String : Any])
                    
                    if let repos = repos {
                        if repos.result == 1 {
                            self?.list = repos.list
                            self?._tableView.reloadData()
                        }
                    }
                } catch {
                    
                }
            case let .failure(error):
                
                guard let description = error.errorDescription else {
                    break
                }
                print(description)
            }
        })
        

    }
}

extension NearByVC: SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
//        let banner = bannerList[index]
//        ScreenUIHelper.bannerNavAction(banner, vc: self.superVC ?? self)
//        PublicAPI.statistics("banner",banner.id)
        //TODO: 进入下一个页面，
    }
}

extension NearByVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NearByCell = tableView.dequeue(indexPath: indexPath)
        let model = list?[indexPath.row]
        cell.model = model
        return cell
    }
}
