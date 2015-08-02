//
//  CircleView.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit



enum LesionFirmness{
    case SOFT, MEDIUM, HARD
}

class LesionView: UIView {

    var scaleToSize:CGSize!
    var highLightImage:UIImage?
    var origImage:UIImage?
    var image:UIImage!
    var orgFront:UIImage!
    //是否第一次增加
    var firtlyAdd = false
    
    var lesion: LesionModel = LesionModel()
    
    var  context:CGContext?
    
    var timer:NSTimer?

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        scaleToSize = CGSize(width: frame.size.width,height: frame.size.height)
         orgFront = UIImage(named: getImage())
    }
    
    
    
   
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMyLesion(lesion:LesionModel){
        self.lesion = lesion
        reDisplay()
    }
    
    //确认删除一个历史中的肿块
    func setDeleteAndRemove(){
        lesion.setDeleteAndRemove()
    }
    //删除历史记录中的肿块，但是没确认。用户返回后会被重新设置会原始状态
    func setDelete(){
        lesion.setDelete()
    }
    
    func setAdd(){
        lesion.setAdd()
    }
    
    func setSize(size:CGFloat){
        lesion.size=size
    }
    
    func setFirmness(firmness:Int){
        lesion.firmness=firmness
    }
    
    func setHighlight(highlight:Bool){
        lesion.highlight=highlight
    }
    
    func setPoint(point:CGPoint){
        lesion.point=point
    }
    
    func setHighLight(high:Bool){
        lesion.highlight = high
      
        if(high == true){
            
            
            orgFront = UIImage(named: getImage())
            
          
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "zoomImage:", userInfo: nil, repeats: true)
            
           
            

        }
        else{
            if let t = timer {
                t.invalidate()
                timer = nil
                origImage = nil
                setNeedsDisplay()
            }
        }
        
    }
    
    func isHightlight()->Bool{
        if (timer != nil){
            return true
        }
        else{
            return false
        }
    }
    
    func getImage()->String{
        
        if(firtlyAdd == true){
            if(lesion.firmness == LesionModel.HARD){
                return "new_hard_lesion"
            }
            else if(lesion.firmness == LesionModel.MEDIUM)
            {
                return "new_medium_lesion"
            }
            else if(lesion.firmness == LesionModel.SOFT){
                
                return "new_soft_lesion"
            }

            return "new_soft_lesion"
        }
        else if(lesion.didAdd == true){
         //此时用户在查看记录
            if(lesion.firmness == LesionModel.HARD){
                 return "new_hard_lesion"
            }
            else if(lesion.firmness == LesionModel.MEDIUM)
            {
                 return "new_medium_lesion"
            }
            else if(lesion.firmness == LesionModel.SOFT){
                
                 return "new_soft_lesion"
            }
            return "new_soft_lesion"
        }
        else if(lesion.didDelete == true){
            if(lesion.firmness == LesionModel.HARD){
                return "old_hard_lesion_del"
            }
            else if(lesion.firmness == LesionModel.MEDIUM)
            {
                return "old_medium_lesion_del"
            }
            else if(lesion.firmness == LesionModel.SOFT){
                
                return "old_soft_lesion_del"
            }
            return "new_soft_lesion_del"
        }
        else {
            if(lesion.firmness == LesionModel.HARD){
                return "old_hard_lesion"
            }
            else if(lesion.firmness == LesionModel.MEDIUM)
            {
                return "old_medium_lesion"
            }
            else if(lesion.firmness == LesionModel.SOFT){
                
                return "old_soft_lesion"
            }
            return "old_soft_lesion"
        }
    }
    
    func getBackgroundImage()->String{
        
        if(firtlyAdd == true){
            return "new"
        }
        else if(lesion.didDelete == true){
            return "delete"
        }
        else if(lesion.didAdd == true){
            return "add"
        }
        
        return "highlight"
    }
    
    func reDisplay(){
       
          orgFront = UIImage(named: getImage())
        
    }
    
    
    func zoomImage(sender:AnyObject?){
    
        if(scaleToSize.width < frame.size.width){
            
            scaleToSize.width = frame.size.width
            scaleToSize.height = scaleToSize.width
        }
        else{
            
            scaleToSize.width = frame.size.width - 5
            scaleToSize.height = frame.size.height - 5
        }
        
        setNeedsDisplay()
 
    }
    
    
    override func drawRect(rect: CGRect) {
        // Get the Graphics Context
        context = UIGraphicsGetCurrentContext();
        
        CGContextSetAllowsAntialiasing(context, true) //抗锯齿设置
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 5.0);
        
//        // Set the circle outerline-colour
//        if(lesion.didAdd == true){
//            UIColor.yellowColor().set()
//        }
//        else if(lesion.didDelete == true){
//            UIColor.redColor().set()
//        }
//        else {
//           UIColor.grayColor().set()
//        }
        
        
        
        
//        
//        if( origImage != nil){
//            
//            
//            CGContextSetShadow(context, CGSizeMake(3, 3),10)
//            
//            // 创建一个bitmap的context
//            // 并把它设置成为当前正在使用的context
//            UIGraphicsBeginImageContext(frame.size);
//            
//            // 绘制改变大小的图片
//            origImage!.drawInRect(CGRectMake(0, 0, scaleToSize.width, scaleToSize.height))
//            
//            // 从当前context中创建一个改变大小后的图片
//            highLightImage = UIGraphicsGetImageFromCurrentImageContext();
//            
//            // 使当前的context出堆栈
//            UIGraphicsEndImageContext();
//            
//            highLightImage!.drawAtPoint(CGPointMake((frame.size.width - scaleToSize.width)/2 ,(frame.size.height - scaleToSize.height)/2));
//
//        }
        
        if(orgFront != nil){
            
           
            
            CGContextSetShadow(context, CGSizeMake(3, 3),10)
            
            // 创建一个bitmap的context
            // 并把它设置成为当前正在使用的context
            UIGraphicsBeginImageContext(frame.size);
            
            // 绘制改变大小的图片
            orgFront.drawInRect(CGRectMake(0, 0, scaleToSize.width, scaleToSize.height))
            
            // 从当前context中创建一个改变大小后的图片
            image = UIGraphicsGetImageFromCurrentImageContext();
            
            // 使当前的context出堆栈
            UIGraphicsEndImageContext();
            
          
            
            
        }
        image.drawAtPoint(CGPointMake((frame.size.width - scaleToSize.width)/2 ,(frame.size.height - scaleToSize.height)/2))

        
        
//        // Create Circle
//        CGContextAddArc(context, (frame.size.width)/2, (frame.size.height)/2, (frame.size.width-15)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        // Draw
        CGContextStrokePath(context);
        
        
       
    }


}
