//
//  BannerModel.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/25.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ObjectMapper

class BannerResponseModel: Mappable, CustomDebugStringConvertible{
    var debugDescription: String{
        return """
        BannerResponseModel：{
            result: \(String(describing: result))
            msg: \(String(describing: msg))
            banners: \(String(describing: banners))
        }
        """
    }
    
    var result: Int = 1
    var msg: String = ""
    var banners: [BannerModel] = []
    
    required init?(map: Map){}
    init() {}
    
    func mapping(map: Map)
    {
        result <- map["result"]
        msg <- map["msg"]
        banners <- map["banners"]
    }
    
}
class BannerModel: Mappable, CustomDebugStringConvertible{
    var code: String = ""
    var id: String = ""
    var img_link: String = ""
    
    var debugDescription: String {
        return """
        BannerModel：{
            code: \(String(describing: code))
            id: \(String(describing: id))
            img_link: \(img_link)
        }
        """
    }
    
    
    required init?(map: Map){}
    init() {}
    
    func mapping(map: Map)
    {
        code <- map["code"]
        id <- map["id"]
        img_link <- map["img_link"]
    }
}
