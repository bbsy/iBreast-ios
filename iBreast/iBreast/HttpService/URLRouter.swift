//
//  URLRouter.swift
//  alam
//
//  Created by 钟其鸿 on 15/7/14.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit
import Alamofire

class URLRouter: NSObject {
   
    
    enum Router:URLRequestConvertible{
        
        static let baseURLString="http://192.168.0.105:8080/iBreast/servlet/"
        static let consumerKey=""
        
        case PopularPhotos(Int)
        
        
        var URLRequest:NSURLRequest{
            let(path:String,parameters:[String:AnyObject])={
                
                switch self {
                 case .PopularPhotos(let page):
                    let params=["consumer_key":Router.consumerKey,"page":"\(page)"]
                    return ("Schedule",params)
                }
            }()
            
            let URL = NSURL(string:Router.baseURLString)
            let URLRequest = NSURLRequest(URL:URL!.URLByAppendingPathComponent(path))
            let encoding=Alamofire.ParameterEncoding.URL
            
            let result = encoding.encode(URLRequest, parameters:parameters).0
            
            println(result)
            
            return result
        }
        
        
    }
}
