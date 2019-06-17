//
//  UIView+Event.swift
//  newToken_swift
//
//  Created by 王伟 on 2019/1/10.
//  Copyright © 2019 王伟. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    public func addOnClickListener(target: AnyObject, action: Selector) {
        let tapGes = UITapGestureRecognizer(target: target, action: action);
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGes);
    }
    
    
}
