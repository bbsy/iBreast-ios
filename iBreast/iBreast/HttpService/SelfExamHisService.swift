//
//  SelfExamHisService.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/19.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamHisService: HttpObjectMapper,HttpCallBack{
    
    
    
    
    func objectMap(data:AnyObject)->AnyObject?{
        
        var obj = data as! NSDictionary
        
        var time = NSDate()
        
        
    
        var model = SelfExamHisModel( time: time, imageUrl: obj.valueForKey("imageUrl") as! String, title: obj.valueForKey("name") as! String, detail: obj.valueForKey("password") as! String)
        
        println(model.imageUrl)
        
        return model
    }
    
    func callback(result:AnyObject){
        println("\(result)")
    }
}
