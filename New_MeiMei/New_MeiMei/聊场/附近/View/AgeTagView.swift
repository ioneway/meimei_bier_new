//
//  AgeTagView.swift
//  New_MeiMei
//
//  Created by admin on 2019/6/6.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Foundation

class AgeTagView: UIView {

    let ageLab: UILabel = {
        let temp = UILabel()
        temp.text = ""
        temp.textAlignment = .center
        temp.font = FontAsset.PingFangSC_Medium.size(.Level10)
        temp.textColor = .white
        return temp
    }()
    
    // true 男， false 女
    var gender: Bool = false {
        didSet{
            self.backgroundColor = gender ? ColorAsset.c6BB9F6.value : ColorAsset.cFF2A16.value
            self.icoView.image = gender ? ImageAsset.ic_gender_w.value : ImageAsset.ic_gender_w.value
        }
    }
    
    var age: Int = 20 {
        didSet {
            self.ageLab.text = "\(age)"
            self.ageLab.sizeToFit()
        }
    }

    let icoView: UIImageView = {
        let temp = UIImageView()
        temp.image = ImageAsset.ic_gender_w.value
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 43, height: 15))
        self.layer.cornerRadius = 6.5
        self.clipsToBounds = true
        
        icoView.frame = CGRect.init(x: 7, y: 0, width: 11, height: 10)
        icoView.centerY = self.centerY
        self.addSubview(icoView)
        
        ageLab.sizeToFit()
        ageLab.x = 23
        ageLab.height = 14
        ageLab.centerY = self.centerY
        self.addSubview(ageLab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
