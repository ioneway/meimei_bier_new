//
//  LCVC.swift
//  MeiMeiNew
//
//  Created by 王伟 on 2019/5/26.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class MessageVC: BaseViewController {

    fileprivate lazy var segmentView: ZCSegmented = {
       let temp = ZCSegmented(frame: .zero, firstTitle: "消息", secondTitle: "通话", firstClick: {[weak self] in
            self?.pageContentView.setCurrentIndex(currentIndex: 0)
        }, secondClick: {[weak self] in
             self?.pageContentView.setCurrentIndex(currentIndex: 1)
        })
        return temp
    }()
    
    fileprivate lazy var pageContentView: PageContentView = { [weak self] in
        
        let contentViewFrame = CGRect(x: 0, y:kNavi_HEIGHT, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - Ktitle_Width);
        
        var childVcs = [UIViewController]();
        
        let childVC = MessageListVC();
        childVcs.append(childVC);
        
        let childVC2 = RecomendVC();
        childVcs.append(childVC2)
    
        let pageContent = PageContentView(frame: contentViewFrame, childVcs: childVcs, parentVc: self)
        pageContent.delegate = self
        return pageContent
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar?.leftImg = UIImage()
        let navbar = self.navigationBar as! NavigationBar
        
        navbar.addSubview(segmentView)
        segmentView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(158)
            make.height.equalTo(32)
        }
        view.addSubview(pageContentView)
    }
}


extension MessageVC : PageContentViewDelegate {
    func pageContentView(pageContenView: PageContentView, progress: CGFloat, beforeIdnex: Int, targetIndex: Int) {

        segmentView.selectIdx = targetIndex + 1
    }
    
    
}
