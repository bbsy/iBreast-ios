//
//  UserManager.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import CoreData


var user:User!

class UserManager: NSObject {
    
    
    typealias U = User
  
    
    class func getUser()->AnyObject?{
    
        if let u = user {
            return user
        }
        else
        {
            if var obj = fetch() {
                
                user = obj as! User
                
                return user
            }
        }
        
        return nil
    
    }
    
    
    
   
    
    func save(){
        
        var u:U
    
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context = app.managedObjectContext
    
        var error:NSError?
    
        var oneUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context!) as! User
    
    
        oneUser.id=10
        oneUser.name="kity"
    
        var rel = !(context?.save(&error) != nil)
        
        if(rel){
            println("不能保存：\(error?.localizedDescription)")
        }
        else{
            println("保存成功")
        }
    
        
    
    
    
       
    }

    class func fetch()->AnyObject?{
    
        var u:User?
        
    
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
        let context = app.managedObjectContext
    
        var error:NSError?
    
        var fetchRequest:NSFetchRequest=NSFetchRequest()
        
        fetchRequest.fetchLimit=10
        fetchRequest.fetchOffset=0
        
        
        var entity:NSEntityDescription? = NSEntityDescription.entityForName("User", inManagedObjectContext: context!)
        
        fetchRequest.entity=entity
        
//        let predicate = NSPredicate(format: "id = '10'"," ")
//        
//        fetchRequest.predicate=predicate
        
        var fetchedObject:[AnyObject]? = context?.executeFetchRequest(fetchRequest, error: &error)
        
        if(fetchedObject == nil){
            
            return nil
        }
       
        
        for info:User in fetchedObject as! [User] {
            
            println("user id = \(info.id)")
            println("user name = \(info.name)")
            
           return info
        }
        
        return nil
        
        
       
        
    }

}
