//
//  UserInfo.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/24.
//  Copyright © 2019 admin. All rights reserved.
//


import UIKit
import SwiftyUserDefaults


extension DefaultsKeys {
    static let userInfoKey = DefaultsKey<UserInfo?>("userInfoKey")
}

final class UserInfo: Codable, DefaultsSerializable {
    
    var mobile: String = ""
    var avatar: String = ""
    var nickname: String = ""
    var birth: String = ""
    var signature: String = ""
    var sex: String = ""
    var is_goddess: Bool = false
    var is_vip: Bool = false
    var name: String = ""
    var token: String = ""
    var is_need: Bool = false
    var accid: String = ""
    
    var is_bind_mobile: Bool = false
    var imtoken:String = ""
    var avatar_verifed: String = ""
    var album: [String] = []
    var age: String = ""
    var area: String = ""
    var city: String = ""
    var province: String = ""
    var evaluate_score: String = ""
    var extend_mobile: String = ""
    
    
    var msg_remind: String = ""
    var public_contact: String = ""
    var qqnum: String = ""
    var received_reward: String = ""
    var video: Comminute?
    var message:Comminute?
    var voice: Comminute?
    var vip: Bool = false
    var weixin: String = ""
    var weixin_open_id: String = ""
    
    var systemVibrate: Bool = true

    
    var isLogin: Bool {
        if token != "" {
            return true
        }else {
            return false
        }
    }
    
    static let `default`: UserInfo = UserInfo()
    
    
    
    init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(write), name: UIApplication.didEnterBackgroundNotification, object: nil)
        guard let obj = Defaults[.userInfoKey] else { return }
        
        self.is_bind_mobile = obj.is_bind_mobile
        self.imtoken = obj.imtoken
        self.avatar_verifed = obj.avatar_verifed
        self.album = obj.album
        self.age = obj.age
        self.area = obj.area
        self.city = obj.city
        self.province = obj.province
        self.evaluate_score = obj.evaluate_score
        self.extend_mobile = obj.extend_mobile
        self.message = obj.message
        
        self.accid = obj.accid
        self.msg_remind = obj.msg_remind
        self.public_contact = obj.public_contact
        self.qqnum = obj.qqnum
        self.received_reward = obj.received_reward
        self.video = obj.video
        self.vip = obj.vip
        self.voice = obj.voice
        self.weixin = obj.weixin
        self.weixin_open_id = obj.weixin_open_id
        
        
        self.mobile = obj.mobile
        self.avatar = obj.avatar
        self.nickname = obj.nickname
        self.birth = obj.birth
        self.signature = obj.signature
        self.sex = obj.sex
        self.is_goddess = obj.is_goddess
        self.is_vip = obj.is_vip
        self.name = obj.name
        self.token = obj.token
        self.is_need = obj.is_need
        
        self.systemVibrate = obj.systemVibrate
        
    }
    
    
    
    @objc func write() { //写入数据
        Defaults[DefaultsKeys.userInfoKey] = self
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

