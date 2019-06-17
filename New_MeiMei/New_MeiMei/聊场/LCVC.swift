//
//  LCVC.swift
//  MeiMeiNew
//
//  Created by 王伟 on 2019/5/26.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

let Ktitle_Width: CGFloat =  40.0

class LCVC: BaseViewController {

    let titleList = ["附近", "推荐", "活跃", "周榜"]
    
    //懒加载 view
    fileprivate lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 75.0, y:kNavi_HEIGHT - 44.0 , width: kScreenW - 150.0, height: Ktitle_Width);
        
        let titleView = PageTitleView(frame: titleFrame, titles: titleList);
        titleView.delegate = self;
        return titleView;
    }()
    
    fileprivate lazy var pageContentView: PageContentView = { [weak self] in
        
        let contentViewFrame = CGRect(x: 0, y:kNavi_HEIGHT, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - Ktitle_Width);
        
        var childVcs = [UIViewController]();
        
        
        let childVC = NearByVC();
        childVcs.append(childVC);
        
        let childVC2 = RecomendVC();
        childVcs.append(childVC2)
        
        let childVC3 = RecomendVC();
        childVcs.append(childVC3)
        
        let childVC4 = RecomendVC();
        childVcs.append(childVC4)
        
        
        let pageContent = PageContentView(frame: contentViewFrame, childVcs: childVcs, parentVc: self)
        pageContent.delegate = self
        return pageContent
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar?.leftImg = UIImage()
        let navbar = self.navigationBar as! NavigationBar
        navbar.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
}

extension LCVC : PageTitleViewDelegate {
    
    func pageTitleView(pageTitleView: PageTitleView, tapIndex: Int) {
        pageContentView.setCurrentIndex(currentIndex: tapIndex)
    }
    
}

extension LCVC : PageContentViewDelegate {
    
    func pageContentView(pageContenView: PageContentView, progress: CGFloat, beforeIdnex: Int, targetIndex: Int) {
        pageTitleView.setTitleChangeWithProgress(progress: progress, beforeTitleIndex: beforeIdnex, targetTitleIndex: targetIndex)
    }
    
}
