//
//  CollectionHeaderView.swift
//  PengPengApp
//
//  Created by 传销大王 on 2018/12/9.
//  Copyright © 2018 陈政宏. All rights reserved.
//

import UIKit
import SDCycleScrollView


protocol CollectionHeaderViewDelegate: NSObjectProtocol {
    func didSelectBanner(_ index: Int)
}

class CollectionHeaderView: UICollectionReusableView {
    
    weak var delegate: CollectionHeaderViewDelegate?
    fileprivate var carouselView: SDCycleScrollView!
    fileprivate var headerView : UIImageView?
    fileprivate let bg = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initUI(){
        
        carouselView = SDCycleScrollView.init(frame: CGRect.zero, delegate: self, placeholderImage: ImageAsset.scroll_bg.value)
        carouselView.showPageControl = true
        carouselView.pageControlBottomOffset = -8
        carouselView.currentPageDotImage = ImageAsset.ic_banner_dot_sel.value
        carouselView.pageDotImage = ImageAsset.ic_banner_dot.value
        carouselView.bannerImageViewContentMode = .scaleToFill
        carouselView.autoScroll = true
        carouselView.backgroundColor = .clear
        
        self.addSubview(carouselView)
        carouselView.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalToSuperview()
        })
    }
    
   
    var imageURLStringsGroup: [Any]! {
        didSet {
            carouselView.imageURLStringsGroup = imageURLStringsGroup
        }
    }
}

extension CollectionHeaderView: SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        if let delegate = self.delegate {
            delegate.didSelectBanner(index)
        }
    }
}
