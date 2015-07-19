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
    
    var httpRequest:HttpRequest!
    
    var isPopulating = false
 
    
 
    
    func fetch(httpRequest:HttpRequest){
        
      
        self.httpRequest = httpRequest
      
        if(self.isPopulating){
            if(self.httpRequest.callback != nil){
                self.httpRequest.callback.callback("request stop")
            }
            return
        }
        
        self.isPopulating = true
        
        Alamofire.request(httpRequest.urlRequest).responseJSON(){
            _,_, JSON,error in
            
            if error==nil{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
                    ){
                        
                        
                        
//                        let lastItem=self.objects.count
                        
                        
                        let infos=JSON!.valueForKey(self.httpRequest.mapKey) as! [NSDictionary]
                        
                        if(self.httpRequest.objResolver != nil){
                            
                            self.httpRequest.objResolver.resolve(infos)
                        }
                        
                        if(self.httpRequest.objMapper != nil){
                            
                            for item in infos{
                                
                                self.objects.addObject(self.httpRequest.objMapper.objectMap(item)!)
                                
                                
                            }

                        }
                        if(self.httpRequest.callback != nil){
                           self.httpRequest.callback.callback("request succeeded")
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
