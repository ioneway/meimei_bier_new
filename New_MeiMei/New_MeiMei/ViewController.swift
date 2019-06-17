//
//  ViewController.swift
//  New_MeiMei
//
//  Created by admin on 2019/6/5.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    private var _firtNV: UINavigationController?
    private var _secondNV: UINavigationController?
    private var _thirdNV: UINavigationController?
    private var _forthNV: UINavigationController?
    private var _fiveVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _firtNV = generateNav(rootVC: LCVC(), selectedImage:  ImageAsset.ic_tab_talkPlace.value ?? UIImage() , normalImage:  ImageAsset.ic_tab_talkPlace.value ?? UIImage() )
        
        _secondNV = generateNav(rootVC: MessageVC(),  selectedImage: ImageAsset.ic_tab_message.value ?? UIImage(), normalImage:  ImageAsset.ic_tab_message.value ?? UIImage())
        
        _thirdNV = generateNav(rootVC: LCVC(),  selectedImage: ImageAsset.ic_tab_message.value ?? UIImage(), normalImage:  ImageAsset.ic_tab_message.value ?? UIImage())
        
        _forthNV = generateNav(rootVC: LCVC(),  selectedImage: ImageAsset.ic_tab_qiuliao.value ?? UIImage(), normalImage:  ImageAsset.ic_tab_qiuliao.value ?? UIImage())
        
        _fiveVC = generateNav(rootVC: LCVC(),  selectedImage: ImageAsset.ic_tab_mine.value ?? UIImage(), normalImage:  ImageAsset.ic_tab_mine.value ?? UIImage())
        
        self.viewControllers = [_firtNV, _secondNV, _thirdNV, _forthNV, _fiveVC] as? [UIViewController]
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().tintColor = ColorAsset.cfed103.value
        
    }
    
   
    private func generateNav(rootVC: UIViewController,
                             selectedImage: UIImage,
                             normalImage: UIImage) -> NavigationController
    {
        let nav = NavigationController(rootViewController: rootVC)
        let item = UITabBarItem()
        rootVC.title = ""
        item.image = normalImage
        item.selectedImage = selectedImage
        item.title = ""
        nav.tabBarItem = item
        nav.navigationBar.isHidden = true
        return nav
    }


}

