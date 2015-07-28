//
//  SelfExamData.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamData: NSObject {
    
    
    var lesions:NSMutableOrderedSet!
    
    var localLesions = NSMutableOrderedSet()
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
    var LESIONS_DATA_PATH:String = "\(Constant.LESIONS_DATA_PATH)"
    
    
    
    override init(){
        super.init();
        
       lesions = AppDataState.getInstance().getLesionList()
        
    }
    
    //在数据库中获取所有的lesion
    func getLesions(maxId:Int)->NSMutableOrderedSet{
        
        if(fetch(maxId) == false)
        {
            //setDefalutData()
        }
        return localLesions
    }
    //获取当前画板上所有的lesion
    func getLocalLesions()->NSMutableOrderedSet{
        return localLesions
    }
    
    func addLesion(model:LesionModel){
        
        lesions.addObject(model)
        
    }
    func removeLesion(model:LesionModel){
        lesions.removeObject(model)
    }
    func addLesions(models:[LesionModel]){
        lesions.addObjectsFromArray(models)
    }
    
    func removeLesions(models:[LesionModel]){
        lesions.removeObjectsInArray(models)
    }
    
    func setDefalutData(){
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
    
    func generateId()->Int{
        
        var max:Int = 0
        
        for item  in lesions{
            var model = item as! LesionModel
            if model.id > max {
                max = item.id
            }
            
        }
        return ++max
    }
    
    
    func save(){
        
        
        var path=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! NSString
        
        var filePath=path.stringByAppendingPathComponent("lesionsData.archive")
        if(userDefault.objectForKey(LESIONS_DATA_PATH) != nil){
            
            userDefault.removeObjectForKey(LESIONS_DATA_PATH)
        }
        for item in lesions {
            
            var l = item as! LesionModel
            println("id \(l.id) , didremove = \(l.didRemove)")
            
            (l).resetAddAndDelete()
        }
        var modelData:NSData = NSKeyedArchiver.archivedDataWithRootObject(lesions)
        userDefault.setObject(modelData, forKey: LESIONS_DATA_PATH)
        
        
        
    }

    
    func fetch(maxId:Int)->Bool{
        
        
        localLesions.removeAllObjects()
        lesions.removeAllObjects()
        
            var deModel = userDefault.objectForKey(LESIONS_DATA_PATH)
            
            if deModel != nil{
                var array:NSMutableOrderedSet = NSKeyedUnarchiver.unarchiveObjectWithData(deModel! as! NSData) as! NSMutableOrderedSet
                
                println("max id is \(maxId)")
              
                
                for item in array {
                    
                    if(item.id <= maxId){
                       self.localLesions.addObject(item as! LesionModel)
                    }
                    else {
                        println((item as! LesionModel).id)
                    }
                    lesions.addObject(item)
                    
                }
                
                return true
            }
            
            return false
            
        

    }
    
    
    
   
}
