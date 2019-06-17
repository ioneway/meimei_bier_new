//
//  HDTabBarVC.swift
//  HDJ
//
//  Created by 王伟 on 2019/4/11.
//  Copyright © 2019 王伟. All rights reserved.
//

import UIKit

class HDTabBarVC: UITabBarController {

    private var _firtNV: UINavigationController?
    private var _secondNV: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
/*
        _firtNV = generateNav(rootVC: HomeVC(), selectedImage:  R.image.tab_1_selected() ?? UIImage() , normalImage:  R.image.tab_1_selected() ?? UIImage())
        
        _secondNV = generateNav(rootVC: ViewController(),  selectedImage: R.image.tab_2() ?? UIImage(), normalImage:  R.image.tab_2() ?? UIImage())
        
        self.viewControllers = [_firtNV, _secondNV] as? [UIViewController]
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().tintColor = R.color.cfd6761()

        let tabbar = HDTabBar()
        self.setValue(tabbar, forKey: "tabBar")
        
        tabbar.centerBtn.addTarget(self, action: #selector(centerBtnClick), for: .touchUpInside)
 */
    }
    
    @objc func centerBtnClick(){
        /*
        let nav = UINavigationController(rootViewController: RegistVC())
        nav.navigationBar.isHidden = true
        self.present(nav , animated: true, completion: nil)
 */
    }
    private func generateNav(rootVC: UIViewController,
                             selectedImage: UIImage,
                             normalImage: UIImage) -> UINavigationController
    {
        let nav = UINavigationController(rootViewController: rootVC)
        let item = UITabBarItem()
        rootVC.title = "看看"
        item.image = normalImage
        item.selectedImage = selectedImage
        item.title = "首页"
        item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -7)
        nav.tabBarItem = item
        nav.navigationBar.isHidden = true
        
        return nav
    }

}
