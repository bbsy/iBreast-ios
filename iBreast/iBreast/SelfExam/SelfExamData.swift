//
//  SelfExamData.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamData: NSObject {
    
    
    var lesions=NSMutableOrderedSet()
    
    override init(){
        super.init();
        
        var cv0=LesionModel()
        lesions.addObject(cv0)
        
        var cv1=LesionModel()
        lesions.addObject(cv1)
        
        var cv2=LesionModel()
        lesions.addObject(cv2)
        
        
        
        cv0.id = 0
        cv0.size=30;
        cv0.firmness=LesionModel.SOFT
        cv0.highlight=true
        cv0.point.x=100
        cv0.point.y=140

        
        cv1.id = 1
        cv1.size=40;
        cv1.firmness=LesionModel.HARD
        cv1.highlight=false
        cv1.point.x=40
        cv1.point.y=60
        
        cv2.id = 2
        cv2.size=50;
        cv2.firmness=LesionModel.MEDIUM
        cv2.highlight=false
        cv2.point.x=69
        cv2.point.y=40
        
    }
    
    
    func getLesions()->NSMutableOrderedSet{
        
        return lesions
    }
    
    
    
    
   
}
