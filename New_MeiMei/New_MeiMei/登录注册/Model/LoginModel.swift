//
//  LoginModel.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/24.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ObjectMapper


class LoginModel: Mappable, CustomDebugStringConvertible{
    var accid: String = ""
    var avatar_verifed: String = ""
    var imtoken: String = ""
    var is_bind_mobile = false
    var is_goddess = false
    var is_need = false
    var is_vip = false
    var mobile = ""
    var msg = ""
    var result = 0
    var sex = ""
    var time = 0
    var token = ""
    var userInfo: LoginUserInfo?
    
    var debugDescription: String {
        return """
        LoginModel：{
        accid: \(String(describing: accid))
        avatar_verifed: \(String(describing: avatar_verifed))
        imtoken: \(imtoken)
        is_bind_mobile: \( is_bind_mobile)
        is_goddess: \(is_goddess)
        is_need: \(is_need)
        is_vip: \(is_vip)
        mobile: \(mobile)
        msg: \(msg)
        result: \(result)
        
        sex: \(sex)
        time: \(time)
        token: \(token)
        userInfo: \(String(describing: userInfo))
        
        }
        """
    }
    
    
    required init?(map: Map){}
    init() {}
    
    func mapping(map: Map)
    {
        accid <- map["accid"]
        avatar_verifed <- map["avatar_verifed"]
        imtoken <- map["imtoken"]
        is_bind_mobile <- map["is_bind_mobile"]
        
        is_goddess <- map["is_goddess"]
        is_need <- map["is_need"]
        is_vip <- map["is_vip"]
        mobile <- map["mobile"]
        msg <- map["msg"]
        result <- map["result"]
        sex <- map["sex"]
        time <- map["time"]
        token <- map["token"]
        userInfo <- map["userInfo"]
    }
}


final class EXLogin:  Mappable, CustomDebugStringConvertible {
    
    var age: String = ""
    var album: [String] = []
    var area: String = ""
    var city: String = ""
    var evaluate_score: String = ""
    var extend_mobile: String = ""
    var msg_remind: String = ""
    var province: String = ""
    var public_contact: String = ""
    var qqnum: String = ""
    var weixin: String = ""
    var weixin_open_id: String = ""
    var received_reward: Int = 0
    var sex: String = ""
    var vip: Bool = false
    
    var voice: Comminute?
    var video: Comminute?
    var message: Comminute?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        age <- map["age"]
        album <- map["album"]
        area <- map["area"]
        
        city <- map["city"]
        evaluate_score <- map["evaluate_score"]
        extend_mobile <- map["extend_mobile"]
        msg_remind <- map["msg_remind"]
        
        province <- map["province"]
        public_contact <- map["public_contact"]
        qqnum <- map["qqnum"]
        
        weixin <- map["weixin"]
        weixin_open_id <- map["weixin_open_id"]
        
        voice <- map["voice"]
        video <- map["video"]
        message <- map["message"]
        
        received_reward <- map["received_reward"]
        sex <- map["sex"]
        vip <- map["vip"]
    }
    
    var debugDescription: String {
        return """
        EX：{
        age: \(String(describing: age))
        album: \(String(describing: album))
        area: \(String(describing: area))
        
        city: \(String(describing: city))
        evaluate_score: \(String(describing: evaluate_score))
        extend_mobile:  \(String(describing: extend_mobile))
        msg_remind: \(String(describing: msg_remind))
        
        province: \(String(describing: province))
        public_contact: \(String(describing: public_contact))
        qqnum: \(String(describing: qqnum))
        
        weixin: \(String(describing: weixin))
        weixin_open_id: \(String(describing: weixin_open_id))
        
        voice: \(String(describing: voice))
        video: \(String(describing: video))
        message: \(String(describing: message))
        
        received_reward: \(String(describing: received_reward))
        sex: \(String(describing: sex))
        vip: \(String(describing: vip))
        }
        """
    }
}



final class LoginUserInfo:  Mappable, CustomDebugStringConvertible{
    
    var avatar: String = ""
    var birth: String = ""
    var mobile: String = ""
    var nickname: String = ""
    var sex: String = ""
    var signature: String = ""
    
    var ex: EXLogin?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        avatar <- map["avatar"]
        birth <- map["birth"]
        mobile <- map["mobile"]
        nickname <- map["nickname"]
        sex <- map["sex"]
        signature <- map["signature"]
        ex <- map["ex"]
    }
    
    var debugDescription: String {
        return """
        LoginUserInfo：{
        avatar: \(String(describing: avatar))
        birth: \(String(describing: birth))
        mobile: \(String(describing: mobile))
        nickname: \(String(describing: nickname))
        sex: \(String(describing: sex))
        signature: \(String(describing: signature))
        ex: \(String(describing: ex))
        }
        """
    }
}


final class Comminute: Codable, Mappable, CustomDebugStringConvertible {
    
    var price: String = ""
    var `switch`: String = ""
    
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        price <- map["date"]
        `switch` <- map["switch"]
    }
    
    var debugDescription: String {
        return """
        Comminute：{
        price: \(String(describing: price))
        `switch`: \(String(describing: `switch`))
        
        }
        """
    }
}




