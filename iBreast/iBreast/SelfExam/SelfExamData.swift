//
//  SelfExamData.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
var  maxId:Int  = -Int.max

let _SelfExamDataInstance = SelfExamData()

class SelfExamData: NSObject {
    
    //保存着用户产生的所有lesion(包括没在画板上显示的内容)
    var lesions:NSMutableOrderedSet!
    
    //画板上所有能看到的lesion都存储到了这个set中
    var localLesions = NSMutableOrderedSet()
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
    var LESIONS_DATA_PATH:String = "\(Constant.LESIONS_DATA_PATH)"
 
    
    let dbManager = DBManager.defaultDBManager().dataBase;
    
    let tableName = "selfExamLesionsTable"
    
    
    
    override init(){
        super.init();
        
       lesions = AppDataState.getInstance().getLesionList()
        
        createTable()
        
        getMaxId()
     
    }
    
    
    class var sharedInstance : SelfExamData {
        
        return _SelfExamDataInstance
    }
    
    
    

    
    //在数据库中获取所有的lesion
    func getLesions(maxId:Int,historyModel:SelfExamHisModel?)->NSMutableOrderedSet{
        
        //if(fetch(maxId) == false)
        
        //
        if(historyModel != nil){
            selectedAll(maxId,all: historyModel!.idsForAll)
        }
        else{
            selectedAll(maxId,all:nil)
        }
        return localLesions
    }
    //获取当前画板上所有的lesion
    func getLocalLesions()->NSMutableOrderedSet{
        return localLesions
    }
    
    func addLesion(model:LesionModel){
        
        lesions.addObject(model)
        //addLesionToDB(model)
        
    }
    func removeLesion(model:LesionModel){
        lesions.removeObject(model)
    }
    
    func getCurrentLesions()->NSMutableOrderedSet{
        return lesions
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
        
//        var max:Int = 0
//        
//        for item  in lesions{
//            var model = item as! LesionModel
//            if model.id > max {
//                max = item.id
//            }
//            
//        }
//        return ++max
        
        if(maxId < 0)
        {
            maxId = getMaxId()
        }
       
        maxId = maxId + 1
        
        return maxId
    }
    
    
    func save(){
        
        saveAll()
        
//        
//        var path=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! NSString
//        
//        var filePath=path.stringByAppendingPathComponent("lesionsData.archive")
//        if(userDefault.objectForKey(LESIONS_DATA_PATH) != nil){
//            
//            userDefault.removeObjectForKey(LESIONS_DATA_PATH)
//        }
//        for item in lesions {
//            
//            var l = item as! LesionModel
//            println("id \(l.id) , didremove = \(l.didRemove)")
//            
//            (l).resetAddAndDelete()
//        }
//        var modelData:NSData = NSKeyedArchiver.archivedDataWithRootObject(lesions)
//        userDefault.setObject(modelData, forKey: LESIONS_DATA_PATH)
        
      
        
        
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

extension SelfExamData{
    
    private func createTable() -> Bool {
        
        var result:FMResultSet = dbManager.executeQuery("select count(*) from sqlite_master where type = 'table' and name = '\(tableName)' ", withArgumentsInArray: nil)
        if result.next() {
            var count = result.intForColumnIndex(0)
            
            var exist = count > 0 ?true :false
            
            if exist {
                println("表： \(tableName) 已经存在")
            }else{
                var sql:String = "create table \(tableName) (id integer primary key autoincrement not null, _id inteter,highlight integer,time varchar(50), firmness integer, size integer,  pointx integer, pointy integer, allowedMoving integer, didRemove integer )"
                
                //                var sql:String = "create table \(tableName) (id integer primary key autoincrement not null, _id inteter, _title nvarchar(20),_detail text , _age integer ,_time nvarchar(20))"
                
                println(sql)
                
                var res = dbManager.executeUpdate(sql, withArgumentsInArray: nil)
                if res {
                    println("创建成功")
                }else{
                    println("创建失败")
                    println("sql:\(sql)")
                }
            }
        }
        return true
    }
    
    func addLesionToDB(model:LesionModel) -> Bool{
        
        //  optional value
        var insertSql = "insert into \(tableName) "
        var keys = "("
        var values = " values ("
        //  当我们判断不为空的时候 强制拆包就可以了
        //if (model.id ! = nil) {
            keys += " _id,"
            values += "\(model.id),"
       // }
        if (model.highlight == true) {
            keys += " highlight,"
            values += "1,"
        }
        else{
            keys += " highlight,"
            values += "0,"
        }
        
        
        
        
        if (model.time != nil) {
            keys += " time,"
            values += "'\(model.time)',"
        }
        
        
        
        //if (model.firmness != nil) {
            keys += " firmness,"
            values += "'\(model.firmness )',"
       // }
        
       // if (model.action != nil) {
            keys += " size,"
            values += "\(model.size),"
       // }
        
       // if (model.time != nil) {
            keys += " pointx,"
            values += "'\(model.point.x)',"
       // }

        keys += " pointy,"
        values += "'\(model.point.y)',"
        
        println("pointx: \(model.point.x) ,pointy:\(model.point.y)")
        
//        if (model.allowedMoving == true)
//        {
//            keys += " allowedMoving,"
//            values += "1,"
//        }
//        else{
//            keys += " allowedMoving,"
//            values += "0,"
//        }
        
        if (model.didRemove == true)
        {
            keys += " didRemove,"
            values += "1,"
        }
        else{
            keys += " didRemove,"
            values += "0,"
        }
        
    
        
        
        keys += ")"
        values += ")"
        
        // 有时候我们需要循环遍历参数，因此，通常我们需要处理一下尾部多余的字符 当然处理方式有很多 这只是一个参考
        
        
        var keysRange = keys.rangeOfString(",)", options: NSStringCompareOptions.BackwardsSearch, range: Range(start: keys.startIndex, end: keys.endIndex), locale: NSLocale.autoupdatingCurrentLocale())
        
        if (keysRange != nil) {
            keys.replaceRange(keysRange!, with: ")")
        }
        var valuesRange = values.rangeOfString(",)", options: NSStringCompareOptions.BackwardsSearch, range: Range(start: values.startIndex,end: values.endIndex))
        
        if (valuesRange != nil) {
            values.replaceRange(valuesRange!, with: ")")
        }
        
        insertSql += keys + values
        
        println("keys \(keys)")
        println(insertSql)
        println(keysRange)
        println(valuesRange)
        
        
        
       var res = dbManager.executeUpdate(insertSql, withArgumentsInArray: nil)
            
        
        
        
        //  */
        
        println("res = \(res)")
        return res;
        
    }
    func saveAll(){
        
        var alreadMaxId = getMaxId()
        for item in lesions{
            
            
            
            
            var l = item as! LesionModel
            l.resetAddAndDelete()
            //有两种情况是要修改数据库的
            //第一种情况，增加了新的硬块
            if(l.id > alreadMaxId)
            {
                addLesionToDB(l)
            }//删除了硬块
            else if(l.didRemove == true){
                updateRemoveState(l)
            }
        }
        
    }

//    func deleteUser(user:User) ->Bool{
//        
//        var sql = "delete from \(tableName) where name = '\(user.name!)'"
//        var res = dbManager.executeUpdate(sql, withArgumentsInArray: nil)
//        
//        return res;
//    }
//    
    
    
    func updateRemoveState(model:LesionModel)-> Bool {
        
        var sql = "update \(tableName) set "
        var keyVlaues = String()
        
        var didRemove:Int = 0
        
        if(model.didRemove == true){
            didRemove = 1
        }
        else{
            didRemove = 0
        }
        keyVlaues += " didRemove =\(didRemove)"
        
        
        sql += keyVlaues
        
        sql += " where _id = \(model.id)"
        
        var res = dbManager.executeUpdate(sql, withArgumentsInArray: nil)
        
        println("update state : \(res)")
        
        return res;
    }

    
    func selectedAll(maxId:Int,all:[Int]?) ->Bool{
        
        localLesions.removeAllObjects()
        lesions.removeAllObjects()
        
        
        var sql:String = "select * from \(tableName) where id <= \(maxId)"
        
        var res:FMResultSet = dbManager.executeQuery(sql, withArgumentsInArray: nil)
        
        var array:[LesionModel] = []
        
        while (res.next()) {
            
            
            
            var model = LesionModel()

            var id = Int(res.intForColumn("_id"))
            var time = res.stringForColumn("time") as! String
            var size = res.intForColumn("size")
            var firmness = res.intForColumn("firmness")
            var highlight = res.boolForColumn("highlight")
            var pointx = res.intForColumn("pointx")
            var pointy = res.intForColumn("pointy")
            var point:CGPoint = CGPoint()
            point.x = CGFloat(pointx)
            point.y = CGFloat(pointy)
            var move = res.intForColumn("allowedMoving")
            var allowedMoving:Bool!
            if(move == 1){
                allowedMoving = true
            }
            else{
                allowedMoving = false
            }
            var didRemove:Bool!
            var remove = res.intForColumn("didRemove")
            if(remove == 1){
                didRemove = true
            }
            else{
                didRemove = false
            }
            
            model.id = id
            model.time = NSDate()
            model.highlight = highlight
            model.size = CGFloat(size)
            model.firmness = Int(firmness)
            model.point = point
            model.didRemove = didRemove
          //  model.allowedMoving = allowedMoving
            
            
            println("lesion: id:\( model.id), time:\(time) ,hightlight:\(model.highlight ),size:\(model.size ),firmness:\(model.firmness),point:\(model.point),didremove:\(model.didRemove)")
            
            if(all != nil && !all!.isEmpty){
                var find = false
                for i in 0...all!.count-1 {
                    if(all![i] == model.id){
                        find = true
                        break
                    }
                }
                
                if(find == true){
                    self.localLesions.addObject(model)
                    
                    lesions.addObject(model)
                }
                
            }
            else{
                self.localLesions.addObject(model)
                
                lesions.addObject(model)
            }
           
        }
        
        if(lesions.count == 0){
            return false
        }
        else{
          return true;
        }
        
    }
    

    func getMaxId()->Int{
        
        
        
        var maxId:Int! = 0
        var sql:String = "select [_id] from \(tableName)"
        var res:FMResultSet = dbManager.executeQuery(sql, withArgumentsInArray: nil)
        while (res.next()) {
            
            var id = Int(res.intForColumn("_id"))
            
            if(id > maxId){
                maxId = id
            }
            println("_ID: \(id)")
            
        }
        
        return maxId

    }
    
    
    
}
