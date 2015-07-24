//
//  SelfExamEditorVC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamEditorVC: UIViewController {
    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
