//
//  HttpObject.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/19.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation
import Alamofire

class HttpObject{
    
    var currentPage = 0
    
    var objects = NSMutableOrderedSet()
    
    var objMapper:HttpObjectMapper!
    
    var mapKey = "productlist"
    
    var isPopulating = false
    
    
    func fetch(key:String){
        
        if key != Constant.EMPTY_STRING{
            mapKey = key
        }
        
      
        
        
        Alamofire.request(URLRouter.Router.PopularPhotos(self.currentPage)).responseJSON(){
            _,_, JSON,error in
            
            if error==nil{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
                    ){
                        
                        let lastItem=self.objects.count
                        
                        
                        let infos=JSON!.valueForKey(self.mapKey) as! [NSDictionary]
                        
                        
                        
                        for item in infos{
                    
                           self.objects.addObject(self.objMapper.objectMap(item)!)
                    

                        }
//                        
//                        let indexPaths=(lastItem..<self.users.count).map{(NSIndexPath(forItem: $0, inSection: 0))}
//                        
//                        dispatch_async(dispatch_get_main_queue()){
//                      
//                            self.tableview.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
//                          
//                        }
                        
                        self.currentPage++
                }
            }
            self.isPopulating = false
        }
        
        
    }
    
}
