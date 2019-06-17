//
//  NavigationController.swift
//  newToken_swift
//
//  Created by 王伟 on 2019/1/11.
//  Copyright © 2019 王伟. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let vc = viewController as? BaseViewController
        if let mvc = vc {
            if self.children.count == 0 {
                viewController.hidesBottomBarWhenPushed = true
                
            }
            super.pushViewController(viewController, animated: animated)
            super.hidesBottomBarWhenPushed = false
        }
    }

}
