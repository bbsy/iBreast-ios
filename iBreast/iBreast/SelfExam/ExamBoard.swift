//
//  ExamBoard.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit


enum DrawingState {
    case Began, Moved, Ended
}

class ExamBoard: UIImageView {
    
    private var drawingState: DrawingState!
    
    var lesionsData:SelfExamData?
    
    var lesionsView=[CircleView]()
    
    var brush: BaseBrush?
    
    private var realImage: UIImage?
    
    var strokeWidth: CGFloat
    var strokeColor: UIColor
    
  //
    var hightlightedLesion:CircleView?
    
    let PI=3.1415926
    
//    override init() {
//        self.strokeColor = UIColor.blackColor()
//        self.strokeWidth = 1
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        
        lesionsData = SelfExamData()
        
        var lesions=lesionsData?.getLesions()
        
       
        
        self.strokeColor = UIColor.blackColor()
        self.strokeWidth = 1
        
        self.brush=PencilBrush()
        
        super.init(coder: aDecoder)
        
        var img=UIImage(named: "breast.png")
      
        self.image=img
        
    }
    
    func addNewLesion(){
        
        
        // Set the Center of the Circle
        // 1
        //var circleCenter = (touches as NSSet).anyObject()!.locationInView(self)
        
        // Set a random Circle Radius
        // 2
        
        var circleCenter:CGPoint=CGPoint(x: CGFloat(100),y: CGFloat(200))
        
        
        
        var circleWidth = CGFloat(25 + (arc4random() % 50))
        var circleHeight = circleWidth
        
        // Create a new CircleView
        // 3
      
            
            var circleView :CircleView?=CircleView(frame: CGRectMake(circleCenter.x, circleCenter.y, circleWidth, circleHeight))
            
            circleView!.point=circleCenter
            circleView!.firmness=LesionFirmness.SOFT
            circleView!.highlight=true
            
            self.addSubview(circleView!)
            
            lesionsView.append(circleView!)
        
            hightlightedLesion=circleView
        

        
        
    }
    
    func deleteALesion(){
        
        for (index,item)  in enumerate(lesionsView){
            
            if item.highlight==true{
                
                item.removeFromSuperview()
                lesionsView.removeAtIndex(index)
            }
            
        }
        
      
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let brush = self.brush {
            brush.lastPoint = nil
            
            brush.beginPoint = (touches as NSSet).anyObject()!.locationInView(self)
            brush.endPoint = brush.beginPoint
            
            self.drawingState = .Began
            self.drawingImage()
        }
        
        var point=(touches as NSSet).anyObject()!.locationInView(self)
        
        getNearestPoint(point)
        
        
    }
    
    
    func getNearestPoint( point:CGPoint)->Int{
        
        
        var offset:CGFloat? = 100000.0
        var cursor=0;
        
        for (index,item)  in enumerate(lesionsView){
           
              var v=sqrt(fabs((point.x-item.point!.x)*(point.x-item.point!.x))+fabs((point.y-item.point!.y)*(point.y-item.point!.y)))
            
            if(v<offset){
                cursor=index
                offset=v
            }
        }
        if !lesionsView.isEmpty&&lesionsView.count>cursor{
           
          for (index,item)  in enumerate(lesionsView){
            if(index==cursor){
                item.highlight=true
                hightlightedLesion=item
            }
            else{
                item.highlight=false
            }
                
           }
            
        }
        
        println("real cursor = \(cursor) and offset=\(offset)")
        

        
        return 0
        
    }
    
  
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let brush = self.brush {
            brush.endPoint = (touches as NSSet).anyObject()!.locationInView(self)
            
            self.drawingState = .Moved
            self.drawingImage()
        }
        
        
        if let cir=hightlightedLesion{
            var movePoint=(touches as NSSet).anyObject()!.locationInView(self)
            cir.point=movePoint
            cir.frame=CGRectMake(movePoint.x, movePoint.y, cir.frame.size.width, cir.frame.size.height)
        }
        
        
        
    }
    
    override func touchesCancelled(touches: Set<NSObject>, withEvent event: UIEvent!) {
        if let brush = self.brush {
            brush.endPoint = nil
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let brush = self.brush {
            brush.endPoint = (touches as NSSet).anyObject()!.locationInView(self)
            
            self.drawingState = .Ended
            
            self.drawingImage()
        }
    }
   

    private func drawingImage() {
        
//        if let brush = self.brush {
//            
//            // 1.
//            UIGraphicsBeginImageContext(self.bounds.size)
//            
//            // 2.
//            let context = UIGraphicsGetCurrentContext()
//            
//            UIColor.clearColor().setFill()
//            UIRectFill(self.bounds)
//            
//            CGContextSetLineCap(context, kCGLineCapRound)
//            CGContextSetLineWidth(context, self.strokeWidth)
//            CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor)
//            
//            // 3.
//            if let realImage = self.realImage {
//                realImage.drawInRect(self.bounds)
//            }
//            
//            // 4.
//            brush.strokeWidth = self.strokeWidth
//            brush.drawInContext(context);
//            CGContextStrokePath(context)
//            
//            // 5.
//            let previewImage = UIGraphicsGetImageFromCurrentImageContext()
//            if self.drawingState == .Ended || brush.supportedContinuousDrawing() {
//                self.realImage = previewImage
//            }
//            
//            UIGraphicsEndImageContext()
//            
//            // 6.
//            self.image = previewImage;
//            
//            brush.lastPoint = brush.endPoint
//        }
    }

}
