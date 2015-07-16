//
//  SelfExamData.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamData: NSObject {
    
    
    var lesions=[CircleView]()
    
    override init(){
        super.init();
        
        var cv0=CircleView()
        lesions.append(cv0)
        
        var cv1=CircleView()
        lesions.append(cv1)
        
        var cv2=CircleView()
        lesions.append(cv2)
        
        
        lesions[0].size=30;
        lesions[0].firmness=LesionFirmness.SOFT
        lesions[0].highlight=true
        
        lesions[1].size=40;
        lesions[1].firmness=LesionFirmness.HARD
        lesions[1].highlight=false
        
        lesions[0].size=10;
        lesions[0].firmness=LesionFirmness.MEDIUM
        lesions[0].highlight=false
        
    }
    
    
    func getLesions()->[CircleView]{
        
        return lesions
    }
    
    
    
    
   
}
