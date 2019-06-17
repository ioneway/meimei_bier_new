//
//  UIView+Gen.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/24.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIView {
    func gradient() {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.colors = [ ColorAsset.c6950FB.value?.cgColor ?? UIColor.black.cgColor, ColorAsset.cB83AF3.value?.cgColor ?? UIColor.white.cgColor]
        layer.locations = [0, 1]
        layer.frame = self.layer.bounds
        
        self.layer.insertSublayer(layer, at: 0)
    }
    
    //圆角
    func corner() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.height/2.0
    }
}


