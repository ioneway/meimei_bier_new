//
//  BannerModel.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/25.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ObjectMapper



class NearbyResponseModel: Mappable, CustomDebugStringConvertible{
    var debugDescription: String{
        return """
        NearbyResponseModel：{
            result: \(String(describing: result))
            msg: \(String(describing: msg))
            list: \(String(describing: list))
        }
        """
    }
    
    var result: Int = 1
    var msg: String = ""
    var nextPage: Int = 1
    var pervPage: Int = 1
    var totalCount: Int = 0
    var list: [NearbyModel] = []
    
    required init?(map: Map){}
    init() {}
    
    func mapping(map: Map)
    {
        result <- map["result"]
        msg <- map["msg"]
        list <- map["list"]
    }
    
}
class NearbyModel: Mappable, CustomDebugStringConvertible{
    var age: String?
    var amount: Int?
    var avatar : String?
    var online :Int?
    var id : String?
    var nickname : String?
    var signature: String?
    var status : String?
    var type : String?
    var lat: String?
    var lng: String?
    var distance: Int?
    var allowSayHi: Bool = false
    var is_featured : String?
    
    var debugDescription: String {
        return """
        NearbyModel：{
            age: \(String(describing: age))
            amount: \(String(describing: amount))
            avatar: \(String(describing: avatar))
            online: \(String(describing: online))
            id: \(String(describing: id))
            nickname: \(String(describing: nickname))
            signature: \(String(describing: signature))
            status: \(String(describing: status))
            type: \(String(describing: type))
            lat: \(String(describing: lat))
            lng: \(String(describing: lng))
            distance: \(distance)
            is_featured: \(String(describing: is_featured))
            allowSayHi: \(allowSayHi)
        }
        """
    }
    
    
    required init?(map: Map){}
    init() {}
    
    func mapping(map: Map)
    {
        id <- map["id"]
        is_featured <- map["is_featured"]
        age <- map["age"]
        
        amount <- map["amount"]
        type <- map["type"]
        avatar <- map["avatar"]
        
        signature <- map["signature"]
        lat <- map["lat"]
        allowSayHi <- map["allowSayHi"]
        
        lng <- map["lng"]
        nickname <- map["nickname"]
        distance <- map["distance"]
        status <- map["status"]
        online <- map["online"]
    }
}
