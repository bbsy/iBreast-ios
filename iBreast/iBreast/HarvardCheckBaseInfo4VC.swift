//
//  HarvardCheckBaseInfo4VC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/4.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class HarvardCheckBaseInfo4VC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let harvardBaseInfoCellTag:String="hfcheckBI4TableCell"
    
    let HFCHECK_MENU_SECTION=1
     @IBOutlet weak var tableMenu: UITableView!
    var hormone_info=["未使用过激素","使用过少次","大量使用过"];
    let group = ["未组合","已组合"]
    let user_age=["15岁以下","16-18岁","20以上","30以上"]
    
    let alertPicker:AlertPickerViewController=AlertPickerViewController()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertPicker.delegate=self
        alertPicker.dataSource=self
        alertPicker.mUIViewController=self
        alertPicker.mViewControllerDelegate=self
        
        initHarvardCheckMenuData()
        tableMenu.dataSource=self
        
         tableMenu.delegate=self
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
        println("tableView ---- --  ---click \(indexPath.row)");
        
        //var indexId = indexPath.row + (1 * indexPath.section)
        
        if(indexPath.section == 0)
        {
            alertPicker.showPickerInActionSheet(indexPath.row);
        }
//        else
//        {
//            alertPicker.showPickerInActionSheet(indexPath.row+4);
//        }
    }
    
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (data!.allValues[HFCHECK_MENU_SECTION] as! NSArray).count
        
    }
    //    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
    //
    //
    //       return data?.allKeys[HFCHECK_MENU_SECTION] as! String
    //    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
        let cell=tableView.dequeueReusableCellWithIdentifier(harvardBaseInfoCellTag, forIndexPath: indexPath)
            as? UITableViewCell
        
        
        
        //        var lable=cell!.viewWithTag(TAG_CELL_LABLE) as? UILabel
        //         lable.text=(data!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String
        var label=cell?.textLabel?.text=(data!.allValues[HFCHECK_MENU_SECTION] as! NSArray).objectAtIndex(indexPath.row) as! String;
        //
        
        
        
        cell?.detailTextLabel?.text=String(indexPath.row)
        
        return cell!
        
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
    */}


extension HarvardCheckBaseInfo4VC:UIPickerViewDataSource
{
    func numberOfComponentsInPickerView(pickerView:UIPickerView) ->Int
    {
        return 1;
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if(pickerView.tag==0){
            
            return hormone_info.count
        }
        else if(pickerView.tag == 1){
            
            
            return self.group.count
            
        } else if(pickerView.tag == 2){
            
            
            return self.user_age.count
            
        }
        
            
        else{
            return 0
        }
        
    }
}

extension HarvardCheckBaseInfo4VC:UIPickerViewDelegate{
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if(pickerView.tag == 0){
            
            return "\(hormone_info[row])"
        }
            
        else if(pickerView.tag == 1){
            return "\(self.group[row] )"
        } else if(pickerView.tag == 2){
            
            
            return "\(self.user_age[row])"
            
        }
      
        else  {
            
            return "";
            
        }
        
    }
    //
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        if(pickerView.tag == 0){
        //            println("you selected the name: \(self.check_times[row])")
        //        }
        //
        //        else if(pickerView.tag == 1){
        //            println("you selected the name: \(self.check_result[row])")
        //        } else if (pickerView.tag == 2){
        //            println("you selected the name: \(self.conceive_times[row])")
        //        }
        //        else if(pickerView.tag==3){
        //            println("you selected the name: \(self.first_haschild_age[row])")
        //        }
        
    }
}

extension HarvardCheckBaseInfo4VC:AlertPickerViewControllerDelegate{
    func didSelect(){
        println("didSelect")
    }
    func didCancel()
    {
        println("didCancel")
    }
}
