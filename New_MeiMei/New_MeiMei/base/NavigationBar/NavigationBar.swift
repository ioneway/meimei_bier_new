//
//  NavigationBar.swift
//  newToken_swift
//
//  Created by 王伟 on 2018/12/25.
//  Copyright © 2018 王伟. All rights reserved.
//

import UIKit
import SnapKit


/// NavigationBar UI类似系统
class NavigationBar: UIView, NavStyleProtocol {
   
    var hideLine: Bool = false {
        didSet {
            self._line.isHidden = hideLine
        }
    }
    var hide: Bool = false {
        didSet {
            self.isHidden = hide
        }
    }
    var rightBtn: UIButton?
    
    var rightNavImg: UIImage?
    
    var tagImg: UIImage?
    
    
    /// 标题
    public  var title: String  {
        didSet {
            self._titleLab.text = title
        }
    }
    
    /// 左侧按钮图片
    public  var leftImg: UIImage? {
        didSet {
            self.leftNavBtn?.setImage(leftImg, for: .normal)
        }
    }
    
    /// 右侧按钮图片
    public  var rightImg: UIImage?  {
        didSet {
            self.rightNavBtn?.setImage(leftImg, for: .normal)
        }
    }
    
    internal lazy var leftNavBtn: UIButton? = {
        let temp = UIButton()
        temp.setImage(ImageAsset.nv_back.value, for: .normal)
        self.addSubview(temp)
        temp.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.x)
            make.top.equalToSuperview().offset(kNavi_HEIGHT-34)
            make.height.equalTo(22)
            make.width.equalTo(35)
        }
        return temp
    }()
    
    internal lazy var rightNavBtn: UIButton? = {
        let temp = UIButton()
        self.addSubview(temp)
        temp.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15.x)
            make.top.equalToSuperview().offset(kNavi_HEIGHT-34)
            make.height.equalTo(22)
            make.width.equalTo(55)
        }
        return temp
    }()
    
    private lazy var _titleLab: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.textColor = .white
        temp.font = FontAsset.PingFangSC_Medium.size(.Level18)
        self.addSubview(temp)
        temp.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-40.x)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(kNavi_HEIGHT - 44)
            make.left.equalToSuperview().offset(40.x)
            make.height.equalTo(40)
        }
        return temp
    }()
    
    private lazy var _line: UIView = {
        let temp = UIView()
        temp.backgroundColor = ColorAsset.ceeeeee.value
        self.addSubview(temp)
        temp.isHidden = true
        temp.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(0.x)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.7)
        }
        return temp
    }()
    
    override init(frame: CGRect) {
        self.title = ""
        let frame = CGRect.init(x: 0, y: 0, width: kSCREEN_WIDTH, height: kNavi_HEIGHT)
        super.init(frame: frame)
        self.backgroundColor = .clear
        let _ = self._line
        let _ = self._titleLab
        let _ = self.leftNavBtn
        let _ = self.rightNavBtn
        let _ = self.rightBtn
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

