//
//  SelfExamHisVC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/18.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamHisVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selfExamHisList:[SelfExamHisModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         var data=SelfExamHisManager.getInstance().fetchHisRecord(0, num: 10)
        
        if let list = data {
            
            selfExamHisList = list as! [SelfExamHisModel]
        }
        
        tableView.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SelfExamHisVC:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return selfExamHisList.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "selfExamHisCell"
        
        var cell:UITableViewCell!
        
        var c = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if(c == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
        }
        else {
            cell = c as! UITableViewCell
        }
        
        var model = selfExamHisList[indexPath.row] as SelfExamHisModel
//        
        var title=cell.viewWithTag(200) as! UILabel
        title.text=model.title
//        
//        var subTitle=cell.viewWithTag(101) as! UILabel
        //subTitle.text=model.detail
        
        
        //subTitle.text=dateStr
        
        
        
        var locale=NSLocale.currentLocale()
        let dateFormatt=NSDateFormatter.dateFormatFromTemplate("yyyy-mm-dd", options: 0, locale: locale)
        
        let dateFormatter=NSDateFormatter()
        dateFormatter.dateFormat=dateFormatt
        
        let dateStr=dateFormatter.stringFromDate(model.time)
        
        
        return cell
        
    }
}

