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
        
        static let baseURLString=Constant.SERVER_HOST
        
        static let consumerKey=""
        
        case PopularPhotos(Int)
        
        case PopularClinics(Int,Int)
        
        
        var URLRequest:NSURLRequest{
            let(path:String,parameters:[String:AnyObject])={
                
                switch self {
                 case .PopularPhotos(let page):
                    let params=["consumer_key":Router.consumerKey,"page":"\(page)"]
                    return ("Schedule",params)
                case .PopularClinics(let pageIndex,let pageNum):
                    let params=["g":"Api","m":"Api","a":"clinicinfo"]
                    return ("",params)
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
