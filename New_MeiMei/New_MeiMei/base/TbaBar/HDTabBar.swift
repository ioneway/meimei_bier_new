//
//  HDTabBar.swift
//  HDJ
//
//  Created by 王伟 on 2019/4/9.
//  Copyright © 2019 王伟. All rights reserved.
//  自定义tabbar，参考：http://www.cnblogs.com/guitarandcode/p/5759208.html

import UIKit

class HDTabBar: UITabBar {

    let centerBtn: UIButton = {
        let temp = UIButton()
        temp.frame = CGRect.init(x: 0, y: 7, width: 70, height: 80)
        return temp
    }()
    
    let bgImageView: UIImageView = {
        let temp = UIImageView()
        temp.image = UIImage.init(named: "tab")
        temp.isUserInteractionEnabled = true
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bgImageView)
        bgImageView.addSubview(centerBtn)
        centerBtn.centerX = bgImageView.centerX
        centerBtn.y = 7
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImageView.frame = CGRect.init(x: 0, y: 0, width: kSCREEN_WIDTH, height: self.height + 41)
        bgImageView.y = -41
        centerBtn.centerX = bgImageView.centerX
        centerBtn.y = 7
        let width = kSCREEN_WIDTH / 2
        var num: CGFloat = 0.0;
        for (_, sub) in self.subviews.enumerated() {
            if sub.isKind(of: NSClassFromString("UITabBarButton")!) {
                num = num + 1.0
                if (num == 1.0) {
                    sub.frame = CGRect.init(x: -30, y: 0, width: width-10, height: 70)
                }else {
                    sub.frame = CGRect.init(x: (num-1) * width + 30, y: 0, width: width-10, height: 70)
                }
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden == false {
            let newPoint = self.convert(point, to: self.centerBtn)
            if (self.centerBtn.point(inside: newPoint, with: event)) {
                return self.centerBtn
            }else {
                return super.hitTest(point, with: event)
            }
        } else {
            return super.hitTest(point, with: event)
        }
    }
}
