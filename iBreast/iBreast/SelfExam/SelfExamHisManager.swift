//
//  SelfExamHisManager.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

 var instance:SelfExamHisManager!

class SelfExamHisManager: NSObject {
    
    static let NUM_MAX = Int.max
    
    //表示一次检索最多返回10条数据
    static let PAGE_NUM = 10
    
    
    //缓存最后一次检索的数据
    var historyList:[SelfExamHisModel]=[SelfExamHisModel]()
    
    var userName:String!
    
    override init(){
        
        
        
    }
    
    func initData(){
        
        var obj = UserManager.getUser()
        
        if(obj != nil){
            
            var user = obj as! User
            
            userName = user.name
            
        }
        else{
            userName = Constant.DEFAULT_USER_NAME
        }
        
    }
    
    
    class func getInstance()->SelfExamHisManager{
        
        if let ins = instance {
            return ins
        }
        else {
            instance = SelfExamHisManager()
            instance.initData()
          
        }
        
        return instance
    }
    
    func fetchHistoryRecord(offset:Int,num:Int)->AnyObject?{
        
        var _num = getNumOfHistoryRecord()
        
        
        var _offset = offset
        
        
        
        if num < _num-offset{
            
            fetchHisRecord(_offset,num: num)
        
        }
        else {
            fetchHisRecord(_offset,num: _num - _offset)
        }
        
        
        
        
        return nil
        
    }
    
    /**
    * 从数据库中获取数据
    **/
    
    func fetchHisRecord(offset:Int,num:Int)->AnyObject?{
        
        for var i = 0 ;i<num;++i {
            
            var model=SelfExamHisModel(time: NSDate(), imageUrl: "empty", title: "title\(offset+i)", detail: "detail\(offset+i)")
            
            historyList.append(model)
            
        }
        
        return historyList
    }
    
    /**
    * 返回数据库中记录的总个数
    **/
    
    func getNumOfHistoryRecord()->Int{
        
        return 100
    }
    
    
   
}
