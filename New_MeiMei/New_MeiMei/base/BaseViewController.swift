//
//  BaseViewController.swift
//  newToken_swift
//
//  Created by 王伟 on 2018/12/25.
//  Copyright © 2018 王伟. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    var noDataTipView: UIView?
    /// 是否支持滑动返回，默认支持
    public var canSlidBack = true {
        didSet {
            if canSlidBack {
                let target = self.navigationController?.interactivePopGestureRecognizer?.delegate;
                let pan = UIPanGestureRecognizer.init(target: target, action: nil)
                self.view.addGestureRecognizer(pan)
            }
        }
    }
    
    public var navigationBar: NavStyleProtocol?
    
    public var navStyle: NavStyle = .System
    {
        didSet {
            self.navigationBar = NavigationFactory.navigationBar(style: navStyle)
            self.view.addSubview(navigationBar as! UIView)
            self.navigationBar?.leftNavBtn?.addTarget(self, action: #selector(self.leftNavBtnClick(sender :)), for: .touchUpInside)
            self.navigationBar?.rightNavBtn?.addTarget(self, action: #selector(self.rightNavBtnClick(sender :)), for: .touchUpInside)
            self.navigationBar?.rightBtn?.addTarget(self, action: #selector(self.leftBtnClick(sender :)), for: .touchUpInside)
        }
    }
    
    override public var title: String? {
        didSet {
            self.navigationBar?.title = title ?? ""
        }
    }
    
    
    func showNoDataTipsView(show:Bool, forTargetView scrollView:UIScrollView!, image: UIImage = ImageAsset.nodate.value ?? UIImage(), text: String = "",
                            tapClosure:(() -> Void)? = nil) {
        guard let targetView = scrollView else {return}
        DispatchQueue.main.async {
            if self.noDataTipView == nil {
                self.initNoDataTipsView(targetView: targetView, image: image, text: text, tapClosure: tapClosure)
            }
            self.noDataTipView?.isHidden = !show
        }
    }
    
    private func initNoDataTipsView(targetView:UIView, image: UIImage?, text: String,
                                    tapClosure:(() -> Void)? = nil) {
        let v = UIView()
        v.backgroundColor = .clear
        self.view.addSubview(v)
        v.snp.makeConstraints({ (make) in
            make.edges.equalTo(targetView)
        })
        
        
        let imageV = UIImageView(image: image)
        v.addSubview(imageV)
        imageV.snp.makeConstraints ({ (make) in
            make.center.equalTo(v)
            make.size.equalTo(CGSize(width:227, height: 130))
        })
        let label = UILabel()
        label.font = FontAsset.PingFangSC_Regular.size(.Level13)
        label.numberOfLines = 0
        label.text = text
        v.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageV.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        v.addTapGesture{ _ in
            tapClosure?()
        }
        
        self.noDataTipView = v
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorAsset.ceeeeee.value
        self.navStyle = .System
        let view = self.navigationBar as? UIView
//        view?.gradient()
        view?.backgroundColor = ColorAsset.cfed103.value
    }
    
    @objc  public func leftNavBtnClick(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc  public func rightNavBtnClick(sender: UIButton) {}
    @objc  public func leftBtnClick(sender: UIButton) {}
    
    deinit {
        print("deinit\(String(describing: self.className))")
    }
}
