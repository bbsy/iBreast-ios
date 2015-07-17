//
//  SelfExamHisModel.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamHisModel: NSObject {
    
    
    var id:Int!
    
    var time:NSDate!
    
    var imageUrl:String!
    
    var title:String!
    
    var detail:String!
    
    init(time:NSDate,imageUrl:String,title:String,detail:String) {
        
        self.time = time
        self.imageUrl=imageUrl
        self.title=title
        self.detail=detail
        
    }
   
}
