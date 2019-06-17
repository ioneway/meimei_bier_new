//
//  App.swift
//  SwiftRichString-iOS
//
//  Created by 王伟 on 2018/8/11.
//  Copyright © 2018年 SwiftRichString. All rights reserved.
//

import Foundation
import UIKit
import AdSupport
import CoreTelephony

public struct App {
    
    public static var userPath: String {
        return  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    public static var KeyStorePath: String {
        return  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/keystore"
    }
    
    public static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    public static var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public static var sysVersion: String {
        return UIDevice.current.systemVersion
    }

    public static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    public static var bundleID: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    public static var bundleName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    public static var appStoreURL: URL {
        assert(false)
        return URL(string: "your URL")!
    }
    
    public static var imsi: (providerName:String, imsi:String) {
        let info = CTTelephonyNetworkInfo()
        guard let carrier:CTCarrier = info.subscriberCellularProvider else { return ("", "") }
        
        let mcc = carrier.mobileCountryCode ?? ""
        let mnc = carrier.mobileNetworkCode ?? ""
        let imsi = mcc + mnc
        
        var text = mnc
        
        if mnc == "00" || mnc == "02" || mnc == "07" {
            text = "中国移动"
        }else if mnc == "01" || mnc == "06" || mnc == "09" {
            text = "中国联通"
        }else if mnc == "03" || mnc == "05" || mnc == "11" {
            text = "中国电信"
        }
        
        return (text,imsi)
        
    }
    
    public static var appVersionAndBuild: String {
        let version = appVersion, build = appBuild
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
    
   
    
    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    public static var deviceName: String {
        return UIDevice.current.name
    }
    
    
    /// 设备唯一标识符，写入keyChain
    public static var UUID: String {
        get {
            func generateUUID() -> String {
                let myUUID:CFUUID = CFUUIDCreate(nil)
                let UUIDString:CFString = CFUUIDCreateString(nil, myUUID)
                let resultString:String = CFStringCreateCopy(nil, UUIDString) as String
                return resultString
            }
            let uuidstr = generateUUID()
            return uuidstr
        }
    }
    
    /// 代理，主要用于请求头信息
    public static var Agent: String {
        if let info = Bundle.main.infoDictionary {
            let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
            let bundle = info[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
            let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
            let appBuild = info[kCFBundleVersionKey as String] as? String ?? "Unknown"
            
            let osNameVersion: String = {
                let version = ProcessInfo.processInfo.operatingSystemVersion
                let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
                
                let osName: String = "iOS"
                
                return "\(osName) \(versionString)"
            }()
            
            return "\(executable)/\(appVersion) (\(bundle); build:\(appBuild); \(osNameVersion))"
        }
        
        return App.bundleID
    }
    
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    public static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    //    public static var screenHeightWithoutStatusBar: CGFloat {
    //        if UIInterfaceOrientationIsPortrait(screenOrientation) {
    //            return UIScreen.main.bounds.size.height - screenStatusBarHeight
    //        } else {
    //            return UIScreen.main.bounds.size.width - screenStatusBarHeight
    //        }
    //    }
    
    /// ip地址
    public static var ipAddress: String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            
            let interface = ifptr.pointee
            
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    
                    var addr = interface.ifa_addr.pointee
                    var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostName)
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return address
    }
    
    /// 打开邮箱
   static public func launchMail(address:String) {
        
        let str = "mailto:" + address
        let email = str.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.alphanumerics)
        UIApplication.shared.open(URL.init(string: email ?? "")! , options: [:], completionHandler: nil)
    }
}

