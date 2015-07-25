//
//  RecordViewController.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/7.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit


var recordData:NSDictionary?


class RecordViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    let RecordListTag="RecordListTag"
    
    var alertPicker:AlertDatePickerView = AlertDatePickerView()

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initRecordMenuData()
        
        tableView.dataSource=self
        tableView.delegate=self
        
         alertPicker.mUIViewController=self
        alertPicker.valueChangedDeletgete = self
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (recordData!.allValues[section] as! NSArray).count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
        
        if(indexPath.section == 0) {
            if(indexPath.row==0){
                alertPicker.showPickerInActionSheet(indexPath.row)
            }
            else if(indexPath.row==1){
                alertPicker.showPickerInActionSheet(indexPath.row)
            }
            else if(indexPath.row==2){
                alertPicker.showPickerInActionSheet(indexPath.row)
            }
        }
        else if(indexPath.section == 1)
        {
            alertPicker.showPickerInActionSheet(indexPath.row+3)
        }
        else if(indexPath.section == 2){
            
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
         let cellIdentifier="UITableViewCellIdentifierKey1";
    let cellIdentifierForFirstRow="UITableViewCellIdentifierKeyWithSwitch";
        
        var cell:UITableViewCell?
        
        if(indexPath.section==2){
            if(indexPath.row==0){
                var c=tableView.dequeueReusableCellWithIdentifier(cellIdentifierForFirstRow)
                if c != nil {
                    cell = c as! UITableViewCell
                }
            }
            else{
                
                var c = tableView.dequeueReusableCellWithIdentifier( cellIdentifier)
                
                if c != nil {
                    cell = c as! UITableViewCell
                }
            }
            
            
        }
        
        else{
            var c = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
            
            if c != nil {
                cell = c as! UITableViewCell

            }
         }
        
        if(cell==nil){
            
            if(indexPath.section==2 && indexPath.row==0){
                cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifierForFirstRow)
                
                var sw=UISwitch()
                sw.addTarget(self, action: "onNoticeValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
                cell?.accessoryView=sw
            }
            
            else{
                cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
            }
        }
        
        
        

        

  
        var label=cell?.textLabel?.text=(recordData!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String;
        //
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat="yyyy-MM-dd"
        var  today:NSDate = NSDate();
        var dateStr = dateFormatter.stringFromDate(today)
        
        if(indexPath.section == 0)
        {
            if(indexPath.row == 0)
            {
                var  today:NSDate = NSDate();
                var dateStr = dateFormatter.stringFromDate(today)

                if(remindModel.lastPeriodFrom == nil)
                 {
                    remindModel.lastPeriodFrom = dateStr;
                 }
                cell?.detailTextLabel?.text = "\(remindModel.lastPeriodFrom)"
            }
            else if(indexPath.row == 1)
            {
                var  today:NSDate = NSDate();
                var dateStr = dateFormatter.stringFromDate(today)

                if(remindModel.lastPeriodTo == nil)
                 {
                    remindModel.lastPeriodTo = dateStr;
                 }
                cell?.detailTextLabel?.text = "\(remindModel.lastPeriodTo)"
            }
            else if(indexPath.row == 2)
            {
                var  today:NSDate = NSDate();
                var dateStr = dateFormatter.stringFromDate(today)

                if(remindModel.suggestedExamlDate == nil)
                 {
                    remindModel.suggestedExamlDate = dateStr;
                 }
                cell?.detailTextLabel?.text = "\(remindModel.suggestedExamlDate)"
            }
        }
        else if(indexPath.section == 1)
        {
            if(indexPath.row == 0)
            {
                var  today:NSDate = NSDate();
                var dateStr = dateFormatter.stringFromDate(today)

                if(remindModel.everyMonthSuggestDate == nil)
                 {
                    remindModel.everyMonthSuggestDate = dateStr;
                 }
                cell?.detailTextLabel?.text = "\(remindModel.everyMonthSuggestDate)";
            }
        }
//        else if(indexPath.section == 2)
//        {
//            if(indexPath.row == 1)
//            {
//                
//            }
//        }
        
        
        //cell?.detailTextLabel?.text=String(indexPath.row)
        
        return cell!

    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return (recordData?.allKeys as! NSArray).count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        
        return recordData?.allKeys[section] as! String
    }


    
    func initRecordMenuData(){
        
        if recordData==nil
        {
            var pathStr = NSBundle.mainBundle().pathForResource("recordList", ofType:"plist")
            if let newPathStr = pathStr //pathStr可能为nil
            {
                recordData = NSDictionary(contentsOfFile: newPathStr);
                
            }
        }
        
    }
    
    func onNoticeValueChanged(sender:AnyObject?){
        
        var sw:UISwitch=sender as! UISwitch
        remindModel.needNotify = sw.on;
        println("the state of sw is \(sw.on) ")
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

extension RecordViewController:AlertDatePickerViewValueChanged{

    

    func onValueChanged(date:NSDate,tag:Int){

        var dateFormatter = NSDateFormatter()

        dateFormatter.dateFormat="yyyy-MM-dd"

        var dateStr = dateFormatter.stringFromDate(date)

        

        switch(tag)

        {

        case 0:remindModel.lastPeriodFrom = dateStr;

        case 1:remindModel.lastPeriodTo = dateStr;

        case 2:remindModel.suggestedExamlDate = dateStr;

        case 3:remindModel.everyMonthSuggestDate = dateStr;

        case 4:remindModel.lastPeriodFrom = dateStr;

        default:remindModel.lastPeriodFrom = dateStr;

        }

        

        tableView.reloadData()

        

        println("dateStr: \(dateStr), tag: \(tag)")

    }

}
