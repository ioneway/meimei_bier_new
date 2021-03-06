//
//  NSObject+String.swift
//  TSWeChat
//
//  Created by Hilen on 11/3/15.
//  Copyright © 2015 Hilen. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    class var wholeClassName: String {
        return NSStringFromClass(self)
    }
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    //用于获取 cell 的 reuse identifier
    class var identifier: String {
        return String(format: "%@", self.className)
    }
    
    // MARK:返回className
    var className:String{
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
            
        }
    }
}
