//
//  UserDefaults.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/15.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class UserDefaults: NSObject {
    
    let SELF_EXAM_DATE="SELF_EXAM_DATE"
    
    static let instance:UserDefaults=UserDefaults()
    
    
    var userDefaults:NSUserDefaults=NSUserDefaults.standardUserDefaults()
    
  
    
    class func getInstance()->UserDefaults{
        
        return instance
    }
    
    
    func setSelfExamDate(date:NSDate ){
    
        userDefaults.setObject( date, forKey: SELF_EXAM_DATE)
        
    }
    
    func getSelfExamDate()->NSDate{
        
        var time:NSDate?
        
        var dic = userDefaults.dictionaryRepresentation()
        
        if userDefaults.objectForKey(SELF_EXAM_DATE) != nil
        {
            var obj:AnyObject? = dic[SELF_EXAM_DATE]
            if let date:AnyObject! = obj {
                return date as! NSDate
            }
        }

        return time!
        
        
    }
   
}
