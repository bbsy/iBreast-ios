//
//  HttpObjectMapper.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/19.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

protocol HttpObjectMapper{

  
    
    func objectMap(item:AnyObject)->AnyObject?

}

protocol HttpObjectResolver{
    
    func resolve(item:AnyObject)
}

protocol HttpCallBack{
    func callback(result:AnyObject)
}
