//
//  LoginAPI.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/25.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Moya
//首页

enum LoginAPI{
    case login(mobile: String, code: String)              //登录
    case smsCode(mobile: String)            //登录验证码
}

extension LoginAPI{
    var path:String{
        switch self {
            case .login(_ , _):
                return "/user/login"
            case .smsCode(_):
                return "/api/public/send_sms"
        }
    }
    
    var method: Moya.Method{
        return .post
    }
    
    var task:Task{
        switch self {
            case .login(let mobile, let code):
                return .requestJSONEncodable( ["mobile":mobile  ,"code":code] + API.baseParameter)
            case .smsCode(let mobile):
                return .requestJSONEncodable( ["mobile":mobile ,"type":SMSCodeType.login.rawValue])
        }
        
    }
}

