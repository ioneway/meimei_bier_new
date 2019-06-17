//
//  UIColor+Asset.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

typealias ColorAsset = UIColor.Asset

extension UIColor {
    public enum Asset: String {
        case cfed103
        case ceeeeee
        case c6950FB
        case c999999
        case cB83AF3
        case c333333
        case c666666
        case c6BB9F6
        case cFF2A16
        case cCDCAFD
        
        var value: UIColor? {
            return UIColor.init(named: self.rawValue)
        }
    }
}

