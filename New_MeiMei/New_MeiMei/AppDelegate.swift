//
//  AppDelegate.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import NIMAVChat

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    static let `default` = UIApplication.shared.delegate as! AppDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.initWindow()
        initNIM()
        return true
    }
    
    private func initWindow() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        self.setRootVC()
    }
    
    public func setRootVC() {
        //判断是否登录，未登录进入登录页面
        if UserInfo.default.isLogin  == true{
            initNIM()
            self.window?.rootViewController = ViewController()
            self.window?.makeKeyAndVisible()
        } else {
            let nv = NavigationController.init(rootViewController: NoLoginVC())
            self.window?.rootViewController = nv
            self.window?.makeKeyAndVisible()
        }
    }
    
    func initNIM(){
            let option = NIMSDKOption(appKey: GlobalConst.nimAppKey)
            NIMSDK.shared().register(with: option)
            NIMCustomObject.registerCustomDecoder(NTESCustomAttachmentDecoder())
            NIMSDK.shared().register(withAppID: GlobalConst.nimAppKey, cerName: GlobalConst.pushcer)
        
            let loginData = NIMAutoLoginData()
            loginData.account = UserInfo.default.accid
            loginData.token = UserInfo.default.imtoken
        
        
            NIMSDK.shared().loginManager.login(loginData.account, token: loginData.token) { (error) in
                guard let recentAryy = NIMSDK.shared().conversationManager.allRecentSessions() else{return}
                var number = 0
                for recent in recentAryy{
                    number += recent.unreadCount
                }
                UIApplication.shared.applicationIconBadgeNumber = number
            }
        
        
            
            let server = NIMServerSetting()
            server.httpsEnabled = false
            NIMSDK.shared().serverSetting = server
            
            NIMSDKConfig.shared().enabledHttpsForInfo = false
            
            NIMAVChatSDK.shared().netCallManager.add(self)
            NIMSDK.shared().chatManager.add(self)
            NIMSDK.shared().userManager.userInfo(UserInfo.default.accid)
            NIMSDK.shared().userManager.fetchUserInfos(["100034","100041"]) { (user, error) in }
    }
    
}


extension AppDelegate : NIMNetCallManagerDelegate,NIMChatManagerDelegate{
    func onReceive(_ callID: UInt64, from caller: String, type: NIMNetCallMediaType, message extendMessage: String?) {
        if UserInfo.default.systemVibrate {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
//        AppNavHelper.gotoMessageMediaVCByCall(callID, extendMessage ?? "",type)
        
    }
    
    func onRecvMessages(_ messages: [NIMMessage]) {
        if UserInfo.default.systemVibrate {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        guard let recentAryy = NIMSDK.shared().conversationManager.allRecentSessions() else{return}
        var number = 0
        for recent in recentAryy{
            number += recent.unreadCount
        }
        NotificationCenter.default.post(name: NSNotification.Name("acceptMessage"), object: nil,userInfo: nil)
        
        UIApplication.shared.applicationIconBadgeNumber = number
    }
    
}





