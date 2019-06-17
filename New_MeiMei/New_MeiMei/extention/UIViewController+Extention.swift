//
//  UIViewController+Extention.swift
//  newToken_swift
//
//  Created by 王伟 on 2019/1/11.
//  Copyright © 2019 王伟. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func topViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
        let viewController = viewController ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let vc = viewController as? ViewController {
//            return self.topViewController(vc.vmTabBarController)
        }
        
        if let navigationController = viewController as? UINavigationController,
            !navigationController.viewControllers.isEmpty
        {
            return self.topViewController(navigationController.viewControllers.last)
            
        } else if let tabBarController = viewController as? UITabBarController,
            let selectedController = tabBarController.selectedViewController
        {
            return self.topViewController(selectedController)
            
        } else if let presentedController = viewController?.presentedViewController {
            return self.topViewController(presentedController)
            
        }
        
        return viewController
    }
}

