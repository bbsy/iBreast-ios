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
    
     var historyModel:SelfExamHisModel?
    
    var sizeController: UISlider!

    var didSave = false
 
    var lesionsData = SelfExamData.sharedInstance //SelfExamData()
    
    private var drawingState: DrawingState!
    
    private var allowedMoving = false
    
    var lesionsModels:NSMutableOrderedSet!
    
    var lesionViews:[LesionView]=[LesionView]()
    var rect:CGRect!
    
    var addedLesions:[LesionModel] = [LesionModel]()
    var deletedLesions:[LesionModel] = [LesionModel]()
    var totalLesions:[LesionModel] = [LesionModel]()
    
 //   var brush: BaseBrush?
    
    private var realImage: UIImage?
    
    private var statuHeight:CGFloat!
    
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
        
      

        var size = DeviceInfo.getDeviceSize()
        
       
        super.init(coder: aDecoder)
        
//        
        statuHeight = UIApplication.sharedApplication().statusBarFrame.size.height

        var bg = UIImage(named: "breasts.png")

//       self.image = ImageUtil.scaleImage(imgSize, img: bg!)
//    
         rect = CGRect(x: self.frame.origin.x,y: self.frame.origin.y,width: self.frame.size.width,height: self.frame.height)

        
        
        
        
    }
    
    
    func setFirmness(firmness:Int){
        
        if let light = hightlightedLesion{
            if(firmness == 0){
                light.lesion.firmness = LesionModel.SOFT
            }
            else if(firmness == 1){
                  light.lesion.firmness = LesionModel.MEDIUM
            }
            else if(firmness == 2 ){
                  light.lesion.firmness = LesionModel.HARD
            }
            light.reDisplay()
        }
        
    }
    
    func getBackground()->UIImage{
        
        var image=UIImage(named: "breast.png")
        
        var scaleSize = self.frame.size.height/image!.size.width
        
        UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width,self.frame.size.height))
        
        image!.drawInRect(CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height/2))
       
        var scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    func check(){
        if didSave == true {
            //把临时列表的数据清空，没作用了
           
            var maxid:Int = -Int.max
            
            var localLesion = lesionsData.getLocalLesions()
            
            for item in localLesion {
                 var lesion = item as! LesionModel
                if(lesion.id > maxid){
                    maxid = lesion.id
                }
            }
          
            if(deletedLesions.isEmpty && addedLesions.isEmpty){
                //什么都没干
            }
            else if(deletedLesions.isEmpty && !addedLesions.isEmpty){
                //增加了
                
              
//                
                SelfExamHisManager.sharedInstance.addHistory(addedLesions,maxId:addedLesions.last!.id )
                
                
            }
            else if(!deletedLesions.isEmpty && addedLesions.isEmpty){
                //减少了
                SelfExamHisManager.sharedInstance.addHistory(deletedLesions,maxId:maxid)
                
            }
            else {
                //增加了新的，减少了老的
                
                for item in addedLesions {
                    totalLesions.append(item)
                }
                for item in deletedLesions {
                    totalLesions.append(item)
                }

                
                 SelfExamHisManager.sharedInstance.addHistory(totalLesions,maxId: addedLesions.last!.id)
            }
            
            
            deletedLesions.removeAll(keepCapacity: false)
            addedLesions.removeAll(keepCapacity: false)
            
        }
        //如果用户在离开界面之前并没有点击 确认 。数据需要还原
        else {
            
            //恢复数据库中的数据
            
            lesionsData.addLesions(deletedLesions)
            lesionsData.removeLesions(addedLesions)
            
        }
    }
    
    func setSize(value:Float){
        
        if let light = hightlightedLesion{
            
            var size = CGFloat(value)
            var orgSize = light.lesion.size
            light.lesion.size = size
            var orgX = light.lesion.point.x
            var orgY = light.lesion.point.y
            
            
            
            
            
            var x = light.lesion.point.x - (size - orgSize)/2
            var y = light.lesion.point.y - (size - orgSize)/2
            
            light.lesion.point.x = x
            light.lesion.point.y = y
            
            var rect = CGRectMake(x, y, light.lesion.size, light.lesion.size)
            hightlightedLesion.frame = rect
            
          
        }
    }
    
    func setLesionsToRemove(removedLesions:[LesionModel] ){
        
        for item in removedLesions {
            item.didRemove = true
        }
    }
    
    
    func showHistoryLesions(maxId:Int){
        
        
        lesionsModels = lesionsData.getLesions(maxId,historyModel:historyModel)
        
        for obj in lesionsModels {
             var lesion = obj as! LesionModel
            //表示查看历史记录
            if let his = historyModel {
                if his.idsForDelete != nil {
                    for i in 0...his.idsForDelete!.count-1{
                        if lesion.id == his.idsForDelete![i]{
                            lesion.setDelete()
                        }
                    }
                }
                if his.idsForAdd != nil {
                    for i in 0...his.idsForAdd!.count-1{
                        if lesion.id == his.idsForAdd![i]{
                            lesion.setAdd()
                        }
                    }

                }
                
                
               
            }
            else {//表示从编辑界面直接进来
                
                println(".... \(lesion.didRemove)")
               
                if( lesion.didRemove == true){
                    lesionsModels.removeObject(lesion)
                }
            }
            
          

        }
        for obj in lesionsModels {
          add(obj as! LesionModel)
        }
    }
    
    func addNewLesion(){
        
        
        var model = LesionModel()
        model.id = lesionsData.generateId()
        model.point.x = CGFloat(20)
        model.point.y = CGFloat(50)
        model.size = 30
        model.firmness=LesionModel.SOFT
        model.highlight=true
        model.setAdd()
        
        addedLesions.append(model)
        
        add(model)
        lesionViews.last?.firtlyAdd = true
        setHighlight(lesionViews.last!)
        //lesionViews.last?.setHighLight(true)
        
        
        
            
        
    }
    
    func setHighlight(lesionView:LesionView){
        for item in lesionViews {
            if(item.lesion.id == lesionView.lesion.id){
                if(item.isHightlight()){
                    println("item already in highlight")
                    return
                }
                item.setHighLight(true)
                self.sizeController.value = Float(item.lesion.size)
                
            }
            else{
                item.setHighLight(false)

            }
        }
    }
    //在编辑模板中暂时删除一个记录,使图片变删除的闪动效果
    func deleteALesion(){
        
        for (index,item)  in enumerate(lesionViews){
            
            if item.lesion.highlight==true{
                //如果是本次增加的直接去除,永久去除
                item.setDeleteAndRemove()
                if (item.firtlyAdd == true){
                    item.removeFromSuperview()
                    lesionViews.removeAtIndex(index)
                    lesionsData.removeLesion(item.lesion)
                    hightlightedLesion = nil
                    //如果删除的这个
                   
                }//如果不是本次增加的，只能画一个x
                else{
               
                    item.reDisplay()
                    deletedLesions.append(item.lesion)

                }
                
            }
            
        }
        
        
      
    }
    
       
    func save(){
        
        for item in lesionViews{
            item.firtlyAdd = false
        }
        
        didSave = true
        
        check()
        
        lesionsData.save()

        
        didSave = false
    }
    
    func addToDB(model:LesionModel){
       
        lesionsData.addLesion(model)
    }
    
    
    
    func add(item:LesionModel){
        
        var circleCenter:CGPoint=CGPoint(x:item.point.x,y: item.point.y)
        var circleWidth = CGFloat(item.size)
        var circleHeight = circleWidth
        
        var circleView :LesionView=LesionView(frame: CGRectMake(circleCenter.x, circleCenter.y, circleWidth, circleHeight))
        
        circleView.setMyLesion(item) 
       
        
        if let hisModel = historyModel {
            if(hisModel.idsForAdd != nil){
                for i in 0...hisModel.idsForAdd!.count-1{
                    if item.id == hisModel.idsForAdd![i]{
                         item.setAdd()
                    }
                }
               
            }
            if(hisModel.idsForDelete != nil){
                for i in 0...hisModel.idsForDelete!.count-1{
                    if item.id == hisModel.idsForDelete![i]{
                        item.setDelete()
                    }
                }
                
            }
        }
        
        hightlightedLesion = circleView
        
        for obj in lesionsModels {
            var model = obj as! LesionModel
            model.highlight = false
        }
        item.highlight = true
        addToDB(item)
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
        
        if(point.y > self.frame.size.height){
            
            println("not allowed to touch")
            allowedMoving = false
            return
        }
        else{
            allowedMoving = true
        }
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
        
        if(!lesionViews.isEmpty ){
            var rectx = CGFloat(hightlightedLesion.lesion.size) + hightlightedLesion.lesion.point.x
            var recty = CGFloat(hightlightedLesion.lesion.size) + hightlightedLesion.lesion.point.y
            
            var xb = point.x >= CGFloat(hightlightedLesion.lesion.point.x) && point.x <= CGFloat(rectx)
            
            var yb = point.y >= CGFloat(hightlightedLesion.lesion.point.y) && point.y <= CGFloat(recty)
            
            if( xb && yb && hightlightedLesion.firtlyAdd == true){
                hightlightedLesion?.lesion.allowedMoving = true
            }
            else{
                hightlightedLesion?.lesion.allowedMoving = false
            }
            setHighlight(hightlightedLesion)
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
        
        
        
        
        if(allowedMoving == false){
            
            println("not allowed to move")
            return
        }
        
        
        var movePoint=(touches as NSSet).anyObject()!.locationInView(self)
        
        
        if let cir=hightlightedLesion{
            
            if(hightlightedLesion.lesion.allowedMoving == true ){
                
          
                
                var overHeight:Bool = (rect.origin.y + rect.size.height/2) < movePoint.y - statuHeight + hightlightedLesion.lesion.size
                
                var overWidth = rect.origin.x + rect.size.width < movePoint.x + hightlightedLesion.lesion.size
                
                if(overHeight || overWidth){
                    
                    println("越界，越界")
                    
                    return
                }
                
                

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
   

    

}
