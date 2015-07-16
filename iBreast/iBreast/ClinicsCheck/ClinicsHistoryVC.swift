//
//  ClinicsHistoryVC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/7.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

func dateFromString(dateStr:String)->NSDate{
    var dateFormatter=NSDateFormatter()
    dateFormatter.dateFormat="yyyy-mm-dd"
    var date=dateFormatter.dateFromString(dateStr)
    
    return date!
}

class ClinicsHistoryVC: UIViewController {
    
    
    let TABLE_CELL_TAG="cliHisTag"
    
    @IBOutlet weak var tableView: UITableView!
    var history:[ClinicsHistoryModel]=[]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
      
    override func viewDidLoad() {
        super.viewDidLoad()
       
        history=[ClinicsHistoryModel(id: "\(0)",date:dateFromString("2015-7-20"),image: "his0",title: "insert new lesion",detail: "hard,medium"),
            ClinicsHistoryModel(id: "\(1)",date:dateFromString("2015-7-20"),image: "his1",title: "insert new lesion",detail: "hard,medium"),ClinicsHistoryModel(id: "\(2)",date:dateFromString("2015-7-20"),image: "his2",title: "insert new lesion",detail: "hard,medium"),
        ClinicsHistoryModel(id: "\(3)",date:dateFromString("2015-7-23"),image: "his0",title: "insert new lesion",detail: "hard,medium")]
        
        tableView.dataSource=self
   }

}

extension ClinicsHistoryVC:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return history.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell=self.tableView.dequeueReusableCellWithIdentifier(TABLE_CELL_TAG) as! UITableViewCell
        
        var model = history[indexPath.row] as ClinicsHistoryModel
        
        var title=cell.viewWithTag(100) as! UILabel
        title.text=model.title
       
        var subTitle=cell.viewWithTag(101) as! UILabel
        //subTitle.text=model.detail
        
        var locale=NSLocale.currentLocale()
        let dateFormatt=NSDateFormatter.dateFormatFromTemplate("yyyy-mm-dd", options: 0, locale: locale)
        
        let dateFormatter=NSDateFormatter()
        dateFormatter.dateFormat=dateFormatt
        
        let dateStr=dateFormatter.stringFromDate(model.date!)
        
        subTitle.text=dateStr
        
        
        return cell
        
    }
}
