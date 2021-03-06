//
//  UIView+layout.swift
//  Exchange
//
//  Created by rui on 2018/4/18.
//  Copyright © 2018年 common. All rights reserved.
//

import UIKit

// 手动设置UI图的基础宽度
public let BaseWidth = CGFloat(375.0)

public let kWINDOW  = (UIApplication.shared.delegate as? AppDelegate)?.window

public let kSCREEN_BOUNDS  = UIScreen.main.bounds
public let kSCREEN_WIDTH  = UIScreen.main.bounds.width
public let kSCREEN_HEIGHT = UIScreen.main.bounds.height
public let kSTATUS_HEIGHT = isiPhoneX() ? CGFloat(44) : CGFloat(20)
public let kNavi_HEIGHT = isiPhoneX() ? CGFloat(88) : CGFloat(64)
public let kTabbar_HEIGHT = isiPhoneX() ? CGFloat(83) : CGFloat(49)
public let kBottom_HEIGHT = isiPhoneX() ? CGFloat(34) : CGFloat(0)
public let kTop_HEIGHT = isiPhoneX() ? CGFloat(44) : CGFloat(0)

public func isiPhoneX() -> Bool {
    if UIScreen.main.bounds.height >= 812 {
        return true
    }
    return false
}

public func isiPhone5S() -> Bool {
    if UIScreen.main.bounds.size.width == 320 {
        return true
    }
    return false
}

public func isiPhone6() -> Bool {
    if UIScreen.main.bounds.size.width == 375 {
        return true
    }
    return false
}

public func isiPhonePlus() -> Bool {
    if UIScreen.main.bounds.size.width == 414 {
        return true
    }
    return false
}

extension UIView {
    
    
    
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var tmpFrame = frame
            tmpFrame.size.width = newValue
            frame = tmpFrame
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var tmpFrame = frame
            tmpFrame.size.height = newValue
            frame = tmpFrame
        }
    }
    
    
    class func loadFromNib() -> UIView? {
        let cls = NSStringFromClass(self)
        guard let c = cls.components(separatedBy: ".").last else {
           return nil
        }
        return Bundle.main.loadNibNamed(c, owner: nil, options: nil)?.last as? UIView
    }
}


//为了满足CGRect等构造函数的参数类型
extension Int {
    var x: CGFloat {
        return CGFloat(CGFloat(self)/BaseWidth)*CGFloat(kSCREEN_WIDTH)
    }
}
extension Double {
    var x: CGFloat {
        return CGFloat(CGFloat(self)/BaseWidth)*CGFloat(kSCREEN_WIDTH)
    }
}
extension CGFloat {
    var x: CGFloat {
        return CGFloat(CGFloat(self)/BaseWidth)*CGFloat(kSCREEN_WIDTH)
    }
}

extension Int {
    var y: CGFloat {
        return CGFloat(CGFloat(self)/BaseWidth)*CGFloat(kSCREEN_WIDTH)
    }
}
extension Double {
    var y: CGFloat {
        return CGFloat(CGFloat(self)/BaseWidth)*CGFloat(kSCREEN_WIDTH)
    }
}
extension CGFloat {
    var y: CGFloat {
        return CGFloat(CGFloat(self)/BaseWidth)*CGFloat(kSCREEN_WIDTH)
    }
}
