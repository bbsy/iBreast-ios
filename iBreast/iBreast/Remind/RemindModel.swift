//
//  RemindModel.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/20.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

var remindModel = RemindModel()

class RemindModel: NSObject {
    
    
    var lastPeriodFrom:NSDate!
    
    var lastPeriodTo:NSDate!
    
    var menopauseStatus:MenopauseStatus!
    
    var suggestedExamlDate:NSDate!
    
    var everyMonthSuggestDate:NSDate!
    
    var needNotify:Bool!
    

}
