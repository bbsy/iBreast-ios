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
    
    static let QUADRANT_ONE = 1
    static let QUADRANT_TWO = 2
    static let QUADRANT_THREE = 3
    static let QUADRANT_FOUR = 4
    
   
    var id:Int = 0
    var  highlight:Bool! = false
    var  time:NSDate! = NSDate()
    var firmness:Int! = HARD
    var size:CGFloat! = 0
    var point:CGPoint! = CGPoint(x: 0, y: 0)
    var scaledX:CGFloat! = 0
    var scaledY:CGFloat! = 0
    //缩放比例
    var scaledSize:CGFloat! = 1
    var allowedMoving:Bool! = false
    //在记录中被删除
    var didDelete:Bool! = false
    //在记录中被增加
    var didAdd:Bool! = false
    //已经被删除
    var didRemove:Bool! = false
    //象限
    var quadrant:Int = QUADRANT_ONE
    
   
    
    func encodeWithCoder(_encoder:NSCoder){
        _encoder.encodeObject(self.id,forKey:"_id")
        _encoder.encodeObject(self.highlight,forKey:"_highlight")
        _encoder.encodeObject(self.time,forKey:"_time")
       _encoder.encodeObject(self.firmness,forKey:"_firmness")
        _encoder.encodeObject(self.size,forKey:"_size")
         _encoder.encodeCGPoint(self.point,forKey:"_point")
        _encoder.encodeObject(self.scaledX,forKey:"_scaledX")
        _encoder.encodeObject(self.scaledY,forKey:"_scaledY")
       _encoder.encodeObject(self.allowedMoving,forKey:"_allowedMoving")
       _encoder.encodeObject(self.didDelete,forKey:"_didDelete")
       _encoder.encodeObject(self.didAdd,forKey:"_didAdd")
       _encoder.encodeObject(self.didRemove,forKey:"_didRemove")
        
        _encoder.encodeObject(self.scaledSize,forKey:"_scaledSize")
        _encoder.encodeObject(self.quadrant,forKey:"_quadrant")
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
        self.scaledX = decoder.decodeObjectForKey("_scaledX") as! CGFloat
        self.scaledY = decoder.decodeObjectForKey("_scaledY") as! CGFloat
        self.allowedMoving = decoder.decodeObjectForKey("_allowedMoving") as! Bool
        self.didDelete = decoder.decodeObjectForKey("_didDelete") as! Bool
        self.didAdd = decoder.decodeObjectForKey("_didAdd") as! Bool
        self.didRemove = decoder.decodeObjectForKey("_didRemove") as! Bool
        
        self.scaledSize = decoder.decodeObjectForKey("_scaledSize") as! CGFloat
        self.quadrant = decoder.decodeObjectForKey("_quadrant") as! Int
        
      
    }

    
    //确认删除一个历史中的肿块
    func setDeleteAndRemove(){
        
        self.didAdd = false
        self.didDelete =  true
        self.didRemove = true
        
    }
    
    func resetAddAndDelete(){
        self.didAdd = false
        self.didDelete = false
    }
    //删除历史记录中的肿块，但是没确认。用户返回后会被重新设置会原始状态
    func setDelete(){
        self.didRemove = false
        self.didAdd = false
        self.didDelete = true
    }
    
    func setAdd(){
        self.didAdd = true
        self.didDelete = false
        self.didRemove = false
    }
    
    
}
