//
//  ClinicsHistoryModel.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/7.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class ClinicsHistoryModel: NSObject {
    
    
    var id:String?
    var date:NSDate?
    var image:String?
    var title:String?
    var detail:String?
    
    init(id:String,date:NSDate,image:String,title:String,detail:String){
        
        self.id=id
        self.date=date
        self.image=image
        self.title=title
        self.detail=detail
        
    }


}
