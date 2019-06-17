//
//  LCAPI.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/25.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Moya
//聊场模块

enum LCAPI{
    case banner                         //banner图
    case nearby(page: Int)             //查询附近的人
    case recommend(page: Int)           //
    case greet
}

extension LCAPI{
    var path:String{
        switch self {
            case .banner:
                return "/api/public/get_banner"
            case .nearby(_):
                return "/api/index/nearby"
            case .recommend(_):
                return "/api/public/member_list_recommend"
            case .greet:
                return "/api/chat/greet"
        }
    }
    
    var method: Moya.Method{
        return .post
    }
    
    var task:Task{
        switch self {
            case .banner:
               return .requestJSONEncodable(API.baseParameter)
            case .nearby(let page):
                return .requestJSONEncodable( ["lat":Location.default.latitude  ,"lng":Location.default.longitude,
                                 "page": "\(page)", "page_size": "20"] + API.baseParameter )
            case .recommend(let page):
                return .requestJSONEncodable( ["lat":Location.default.latitude  ,"lng":Location.default.longitude,
                                           "page": "\(page)", "page_size": "20"] + API.baseParameter )
            case .greet:
                return .requestJSONEncodable( ["type": UserInfo.default.sex == "o" ? "1" : "2" ] + API.baseParameter)
        
        
        }
    }
}

