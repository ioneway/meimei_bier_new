//
//  NavigationFactory.swift
//  newToken_swift
//
//  Created by 王伟 on 2018/12/26.
//  Copyright © 2018 王伟. All rights reserved.
//

import UIKit

protocol NavStyleProtocol {
    var title: String { set get }
 
    var leftImg: UIImage? { set get }
    var rightNavImg: UIImage? { set get }
    var rightImg: UIImage? { set get }
    var tagImg: UIImage? { set get }
    var rightNavBtn: UIButton? { set get }
    var leftNavBtn: UIButton? { set get }
    var rightBtn: UIButton? { set get }
    var hideLine: Bool { set get }
    var hide: Bool { set get }
}

//头部导航条的风格
enum NavStyle {
    case System
}

class NavigationFactory: NSObject {
    
    static func navigationBar(style: NavStyle) -> NavStyleProtocol? {
        var factory:NavStyleProtocol?
        switch (style) {
        case .System:
            factory = NavigationBar.init(frame: CGRect.zero)
        }
        
        return factory
    }
}
