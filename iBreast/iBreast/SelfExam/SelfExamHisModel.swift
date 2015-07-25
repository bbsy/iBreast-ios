//
//  SelfExamHisModel.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamHisModel: NSObject {
    
    
    static let DELETE:Int = 0
    static let ADD:Int = 1
    
    var id:Int!
    //产生记录的时间
    var time:NSDate!
    
    var imageUrl:String!
    
    var title:String!
    
    var detail:String!
    
    var action:Int! = ADD
    //该记录中最大的一个id
  
    var lastId:Int = 0
    
    //该次编辑被删除或者增加的id
    var ids:[Int]?
    
    init(lastId:Int,action:Int,time:NSDate,imageUrl:String,title:String,detail:String,ids:[Int]?) {
        
        self.lastId = lastId
        self.action = action
        self.time = time
        self.imageUrl=imageUrl
        self.title=title
        self.detail=detail
        self.ids = ids
    }
    
    
   
}
