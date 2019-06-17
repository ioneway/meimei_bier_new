//
//  ZCSegmented.swift
//  contactLayout
//
//  Created by air on 2018/8/14.
//  Copyright © 2018年 air. All rights reserved.
//

import UIKit

class ZCSegmented: UIView {
    
    var firstBlock : (()->())?
    var secondBlock : (()->())?
    private var unumber:Int!
    private var selectIndex:Int!
    let btn_first : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(ColorAsset.c333333.value, for: .normal)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.backgroundColor = .clear
        btn.isSelected = true
        btn.tag = 1
        btn.addTarget(self, action: #selector(click_status(_:)), for: .touchUpInside)
        return btn
    }()
    
    let btn_second : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(ColorAsset.c333333.value, for: .normal)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.backgroundColor = .clear
        btn.tag = 2
        btn.addTarget(self, action: #selector(click_status(_:)), for: .touchUpInside)
        return btn
    }()
    
    let selectorIV : UIImageView = {
        let view = UIImageView(image: ImageAsset.segment_sel.value)
        return view
    }()
    
    public init(frame: CGRect,firstTitle:String,secondTitle:String,firstClick:@escaping () ->(),secondClick:@escaping ()->()) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        let backIV = UIImageView(image: ImageAsset.segment_normal.value)
        self.addSubview(backIV)
        backIV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.btn_first.setTitle(firstTitle, for: .normal)
        self.btn_second.setTitle(secondTitle, for: .normal)
        self.addSubview(self.selectorIV)
        self.addSubview(self.btn_second)
        self.addSubview(self.btn_first)
        self.addSubview(redDot)
        redDot.isHidden = true
        self.setNeedsUpdateConstraints()
        self.firstBlock = firstClick
        self.secondBlock = secondClick
        self.updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        self.btn_first.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
        self.btn_second.snp.makeConstraints { (make) in
            make.left.equalTo(self.btn_first.snp.right)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self)
            make.width.equalTo(self.btn_first.snp.width)
            make.right.equalTo(self.snp.right)
        }
        self.selectorIV.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(self.btn_first.snp.width)
        }
        redDot.snp.makeConstraints { (make) in
            make.centerX.equalTo((btn_second.titleLabel?.snp.right)!)
            make.centerY.equalTo((btn_second.titleLabel?.snp.top)!).offset(3)
            make.size.equalTo(CGSize(width: 6, height: 6))
        }
    }
    
    @objc func click_status( _ sender : UIButton){
        sender.isSelected = true
        if sender.tag == 1{
            UIView.animate(withDuration: 0.5) {
                self.selectorIV.snp.remakeConstraints({ (make) in
                    make.left.equalTo(self.btn_first.snp.left)
                    make.top.equalTo(self.snp.top)
                    make.bottom.equalTo(self.snp.bottom)
                    make.width.equalTo(self.btn_first.snp.width)
                })
               self.layoutIfNeeded()
            }
            self.firstBlock?()
            self.btn_second.isSelected = false
        }else{
           
            UIView.animate(withDuration: 0.5) {
                self.selectorIV.snp.remakeConstraints({ (make) in
                    make.left.equalTo(self.btn_first.snp.right)
                    make.top.equalTo(self.snp.top)
                    make.bottom.equalTo(self.snp.bottom)
                    make.width.equalTo(self.btn_first.snp.width)
                })
                self.layoutIfNeeded()
            }
            self.secondBlock?()
            self.btn_first.isSelected = false
        }
    }
    
    lazy var redDot:UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 6))
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 3
        v.backgroundColor = UIColor.red
        return v
    }()
   
    var unreadNumber:Int{
        set{
            unumber = newValue
            if unumber == 0 {
                redDot.isHidden = true
            }else{
                redDot.isHidden = false
            }
        }
        get{
            return unumber
        }
    }
    
    var selectIdx:Int{
        set{
            selectIndex = newValue
            if selectIndex == 1 {
                click_status(btn_first)
            }else if selectIndex == 2{
                click_status(btn_second)
            }
        }
        get{
            return selectIndex
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
