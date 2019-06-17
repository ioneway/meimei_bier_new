//
//  UIButton+Timer.swift
//  LLButton
//
//  Created by admin on 2019/6/2.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    typealias TimerCallBack = (_ btn: UIButton?, _ timeout: NSInteger) -> Void
    
    struct TimerKey {
        static let timingKey = UnsafeRawPointer.init(bitPattern: "timingKey".hashValue)
        static let endTimeKey = UnsafeRawPointer.init(bitPattern: "endTimeKey".hashValue)
        static let startTimeKey = UnsafeRawPointer.init(bitPattern: "startTimeKey".hashValue)
        static let countTimeKey = UnsafeRawPointer.init(bitPattern: "countTimeKey".hashValue)
    }
    
    var timing:  TimerCallBack? {
        set {
            objc_setAssociatedObject(self, TimerKey.timingKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            if let rs = objc_getAssociatedObject(self, TimerKey.timingKey!) as?  TimerCallBack{
                return rs
            }
            return nil
        }
    }
    
    var endTime:  TimerCallBack? {
        set {
            objc_setAssociatedObject(self, TimerKey.endTimeKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            if let rs = objc_getAssociatedObject(self, TimerKey.endTimeKey!) as?  TimerCallBack{
                return rs
            }
            return nil
        }
    }
    
    var startTime:  TimerCallBack? {
        set {
            objc_setAssociatedObject(self, TimerKey.startTimeKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            if let rs = objc_getAssociatedObject(self, TimerKey.startTimeKey!) as?  TimerCallBack{
                return rs
            }
            return nil
        }
    }
    
    var countTime: Int {
        set {
            objc_setAssociatedObject(self, TimerKey.countTimeKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            if let rs = objc_getAssociatedObject(self, TimerKey.countTimeKey!) as?  Int{
                return rs
            }
            return 60
        }
    }
    
    func fire() {
        let title = self.titleLabel?.text
        let color = self.titleLabel?.textColor
        
        let queue = DispatchQueue.global()
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        
        timer.schedule(deadline: .now(), repeating: 1.0, leeway: .seconds(countTime))
        var timeOut = countTime
        timer.setEventHandler(handler: { [weak self] in
            
            DispatchQueue.main.async {
                if let startTime = self?.startTime, timeOut == self?.countTime{
                    startTime(self, timeOut)
                }
                
                if timeOut <= 0 {
                    timer.cancel()
                    if let endTime = self?.endTime {
                        endTime(self, timeOut)
                    }
                    self?.isUserInteractionEnabled = true
                    self?.setTitle(title, for: .normal)
                    self?.setTitleColor(color, for: .normal)
                }else {
                    if let timing = self?.timing {
                        timing(self, timeOut)
                        self?.isUserInteractionEnabled = false
                    }
                }
                
                timeOut = timeOut - 1
            }
        })
        //启动 dispatch source
        timer.resume()
        
    }
}
