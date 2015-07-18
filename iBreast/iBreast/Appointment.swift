//
//  Appointment.swift
//  iBreast
//
//  Created by 许仕永 on 15/7/19.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation
import UIKit

class  Appointment:UIViewController {
    //appointmentCell
    
    @IBOutlet weak var tabview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabview.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension Appointment:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 10
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "appointmentCell"
        
        var cell:UITableViewCell!
        
        var c = self.tabview.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if(c == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
        }
        else {
            cell = c as! UITableViewCell
        }
        
        //var model = selfExamHisList[indexPath.row] as SelfExamHisModel
        //
        //var title=cell.viewWithTag(200) as! UILabel
        //title.text="ssss"
        //
        //        var subTitle=cell.viewWithTag(101) as! UILabel
        //subTitle.text=model.detail
        
        
        //subTitle.text=dateStr
        
        
        
        var locale=NSLocale.currentLocale()
        let dateFormatt=NSDateFormatter.dateFormatFromTemplate("yyyy-mm-dd", options: 0, locale: locale)
        
        let dateFormatter=NSDateFormatter()
        dateFormatter.dateFormat=dateFormatt
        
        //let dateStr=dateFormatter.stringFromDate(model.time)
        
        
        return cell
        
    }
}
