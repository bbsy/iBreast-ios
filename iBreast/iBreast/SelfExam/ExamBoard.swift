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
    
    var LESIONS_DATA_PATH:String!
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
    private var drawingState: DrawingState!
    
    var idMax:Int! = 0
    
    var lesionsModels:NSMutableOrderedSet!
    
    var lesionViews:[LesionView]=[LesionView]()
    
    
    
 //   var brush: BaseBrush?
    
    private var realImage: UIImage?
    
//    var strokeWidth: CGFloat
//    var strokeColor: UIColor
    
  //
    var hightlightedLesion:LesionView!
    
    let PI=3.1415926
    
//    override init() {
//        self.strokeColor = UIColor.blackColor()
//        self.strokeWidth = 1
//        super.init()
//    }
    
    required init(coder aDecoder: NSCoder) {
        
      
        
       
        
//        self.strokeColor = UIColor.blackColor()
//        self.strokeWidth = 1
//        
//        self.brush=PencilBrush()
        
         LESIONS_DATA_PATH = "\(Constant.LESIONS_DATA_PATH)"
        
        super.init(coder: aDecoder)
        
        var img=UIImage(named: "breast.png")
      
        self.image=img
        
       if(fetch()==false){
            showHistoryLesions()
       }
        
        
        
    }
    
    func showHistoryLesions(){
        
        var lesionsData = SelfExamData()
        lesionsModels = lesionsData.getLesions()
        
        for obj in lesionsModels {
            
            
            add(obj as! LesionModel)

        }
        
        
        
    }
    
    func addNewLesion(){
        
        
        var model = LesionModel()
        model.id = generateId()
        model.point.x = CGFloat(100)
        model.point.y = CGFloat(200)
        model.size = 30
        model.firmness=LesionModel.SOFT
        model.highlight=true
     
        
        add(model)
        
            
        
    }
    
    func deleteALesion(){
        
        for (index,item)  in enumerate(lesionViews){
            
            if item.lesion.highlight==true{
                
                item.removeFromSuperview()
                lesionViews.removeAtIndex(index)
                lesionsModels.removeObject(item.lesion)
                hightlightedLesion = nil
            }
            
        }
        
      
    }
    
    func generateId()->Int{
        
        var max:Int = -100
        
        for item  in lesionsModels{
            var model = item as! LesionModel
            if model.id > max{
                max = item.id
            }
            
        }
        return ++max
    }
    
    func remove(){
        
    }
    
    func save(){
        
        
        var path=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! NSString
        
        var filePath=path.stringByAppendingPathComponent("lesionsData.archive")
//        
//        var data=NSMutableArray()
//        
//         for i in 1...10 {
//                    var model = Model()
//                    model.id = i
//                    model.name = "zhongqihong"
//                    data.addObject(model)
//        }
        
        if(userDefault.objectForKey(LESIONS_DATA_PATH) != nil){
            
            userDefault.removeObjectForKey(LESIONS_DATA_PATH)
        }
        
        var modelData:NSData = NSKeyedArchiver.archivedDataWithRootObject(lesionsModels)
        userDefault.setObject(modelData, forKey: LESIONS_DATA_PATH)
        
        
        
    }
    
    func fetch() ->Bool{
        
        var deModel = userDefault.objectForKey(LESIONS_DATA_PATH)
        
        if deModel != nil{
            var array:NSMutableOrderedSet = NSKeyedUnarchiver.unarchiveObjectWithData(deModel! as! NSData) as! NSMutableOrderedSet
        
            lesionsModels = NSMutableOrderedSet()
        
            for item in array {
            
                println((item as! LesionModel).highlight)
                self.add(item as! LesionModel)
            }
            
            return true
        }
        
        return false

    }
    
    func add(item:LesionModel){
        
        var circleCenter:CGPoint=CGPoint(x:item.point.x,y: item.point.y)
        var circleWidth = CGFloat(item.size)
        var circleHeight = circleWidth
        
        var circleView :LesionView=LesionView(frame: CGRectMake(circleCenter.x, circleCenter.y, circleWidth, circleHeight))
        
        circleView.lesion = item
        
        hightlightedLesion = circleView
        
        for obj in lesionsModels {
            var model = obj as! LesionModel
            model.highlight = false
        }
        item.highlight = true
        lesionsModels.addObject(item)
        lesionViews.append(circleView)
        self.addSubview(circleView)

    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        
//        if let brush = self.brush {
//            brush.lastPoint = nil
//            
//            brush.beginPoint = (touches as NSSet).anyObject()!.locationInView(self)
//            brush.endPoint = brush.beginPoint
//            
//            self.drawingState = .Began
//            self.drawingImage()
//        }
        
        var point=(touches as NSSet).anyObject()!.locationInView(self)
        
        getNearestPoint(point)
        
        
    }
    
    
    func getNearestPoint( point:CGPoint)->Int{
        
        
        var offset:CGFloat? = 100000.0
        var cursor=0;
        
        for (index,item)  in enumerate(lesionViews){
           
              var v=sqrt(fabs((point.x-item.lesion.point!.x)*(point.x-item.lesion.point!.x))+fabs((point.y-item.lesion.point!.y)*(point.y-item.lesion.point!.y)))
            
            if(v<offset){
                cursor=index
                offset=v
            }
        }
        if !lesionViews.isEmpty&&lesionViews.count>cursor{
           
          for (index,item)  in enumerate(lesionViews){
            if(index==cursor){
                item.lesion.highlight=true
                hightlightedLesion=item
            }
            else{
                item.lesion.highlight=false
            }
                
           }
            
        }
        
        if(!lesionViews.isEmpty){
            var rectx = CGFloat(hightlightedLesion.lesion.size) + hightlightedLesion.lesion.point.x
            var recty = CGFloat(hightlightedLesion.lesion.size) + hightlightedLesion.lesion.point.y
            
            var xb = point.x >= CGFloat(hightlightedLesion.lesion.point.x) && point.x <= CGFloat(rectx)
            
            var yb = point.y >= CGFloat(hightlightedLesion.lesion.point.y) && point.y <= CGFloat(recty)
            
            if( xb && yb){
                hightlightedLesion?.lesion.allowedMoving = true
            }
            else{
                hightlightedLesion?.lesion.allowedMoving = false
            }
        }
       
     
      
        

////        
    
        
//        println("real cursor = \(cursor) and offset=\(offset)")
        

        
        return 0
        
    }
    
  
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
//        if let brush = self.brush {
//            brush.endPoint = (touches as NSSet).anyObject()!.locationInView(self)
//            
//            self.drawingState = .Moved
//            self.drawingImage()
//        }
        
        
        if let cir=hightlightedLesion{
            
            if(hightlightedLesion.lesion.allowedMoving == true){
                var movePoint=(touches as NSSet).anyObject()!.locationInView(self)
                cir.lesion.point=movePoint
                cir.frame=CGRectMake(movePoint.x, movePoint.y, cir.frame.size.width, cir.frame.size.height)
            }
           
        }
        
        
        
    }
    
    override func touchesCancelled(touches: Set<NSObject>, withEvent event: UIEvent!) {
//        if let brush = self.brush {
//            brush.endPoint = nil
//        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
//        if let brush = self.brush {
//            brush.endPoint = (touches as NSSet).anyObject()!.locationInView(self)
//            
//            self.drawingState = .Ended
//            
//            self.drawingImage()
//        }
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
