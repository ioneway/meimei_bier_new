//
//  RecomendVC.swift
//  New_MeiMei
//
//  Created by admin on 2019/6/10.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import ESPullToRefresh

class RecomendVC: BaseViewController {
    
    var list: [RecomendModel]? = nil
    var imgUrlGroup: [Any]?
    var page: Int = 1
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //设置每一个cell的宽高
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 5, right: 12)
        layout.itemSize = CGSize(width: floor((kSCREEN_WIDTH) / 2 - 18), height: floor((kSCREEN_WIDTH) / 2 - 30))
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(RecomendCell.self, forCellWithReuseIdentifier: RecomendCell.className)
        view.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.className)
        view.es.addPullToRefresh {
            [weak self] in
            self?.page = 1
            self?.loadRecomendData()
        }
        view.es.addInfiniteScrolling {
            [weak self] in
            self?.page = (self?.page ?? 0) + 1
            self?.loadRecomendData()
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar?.hide = true
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.right.bottom.equalToSuperview()
        }
        
        loadBannerData()
        self.collectionView.es.startPullToRefresh()
    }
    
    func loadBannerData() {
        
//        MMProvider.request(.LCVC(.banner), completion:  {[weak self] result in
//            switch result{
//            case let .success(response):
//                do {
//                    let repos: BannerResponseModel? = BannerResponseModel(JSON: try response.mapJSON() as! [String : Any])
//                    
//                    if let repos = repos {
//                        if repos.result == 1 {
//                            
//                            let list =  repos.banners.map{ $0.img_link }
//                            self?.imgUrlGroup? = list
//                            
//                            self?.collectionView.reloadData()
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
    
    func loadRecomendData() {
//        MMProvider.request(.LCVC(.recommend(page: self.page)), completion:  {[weak self] result in
//            switch result{
//            case let .success(response):
//                do {
//                    let repos: RecomendResponseModel? = RecomendResponseModel(JSON: try response.mapJSON() as! [String : Any])
//                    
//                    if let repos = repos {
//                        if repos.result == 1 {
//                            if self?.page == 1 {
//                                self?.list = repos.list
//                                self?.collectionView.es.stopPullToRefresh()
//                            }else {
//                                if (self?.list?.count ?? 0) >= repos.totalCount { //数据已经完了
//                                    self?.collectionView.es.noticeNoMoreData()
//                                }else {
//                                    self?.list?.append(contentsOf: repos.list)
//                                    self?.collectionView.es.stopLoadingMore()
//                                }
//                            }
//                            self?.collectionView.reloadData()
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
}


extension RecomendVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: RecomendCell.className, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? RecomendCell else { return }
        cell.recomendModel = self.list?[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = list?[indexPath.row]
        
//        AppNavHelper.gotoBitchPersonVC(self.superVC ?? self, accid: data.id ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.className, for: indexPath) as? CollectionHeaderView {
                header.imageURLStringsGroup = self.list
                header.backgroundColor = .clear
                header.delegate = self
                return header
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kSCREEN_WIDTH, height: 150)
    }
    
}

extension RecomendVC: CollectionHeaderViewDelegate {
   
    
    func didSelectBanner(_ index: Int) {
//        let banner = bannerList[index]
//        ScreenUIHelper.bannerNavAction(banner, vc: self.superVC ?? self)
//        PublicAPI.statistics("banner",banner.id)
    }
}
