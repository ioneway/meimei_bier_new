//
//  UIButton+Indicator.swift
//  newToken_swift
//
//  Created by 王伟 on 2019/1/7.
//  Copyright © 2019 王伟. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    struct RuntimeKey {
        static let kIndicatorViewKey = UnsafeRawPointer.init(bitPattern: "indicatorView".hashValue)
        static let kButtonTextObjectKey = UnsafeRawPointer.init(bitPattern: "buttonTextObject".hashValue)
        
    }
    
    var indicatorView: UIActivityIndicatorView? {
        set {
            objc_setAssociatedObject(self, UIButton.RuntimeKey.kIndicatorViewKey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, UIButton.RuntimeKey.kIndicatorViewKey!) as? UIActivityIndicatorView
        }
    }
    
    var buttonTextObject: String? {
        set {
            objc_setAssociatedObject(self, UIButton.RuntimeKey.kButtonTextObjectKey!, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, UIButton.RuntimeKey.kButtonTextObjectKey!) as? String
        }
    }
    
    public func showIndicator() {
        let indicator = UIActivityIndicatorView.init(style: .white)
        indicator.center = CGPoint.init(x: self.bounds.width/2, y: self.bounds.height/2)
        indicator.startAnimating()
        self.buttonTextObject = self.titleLabel?.text
        self.indicatorView = indicator
        self .setTitle("", for: .normal)
        self.isEnabled = false
        self.addSubview(indicator)
    }
    
    public func hideIndicator() {
        self.indicatorView?.removeFromSuperview()
        self.isEnabled = true
        self.setTitle(self.buttonTextObject, for: .normal)
    }
}
