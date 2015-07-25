//
//  AppDataState.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/24.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class AppDataState: NSObject {

    static var instance: AppDataState!
    
    var selfExamHisList:[SelfExamHisModel]!
    var lesions=NSMutableOrderedSet()
    
    class func getInstance()->AppDataState!{
        
        if(instance == nil){
            instance = AppDataState()
        }
        return instance
    }
    
    
    func getSelfExamHisList()->[SelfExamHisModel]{
        if(selfExamHisList == nil || selfExamHisList.isEmpty){
            selfExamHisList = [SelfExamHisModel]()
        }
        return selfExamHisList
    }
    
    func getLesionList()->NSMutableOrderedSet{
        
        return lesions
    }
    
    
    
    
    
    

}
