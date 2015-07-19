//
//  HttpRequest.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/19.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation
import Alamofire

class HttpRequest {
    var objMapper:HttpObjectMapper!
    var mapKey:String!
    var urlRequest:URLRequestConvertible!
    var objResolver:HttpObjectResolver!
    var callback:HttpCallBack!
}