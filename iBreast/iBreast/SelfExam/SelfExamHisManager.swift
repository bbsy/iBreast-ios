//
//  SelfExamHisManager.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit



let _SingletonSharedInstance = SelfExamHisManager()

class SelfExamHisManager: NSObject {
    
    static let NUM_MAX = Int.max
    
    static let TITLE:String! = "Add New  Lesion"
    
    //表示一次检索最多返回10条数据
    static let PAGE_NUM = 10
    
    
    //缓存最后一次检索的数据
    var historyList:[SelfExamHisModel]!;
    
    var userName:String!
    
    var lesions:NSMutableOrderedSet!
    
    var localLesions = NSMutableOrderedSet()
    
    
    let dbManager = DBManager.defaultDBManager().dataBase;
    
    let tableName = "selfExamHisTable"
    
    
    override init(){
        
        super.init()
        
        createTable()
        
        initData()
        
       
        
    }
    
    class var sharedInstance : SelfExamHisManager {
        
        return _SingletonSharedInstance
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
        
        historyList = AppDataState.getInstance().getSelfExamHisList()
        
        
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
        
//        for var i = 0 ;i<num;++i {
//            
//            var model=SelfExamHisModel(lastId:100,action:1,time: NSDate(), imageUrl: "empty", title: "title\(offset+i)", detail: "detail\(offset+i)")
//            
//            historyList.append(model)
//            
//        }
        
        historyList.removeAll(keepCapacity: false)
        
        selectedAll()
        
        return historyList
    }
    
    
    /**
    * 返回数据库中记录的总个数
    **/
    
    func getNumOfHistoryRecord()->Int{
        
        return 100
    }
    
    func addHistory(lesions:[LesionModel],maxId:Int){
    
        if(lesions.isEmpty){
            
            return
        }
        
        var title:String!
        var action:Int = SelfExamHisModel.DELETE
        var lesion:LesionModel!
        
       
        var his:SelfExamHisModel?
        var addIds:[Int] = [Int]()
        var delIds:[Int] = [Int]()
        
//        /**
//        *找到id最大的lesion
//        **/
//        var maxId = -Int.max
//        var index:Int = 0
//        var cusor = 0
//        for item in lesions {
//          
//            if(item.id > maxId){
//                
//                maxId = item.id
//                index = cusor
//            }
//            ++cusor
//        }
//        lesion = lesions[index]
        
        for item in lesions {
            
            if(item.didAdd == true){
                addIds.append(item.id)
            }
            else if(item.didDelete == true){
                delIds.append(item.id)
            }
        }
        
        if(addIds.isEmpty && delIds.isEmpty){
            return
        }
        
        if(!addIds.isEmpty && !delIds.isEmpty){
            title = "增加，减少硬块"
            his=SelfExamHisModel(lastId: maxId,action:action,time: NSDate(), imageUrl: "empty", title: title, detail:"复杂的心情",addIds: addIds,deleteIds:delIds)
        }
        else if(!addIds.isEmpty && delIds.isEmpty){
            title = "增加硬块"
            his=SelfExamHisModel(lastId: maxId,action:action,time: NSDate(), imageUrl: "empty", title: title, detail:"伤心",addIds:addIds,deleteIds:nil)
        }
        else if(addIds.isEmpty && !delIds.isEmpty){
            title = "减少硬块"
            his=SelfExamHisModel(lastId: maxId,action:action,time: NSDate(), imageUrl: "empty", title: title, detail:"心情好",addIds: nil,deleteIds:delIds)
        }
        
            
        
        
        historyList.append(his!)
        
        addHistory(his!)
        
    }
    
    
    
    
    
    
   
}

extension SelfExamHisManager{
    
    private func createTable() -> Bool {
        
        var result:FMResultSet = dbManager.executeQuery("select count(*) from sqlite_master where type = 'table' and name = '\(tableName)' ", withArgumentsInArray: nil)
        if result.next() {
            var count = result.intForColumnIndex(0)
            
            var exist = count > 0 ?true :false
            
            if exist {
                println("表： \(tableName) 已经存在")
            }else{
                var sql:String = "create table \(tableName) (id integer primary key autoincrement not null, _id inteter,_title varchar(50),_detail varchar(50), _time varchar(50), _imageUrl varchar(50),  _action integer, _lastId integer, _idsForAdd blob, _idsForDelete blob )"
                
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
    
    func addHistory(model:SelfExamHisModel) -> Bool{
        
        // 三种种参数的传递方式
        // 拼接字符串 这是常用的方式 但是你的保证拼接的字符串是正确的
        // 特别是当你使用 \(paramName) 来拼接的时候 如果参数是 optional value （后面带有“？” 的变量）的时候 会得到你不想要的结果 你打印拼接后的 sql  就知道了 因此使用该方法的时候引用的变量需要加!
        
        //注意对一些特殊的数据的处理方式（主要是bool，date；这就是我把sex 定义成bool 的原因，date 大家就自己测试把，其实这和其他语言的sql处理方式是一样的） 因为sex 不为空因此我强制拆箱了
        /*
        // method 1
        var insertSql = "insert into \(tableName) (name,age,sex) values('\(user.name)',\(user.age),\(user.sex! ? 1 : 0)) "
        
        var res = dbManager.executeUpdate(insertSql, withArgumentsInArray: nil)
        
        */
        // 通过数组或者字典传递参数
        // 特别注意的是，通常我们使用的 sql 参数占位符（?）这里不能时候，通过查看FMDB 的源码可以知道 他们是通过 “: + 参数名称” 来定位你所传递的参数值应该插入的位置的
        /*
        // method 2
        var insertSql2 = "insert into userTable (name,age,sex) values(:name,:age,:sex) "
        
        var values = [user.name,user.age,user.sex]
        var res = dbManager.executeUpdate(insertSql2, withArgumentsInArray: values)
        */
        
        /*
        // method 3
        var insertSql = "insert into userTable (name,age,sex) values(:name,:age,:sex) "
        var values = Dictionary<String, NSObject>()
        values["name"] = user.name
        values["age"] = user.age
        values["sex"] = user.sex
        
        var res = dbManager.executeUpdate(insertSql, withParameterDictionary: values)
        // */
        
        ///*
        //  optional value
        var insertSql = "insert into \(tableName) "
        var keys = "("
        var values = " values ("
        //  当我们判断不为空的时候 强制拆包就可以了
        if (model.id != nil) {
            keys += " _id,"
            values += "\(model.id),"
        }
        if (model.title != nil) {
            keys += " _title,"
            values += "'\(model.title)',"
        }
        
        
        if (model.detail != nil) {
            keys += " _detail,"
            values += "'\(model.detail)',"
        }

        
        if (model.time != nil) {
            keys += " _time,"
            values += "'\(model.time)',"
        }
        
       
        
        if (model.imageUrl != nil) {
            keys += " _imageUrl,"
            values += "'\(model.imageUrl )',"
        }

        if (model.action != nil) {
            keys += " _action,"
            values += "\(model.action),"
        }
        
        if (model.lastId != -Int.max)
        {
            keys += " _lastId,"
            values += "\(model.lastId),"
        }
         var dataForAdd:NSData!
        if let idsForAdd = model.idsForAdd{
            dataForAdd = NSKeyedArchiver.archivedDataWithRootObject(idsForAdd)
            keys += " _idsForAdd,"
            values += "?,"

            
        }

        
       var dataForDel:NSData!
        
        if let idsFordel = model.idsForDelete{
            dataForDel = NSKeyedArchiver.archivedDataWithRootObject(idsFordel)
            keys += " _idsForDelete,"
            values += "?,"
            
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
        
        
        
        var res:Bool = false
            
        if(dataForAdd != nil && dataForDel != nil){
            
             res = dbManager.executeUpdate(insertSql, dataForAdd,dataForDel)
        }
        else if(dataForAdd == nil && dataForDel == nil){
            
            res = dbManager.executeUpdate(insertSql, withArgumentsInArray: nil)

        }
        else if(dataForAdd != nil && dataForDel == nil){
             res = dbManager.executeUpdate(insertSql, dataForAdd)
        }
        else if(dataForAdd==nil && dataForDel != nil){
             res = dbManager.executeUpdate(insertSql,dataForDel)
        }



            
           //  */
        
        println("res = \(res)")
        return res;
        
    }
    
    func selectedAll() ->[SelfExamHisModel] {
        
        var sql:String = "select * from \(tableName)"
        
        var res:FMResultSet = dbManager.executeQuery(sql, withArgumentsInArray: nil)
        
        var array:[SelfExamHisModel] = []
        
        while (res.next()) {
            
            
            
            //     查看OC 的方法可以知道 intForColumn 的返回值是 int 类型，（注意是小写的 int）我们都知道它会更具系统32或者64位的编译的时候自动确定是16位的int 类型呢还是32的int 类型，这和swift 的Int类型是一样的，但是当你调用oc方法的时候你可以发现，当你的系统是64位的时候 他的返回值 会变成 Int32 ，不能直接赋值，但是你也不能把变量定义成Int32的对吧，这样32位系统运行该程序就会报错 ，所以我们强制转换成Int 就好了（这只是一个例子了，其他oc int 来到swift 之后都可以这样处理）
            
            
//            var id = res.intForColumn("_id") as! Int
//           // model.time = res.stringForColumn("title") as! String
//            var detail = res.stringForColumn("detail")
//            var lastId = res.intForColumn("lastId") as! Int
//            
//            //array.append(model)
            var adds:[Int]!
            var dels:[Int]!
            var id = Int(res.intForColumn("id"))
            var title = res.stringForColumn("_title") as! String
            var detail = res.stringForColumn("_detail") as! String
            var action = Int(res.intForColumn("_action"))
            var lastId = Int(res.intForColumn("_lastId"))
            var imageUrl = res.stringForColumn("_imageUrl")
            var idsForAdd = res.dataForColumn("_idsForAdd")
            
            
           
                
            
            println("==============id: \(id) =================")
            
            if (idsForAdd != nil) {
                
                
                adds = NSKeyedUnarchiver.unarchiveObjectWithData(idsForAdd) as! [Int]
                
                for i in 0...adds.count-1{
                    println("adds: \(adds[i])")
                }
                
            }
            
            var idsForDel = res.dataForColumn("_idsForDelete")
            
            
            
            if (idsForDel != nil) {
                
                
                dels = NSKeyedUnarchiver.unarchiveObjectWithData(idsForDel) as! [Int]
                
                for i in 0...dels.count-1{
                    println("dels: \(dels[i])")
                }
                
            }
            
            var model:SelfExamHisModel = SelfExamHisModel(lastId: lastId, action: action, time: NSDate(), imageUrl: imageUrl, title: title, detail: detail, addIds:adds ,deleteIds: dels)

            
            
          //  var time =  res.stringForColumn("_time") as! String
            
            println("history: title:\(title), detail:\(detail) ,action:\(action), lastId:\(lastId)")
            
            historyList.append(model)
        }
        return array;
        
    }
    

}
