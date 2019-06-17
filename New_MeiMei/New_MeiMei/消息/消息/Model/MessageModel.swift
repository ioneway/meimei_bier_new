//
//  BannerModel.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/25.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ObjectMapper



class MessageResponseModel: Mappable, CustomDebugStringConvertible{
    var debugDescription: String{
        return """
        MessageResponseModel：{
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
    var list: [MessageModel] = []
    
    required init?(map: Map){}
    init() {}
    
    func mapping(map: Map)
    {
        result <- map["result"]
        msg <- map["msg"]
        list <- map["list"]
    }
    
}
class MessageModel: Mappable, CustomDebugStringConvertible{
    var title : String?
    var desc : String?
    var createtime : String?
    var id:String?
    var msgid:String?
    var status:String?
    
    var debugDescription: String {
        return """
        MessageModel：{
            title: \(String(describing: title))
            desc: \(String(describing: desc))
            createtime: \(String(describing: createtime))
            id: \(String(describing: id))
            msgid: \(String(describing: msgid))
            status: \(String(describing: status))
        }
        """
    }
    
    
    required init?(map: Map){}
    init() {}
    
    func mapping(map: Map)
    {
        title <- map["title"]
        desc <- map["desc"]
        createtime <- map["createtime"]
        
        id <- map["id"]
        msgid <- map["msgid"]
        status <- map["status"]
    }
}
