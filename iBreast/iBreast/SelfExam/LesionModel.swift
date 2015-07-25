//
//  LesionModel.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/18.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class LesionModel: NSObject{
    
    static let HARD = 0
    static let MEDIUM = 1
    static let SOFT = 2
    
   
    var id:Int = 0
    var  highlight:Bool! = false
    var  time:NSDate! = NSDate()
    var firmness:Int! = HARD
    var size:CGFloat! = 0
    var point:CGPoint! = CGPoint(x: 0, y: 0)
    var x:Float! = 0
    var y:Float! = 0
    var allowedMoving:Bool! = false
    var didDelete:Bool! = false
    var didAdd:Bool! = false
    
   
    
    func encodeWithCoder(_encoder:NSCoder){
        _encoder.encodeObject(self.id,forKey:"_id")
        _encoder.encodeObject(self.highlight,forKey:"_highlight")
        _encoder.encodeObject(self.time,forKey:"_time")
       _encoder.encodeObject(self.firmness,forKey:"_firmness")
        _encoder.encodeObject(self.size,forKey:"_size")
         _encoder.encodeCGPoint(self.point,forKey:"_point")
        _encoder.encodeObject(self.x,forKey:"_x")
        _encoder.encodeObject(self.y,forKey:"_y")
       _encoder.encodeObject(self.allowedMoving,forKey:"_allowedMoving")
           _encoder.encodeObject(self.didDelete,forKey:"_didDelete")
          _encoder.encodeObject(self.didAdd,forKey:"_didAdd")
        
    }
    
    override init(){
        
    }
    
    init(coder decoder:NSCoder){
        
        self.id = decoder.decodeObjectForKey("_id") as! Int
        self.highlight = decoder.decodeObjectForKey("_highlight") as! Bool
        self.time = decoder.decodeObjectForKey("_time") as! NSDate
         self.firmness = decoder.decodeObjectForKey("_firmness") as! Int
        self.size = decoder.decodeObjectForKey("_size") as! CGFloat
        self.point = decoder.decodeCGPointForKey("_point") as! CGPoint
        self.x = decoder.decodeObjectForKey("_x") as! Float
        self.y = decoder.decodeObjectForKey("_y") as! Float
         self.allowedMoving = decoder.decodeObjectForKey("_allowedMoving") as! Bool
         self.didDelete = decoder.decodeObjectForKey("_didDelete") as! Bool
         self.didAdd = decoder.decodeObjectForKey("_didAdd") as! Bool
    }

    
    
}
