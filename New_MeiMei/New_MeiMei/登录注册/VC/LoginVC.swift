//
//  LoginVC.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/24.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginVC: BaseViewController {
    
    /// 手机号
    private var _phoneField: InputField = {
        let temp = InputField()
        temp.leftImg = ImageAsset.phon_login.value
        temp.placeHolder = "请输入手机号码（11位）"
        return temp
    }()
    
    /// 验证码
    private lazy var _codeField: InputField = {
        let temp = InputField()
        temp.leftImg = ImageAsset.pwd_login.value
        temp.placeHolder = "请输入验证码"
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 126, height: 39))
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 105, height: 39))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("获取验证码", for: .normal)
        btn.titleLabel?.font = FontAsset.PingFangSC_Medium.size(.Level14)
        btn.corner()
        btn.gradient()
        btn.countTime = 60
        btn.timing = {(btn, count) in
            btn?.setTitle("剩余\(count)s", for: .normal)
        }
        btn.addTarget(self, action: #selector(codeBtnClick(sender:)), for: .touchUpInside)
        view.addSubview(btn)
        temp.rightView = view
        return temp
    }()
    
    
    @objc func codeBtnClick(sender: UIButton) {
        
        if _phoneField.text?.isPhone == false {
            self.view.makeToast("手机号格式不正确", position: .center)
        }else {
            self.sendSMSCodeCompleted {
                sender.fire()
            }
        }
    }
    
    //发送验证码
    private func sendSMSCodeCompleted(block:@escaping () -> Void) {
        MMProvider.request(.Login(.smsCode(mobile: _phoneField.text ?? "" )), completion:  {[weak self] result in
            switch result{
            case let .success(response):
                do {
                    let repos: ResponseModel? = ResponseModel(JSON: try response.mapJSON() as! [String : Any])
                    
                    if let repos = repos {
                        if repos.result == 1 {
                            block()
                            self?.view.makeToast("验证码发送成功", position: .center)
                        }else {
                            self?.view.makeToast(repos.msg, position: .center)
                        }
                    } else {
                    }
                } catch {
                    
                }
            case let .failure(error):
                
                guard let description = error.errorDescription else {
                    break
                }
                print(description)
            }
        })
    }
    
    
    private lazy var _makeSureBtn: UIButton = {
        let temp = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: kSCREEN_WIDTH-2*16, height: 47))
        temp.corner()
        temp.gradient()
        temp.setTitle("确定", for: .normal)
        temp.setTitleColor(.white, for: .normal)
        temp.titleLabel?.font = FontAsset.PingFangSC_Medium.size(.Level16)
        temp.addTarget(self, action: #selector(makeSureBtnClick), for: .touchUpInside)
        return temp
    }()
    
    @objc func makeSureBtnClick() {
        //登录
        if _codeField.text?.count == 6 {
            //登录
            self.login {
                
                AppDelegate.default.setRootVC()
            }
        }else {
            self.view.makeToast("验证码格式不正确", position: .center)
        }
    }
    
    
    private func login(block:@escaping () -> Void) {
        
        MMProvider.request(.Login(.login(mobile: _phoneField.text ?? "", code: _codeField.text ?? "" )), completion: {[weak self] result in
            switch result{
            case let .success(response):
                do {
                    let repos: LoginModel? = LoginModel(JSON: try response.mapJSON() as! [String : Any])
                    
                    if let repos = repos {
                        if repos.result == 1 {
                            
                            UserInfo.default.is_bind_mobile = repos.is_bind_mobile
                            UserInfo.default.imtoken = repos.imtoken
                            UserInfo.default.token = repos.token
                            UserInfo.default.accid = repos.accid
                            UserInfo.default.avatar_verifed = repos.avatar_verifed
                            UserInfo.default.album = repos.userInfo?.ex?.album ?? []
                            UserInfo.default.age = repos.userInfo?.ex?.age ?? ""
                            UserInfo.default.area = repos.userInfo?.ex?.area ?? ""
                            UserInfo.default.city = repos.userInfo?.ex?.city ?? ""
                            UserInfo.default.province = repos.userInfo?.ex?.province ?? ""
                            UserInfo.default.evaluate_score = repos.userInfo?.ex?.evaluate_score ?? ""
                            UserInfo.default.extend_mobile = repos.userInfo?.ex?.extend_mobile ?? ""
                            UserInfo.default.message = repos.userInfo?.ex?.message
                            UserInfo.default.msg_remind = repos.userInfo?.ex?.msg_remind ?? ""
                            UserInfo.default.public_contact = repos.userInfo?.ex?.public_contact ?? ""
                            UserInfo.default.qqnum = repos.userInfo?.ex?.qqnum ?? ""
                            UserInfo.default.received_reward = "\(repos.userInfo?.ex?.received_reward ?? 0)"
                            UserInfo.default.msg_remind = repos.userInfo?.ex?.msg_remind ?? ""
                            UserInfo.default.public_contact = repos.userInfo?.ex?.public_contact ?? ""
                            UserInfo.default.qqnum = repos.userInfo?.ex?.qqnum ?? ""
                            
                            UserInfo.default.video = repos.userInfo?.ex?.video
                            UserInfo.default.vip = repos.userInfo?.ex?.vip ?? false
                            UserInfo.default.voice = repos.userInfo?.ex?.voice
                            UserInfo.default.weixin = repos.userInfo?.ex?.weixin ?? ""
                            UserInfo.default.weixin_open_id = repos.userInfo?.ex?.weixin_open_id ?? ""
                            
                            UserInfo.default.write()
                            
                            block()
                            
                            
                            
                        }else {
                            self?.view.makeToast(repos.msg, position: .center)
                        }
                    } else {}
                } catch {
                    
                }
            case let .failure(error):
                
                guard let description = error.errorDescription else {
                    break
                }
                print(description)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "手机登录"
        
        self.view.addSubview(_phoneField)
        self.view.addSubview(_codeField)
        
        _phoneField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(kNavi_HEIGHT + 20)
            make.height.equalTo(70)
        }
        
        _codeField.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(_phoneField.snp.bottom).offset(1)
            make.height.equalTo(70)
        }
        
        self.view.addSubview(_makeSureBtn)
        _makeSureBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-20 - kBottom_HEIGHT)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(47)
        }
    }
    
    
}

