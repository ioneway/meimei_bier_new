//
//  LCAPI.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/25.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Moya
//消息模块

enum MessageAPI{
    case systemMessage(page: Int)
    case readMessage(infoids: [String])
}

extension MessageAPI{
    var path:String{
        switch self {
            case .systemMessage(_):
                return "/api/station_msg/index"
            case .readMessage(_):
                return "/api/station_msg/read"
        }
    }
    
    var method: Moya.Method{
        return .post
    }
    
    var task:Task{
        switch self {
            case .systemMessage(let page):
                return .requestJSONEncodable( ["page": "\(page)", "page_size": "50"] + API.baseParameter)
            case .readMessage(let infoids):
                return .requestJSONEncodable( ["infoids": "\(infoids)"] + API.baseParameter)
        }
    }
}

