//
//  DeviceInfo.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/29.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class DeviceInfo{
    
    let  LAST_RUN_VERSION_KEY = "last_run_version_of_application"
    
    class func getDeviceSize()->CGRect{
        var frameRect = UIApplication.sharedApplication().statusBarFrame
        
        var rect = UIScreen.mainScreen().bounds;
        var size = rect.size;
        var width = size.width;
        var height = size.height;
        
        return rect
    }
    
    class func isFirstLoad()->Bool{
        
//        
//        let infoDictionary = NSBundle.mainBundle().infoDictionary
//        let dir = infoDictionary
//        
//        let appDisplayName:AnyObject? = infoDictionary["CFBundleDisplayName"]
//        let majorVersion :AnyObject? = infoDictionary ["CFBundleShortVersionString"]
//        let minorVersion :AnyObject? = infoDictionary ["CFBundleVersion"]
//        let appversion = majorVersionasString
//        let iosversion:NSString= UIDevice.currentDevice().systemVersion //ios版本
//        let identifierNumber = UIDevice.currentDevice().identifierForVendor //设备udid
//        let systemName = UIDevice.currentDevice().systemName //设备名称
//        let model = UIDevice.currentDevice().model //设备型号
//        let localizedModel = UIDevice.currentDevice().localizedModel //设备区域化型号如A1533
//        println(appversion)
        
        return true
    }
    
    
}