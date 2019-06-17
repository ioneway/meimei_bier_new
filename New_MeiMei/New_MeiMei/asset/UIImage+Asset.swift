//
//  UIImage.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

typealias ImageAsset = UIImage.Asset

extension UIImage {
    public enum Asset: String {
        case lunch_bg
        case logo
        case login_bg
        case phon_login
        case pwd_login
        case nv_back
        case ic_tab_message
        case ic_tab_mine
        case ic_tab_qiuliao
        case ic_tab_talkPlace
        case ic_tab_waitChat
        case ic_gender_w
        case ic_location
        case ic_hi
        case ic_hi_select
        case ic_liao
        case ic_liao_select
        case scroll_bg
        case ic_banner_dot
        case ic_banner_dot_sel
        case nodate
        case ic_video
        case segment_sel
        case segment_normal
        case message_system
        case ic_mine_go
        
        
        var value: UIImage? {
            return UIImage.init(named: self.rawValue)
        }
    }
}
