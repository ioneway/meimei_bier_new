//
//  Location.swift
//  MeiMeiNew
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    
    static let `default` = Location()
    
    var latitude: String = "116.397128"
    var longitude: String = "39.916527"
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    //开始跟新地理坐标
    func startUpdateLocation(){
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//定位最佳
        locationManager.distanceFilter = 500.0//更新距离
        locationManager.requestWhenInUseAuthorization()
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.startUpdatingLocation()
            print("定位开始")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        NSLog("获取经纬度发生错误:\(String(describing: error))")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let thelocations:NSArray = locations as NSArray
        let location = thelocations.lastObject as! CLLocation
        latitude = "\(location.coordinate.latitude)"
        longitude = "\(location.coordinate.longitude)"
    }
    
    deinit {
        locationManager.startUpdatingHeading()
    }
}
