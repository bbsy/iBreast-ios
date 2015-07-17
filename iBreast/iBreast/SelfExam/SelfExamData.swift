//
//  SelfExamData.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamData: NSObject {
    
    
    var lesions=[LesionView]()
    
    override init(){
        super.init();
        
        var cv0=LesionView()
        lesions.append(cv0)
        
        var cv1=LesionView()
        lesions.append(cv1)
        
        var cv2=LesionView()
        lesions.append(cv2)
        
        
        lesions[0].lesion.size=30;
        lesions[0].lesion.firmness=LesionFirmness.SOFT
        lesions[0].lesion.highlight=true
        
        lesions[1].lesion.size=40;
        lesions[1].lesion.firmness=LesionFirmness.HARD
        lesions[1].lesion.highlight=false
        
        lesions[0].lesion.size=10;
        lesions[0].lesion.firmness=LesionFirmness.MEDIUM
        lesions[0].lesion.highlight=false
        
    }
    
    
    func getLesions()->[LesionView]{
        
        return lesions
    }
    
    
    
    
   
}
