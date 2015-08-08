//
//  SelfExamEditorVC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamEditorVC: UIViewController {
    
    @IBOutlet weak var delButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    @IBAction func firmnessChanged(sender: AnyObject) {
        
       var seg = sender as! UISegmentedControl
        
        
        checkBoard.setFirmness(seg.selectedSegmentIndex)
        
        println("selected index \(seg.selectedSegmentIndex)")
        
    }
    
    //定义一个变量 存储记录中最后一个lesion的Id
    var maxId:Int = Int.max
    
    var historyModel:SelfExamHisModel?
    
    @IBOutlet weak var sizeController: UISlider!
    
    @IBAction func didSave(sender: AnyObject) {
        
        checkBoard.save()
    }
  
    @IBAction func sizeChanged(sender: AnyObject) {
        var slider = sender as! UISlider
        
        println(slider.value)
        
        checkBoard.setSize(slider.value)
    }
    
    
    @IBOutlet weak var checkBoard: ExamBoard!
   
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        
        
    }

    @IBAction func didAddLesion(sender: AnyObject) {
        checkBoard.addNewLesion()
    }

    @IBAction func didDeleteLesion(sender: AnyObject) {
        checkBoard.deleteALesion()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

     
        if let hisModel = historyModel{
            maxId = hisModel.lastId
            checkBoard.historyModel = hisModel
            
            delButton.hidden = true
            addButton.hidden = true
        }
        
        //checkBoard.hidden = true
        
        
        
        checkBoard.sizeController = self.sizeController
        
        checkBoard.showHistoryLesions(maxId)
        
        
        /**********************************/
        
        var statuHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        
        println("statueHeith: \(statuHeight)")
        
        var orgY = checkBoard.frame.origin.y - 45
        
        var point = CGPoint(x: 0,y: 65)
        
        checkBoard.frame.origin = point

        
         var size = DeviceInfo.getDeviceSize()
        
      
        var imgSize = CGSize(width: size.width, height: size.width)
        
        checkBoard.frame.size = imgSize
        
        /**********************************/
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        checkBoard.check()
        historyModel = nil
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
