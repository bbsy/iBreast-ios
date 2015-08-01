//
//  RiskCalcHttp.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/8/1.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class RiskCalcHttp: NSObject {

    
   
    
    
    func wrapFamilyInfo(mHarvardCheckModel:HarvardCheckModel){
        
         var familyInfos=mHarvardCheckModel.familyInfos
        
         var familyDic = NSMutableArray()
        
        for member in familyInfos {
            
            
           var item  = NSMutableDictionary()
            
            var family = NSMutableDictionary()
            
            var cancers = NSMutableArray()
            for  i in 0...member._cancerName!.count-1{
                var cancerAndAge = NSMutableDictionary()
                
                var c = member._cancerName![i]
                var age = member._age![i]
                
                cancerAndAge.setObject(c, forKey:"cancer" )
                cancerAndAge.setObject(age, forKey:"age" )
                
                cancers.addObject(cancerAndAge)
            }
            
            item.setObject(cancers, forKey: "cancers")
            item.setObject(member._bloodline, forKey: "bloodline")
            item.setObject(member._relationship, forKey: "relationship")
            
           

            
            familyDic.addObject(item)
            
         }
        
        arrayo2JSONString(familyDic)
    }
    
    func toJSONString(dict:NSDictionary!)->NSString{
        
        var error:NSError
        var data = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted, error:nil)
        var strJson=NSString(data: data!, encoding: NSUTF8StringEncoding)
        return strJson!
        
    }
    
    func arrayo2JSONString(array:NSMutableArray!)->NSString{
        
        var data = NSJSONSerialization.dataWithJSONObject(array, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        var strJson=NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        println(strJson)
        return strJson!
        
    }

    
}
