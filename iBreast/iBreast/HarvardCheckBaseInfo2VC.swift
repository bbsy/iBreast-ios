//
//  HarvardCheckBaseInfo2VC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/3.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class HarvardCheckBaseInfo2VC: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableBaseInof2: UITableView!
    let HFCHECK_MENU_SECTION=4
    let harvardBaseInfoCellTag:String="hfcheckBI2TableCell"
    var selfData:NSDictionary?
    let alertPicker:AlertPickerViewController=AlertPickerViewController()
    
    var check_times=[1,2,3,4,5,6,7,8,9,10];
    let check_result=["正常","小异变","异变","大异变"]
    let conceive_times=[1,2,3,4,5,6,7,8,9,10]
    let first_haschild_age=[16,17,18,19,20,21,22,23,24,25]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        alertPicker.delegate=self
        alertPicker.dataSource=self
        alertPicker.mUIViewController=self
        alertPicker.mViewControllerDelegate=self
        
        initHarvardCheckMenuData()
        initSelfData()
        
        tableBaseInof2.dataSource=self
        tableBaseInof2.delegate=self
    }
    
    func initSelfData(){
    
        selfData=(data!.allValues[HFCHECK_MENU_SECTION] as! NSDictionary)
    
    
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
        println("tableView ---- --  ---click \(indexPath.row)");
        
        var indexId = indexPath.row + (1 * indexPath.section)
        
        if(indexPath.section == 0)
        {
            alertPicker.showPickerInActionSheet(indexPath.row);
        }
        else
        {
            alertPicker.showPickerInActionSheet(indexPath.row+2);
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (selfData!.allValues[section] as! NSArray).count
        
    }
        func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
    
            println("section =\(section)");
           return selfData?.allKeys[section] as! String
        }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 2
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
        let cell=tableView.dequeueReusableCellWithIdentifier(harvardBaseInfoCellTag, forIndexPath: indexPath)
            as? UITableViewCell
        
        
        
        //        var lable=cell!.viewWithTag(TAG_CELL_LABLE) as? UILabel
        //         lable.text=(data!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String
        var label=cell?.textLabel?.text=(selfData!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String;
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
    */
    

}

extension HarvardCheckBaseInfo2VC:UIPickerViewDataSource
{
    func numberOfComponentsInPickerView(pickerView:UIPickerView) ->Int
    {
        return 1;
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if(pickerView.tag==0){
            
            return check_times.count
        }
        else if(pickerView.tag == 1){
            
            
            return self.check_result.count
            
        } else if(pickerView.tag == 2){
            
            
            return self.conceive_times.count
            
        } else if(pickerView.tag==3){
            return self.first_haschild_age.count
        }
        else{
            return 0
        }
        
    }
}

extension HarvardCheckBaseInfo2VC:UIPickerViewDelegate{
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if(pickerView.tag == 0){
            
            return "\(check_times[row])"
        }
            
        else if(pickerView.tag == 1){
            return "\(self.check_result[row] )"
        } else if(pickerView.tag == 2){
            
            
            return "\(self.conceive_times[row])"
            
        }
        else if(pickerView.tag==3){
            return "\(self.first_haschild_age[row])"
        }
        else  {
            
            return "";
            
        }
        
    }
    //
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 0){
            println("you selected the name: \(self.check_times[row])")
        }
            
        else if(pickerView.tag == 1){
            println("you selected the name: \(self.check_result[row])")
        } else if (pickerView.tag == 2){
            println("you selected the name: \(self.conceive_times[row])")
        }
        else if(pickerView.tag==3){
            println("you selected the name: \(self.first_haschild_age[row])")
        }
        
    }
}

extension HarvardCheckBaseInfo2VC:AlertPickerViewControllerDelegate{
    func didSelect(){
        println("didSelect")
    }
    func didCancel()
    {
        println("didCancel")
    }
}

