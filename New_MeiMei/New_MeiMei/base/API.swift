//
//
//  Created by 王伟 on 2018/9/2.
//  Copyright © 2017年 王伟. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import ObjectMapper


enum SMSCodeType: String {
    case register
    case login
    case other
    case weixin
}


enum API {
    case Login(LoginAPI)     //登录模块
    case LCVC(LCAPI)        //聊场
    case Message(MessageAPI)
    
    
    
}

extension API: TargetType {
 
    var serverUrl: String{
//      let url = "http://192.168.1.254:8080"
        let  url =  "http://api.meimei.im"
        return url
    }
    
    var baseURL: URL {

            return URL(string: serverUrl)!
    }
    
    var path: String {
        switch self {
            case .Login(let login):
                return login.path
            case .LCVC(let lcvc):
                return lcvc.path
            case .Message(let message):
                return message.path
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Login(let login):
            return login.method
        case .LCVC(let lcvc):
            return lcvc.method
        case .Message(let message):
            return message.method
        }
    }
    
    var sampleData: Moya.Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
            case .Login(let login):
                return login.task
            case .LCVC(let lcvc):
                return lcvc.task
            case .Message(let message):
                return message.task
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"];
    }
    
    
    static var baseParameter: [String : String]? {
        return [
                "os": "IOS",
                "imsi": App.imsi.imsi,
                "imei": App.IDFV,
                "device": App.deviceName,
                "app_version": App.appVersion,
                "os_version":App.sysVersion,
                "channel": "5",
                "token": UserInfo.default.token
        ];
    }
    
}


private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data
    }
}



//接收响应
class ResponseModel: Mappable, CustomDebugStringConvertible{
    var result: Int = 1
    var msg: String = ""
    
    var debugDescription: String {
        return """
        ResponseModel：{
            result: \(String(describing: result))
            msg: \(String(describing: msg))
        }
        """
    }
    
    
    required init?(map: Map){}
    init() {}
    
    func mapping(map: Map)
    {
        msg <- map["msg"]
        result <- map["result"]
    }
}




private func endpointMapping<Target: TargetType>(target: Target) -> Endpoint {
    
    print("请求连接：\(target.baseURL)\(target.path) \n方法：\(target.method)\n参数：\(String(describing: target.task)) ")
    return MoyaProvider.defaultEndpointMapping(for: target)
}

let MMProvider = MoyaProvider<API>(endpointClosure:endpointMapping, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

open class EDBaseAdapter:NSObject {
    
    class func  request(
        _ target:API,success successCallback: @escaping (Any) -> Void,
        error errorCallback: @escaping (Int,String ) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) {
        let provider = MoyaProvider<API>(endpointClosure:endpointMapping, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
        
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    let data = try response.mapJSON()
                    let statusCode = response.statusCode
                    //在我的项目里，200和201是请求成功。
                    if (statusCode == 201 || statusCode == 200) {
                        //解析登录数据
                        print("请求成功")
                        successCallback(data)
                    } else {
                        //请求报错提示，一般处理业务提示
                        print("请求出错了")
                        let dict = data
                        errorCallback(statusCode,(dict as AnyObject).object(forKey:"message") as! String)
                    }
                } catch {
                    //可不做处理
                }
                break
            case let .failure(error):
                print(error)
                failureCallback(error)
                break
            }
        }
    }
}
