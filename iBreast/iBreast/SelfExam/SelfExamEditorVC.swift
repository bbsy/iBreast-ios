//
//  SelfExamEditorVC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamEditorVC: UIViewController {
    
    //定义一个变量 存储记录中最后一个lesion的Id
    var maxId:Int = Int.max
    
    @IBAction func didSave(sender: AnyObject) {
        
        checkBoard.save()
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

     
        
        checkBoard.showHistoryLesions(maxId)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        checkBoard.check()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
