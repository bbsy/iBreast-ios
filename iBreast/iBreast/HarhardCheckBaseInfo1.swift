//
//  HarhardCheckBaseInfo1.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/3.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

var data:NSDictionary?

func initHarvardCheckMenuData(){
    
    if data==nil
    {
        var pathStr = NSBundle.mainBundle().pathForResource("harvardMenuList", ofType:"plist")
        if let newPathStr = pathStr //pathStr可能为nil
        {
            data = NSDictionary(contentsOfFile: newPathStr);
            
        }
    }

}


class HarvardCheckBaseInfo1: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableMenu: UITableView!
    let harvardBaseInfoCellTag:String="hfcheckBI1TableCell"
    
    var age=[18,19,20,21,22,23,24];
    
    let weight=["20kg","30kg","40kg"]
    let gender=["男","女"]
    let height=["150cm","156cm","157cm"]
    
    var indexOfAllRows:Int=0
    
    let HFCHECK_MENU_SECTION=3
    
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
        
        tableMenu.dataSource=self
        tableMenu.delegate=self
        
        
        initHarvardCheckMenuData()
        initData()
    
     

    }
    
    func initData(){
        
       
        for var num:Int=18; num<100;++num{
          
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        indexOfAllRows=indexPath.row
        
        alertPicker.showPickerInActionSheet(indexOfAllRows)
        
        println("section:\(indexPath.section)>>>row:\(indexPath.row)")
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
    */

}

extension HarvardCheckBaseInfo1:UIPickerViewDataSource{
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if(pickerView.tag==0){
            
            return gender.count
        }
        else if(pickerView.tag == 1){
            
            
            return self.age.count
            
        } else if(pickerView.tag == 2){
            
            
            return self.weight.count
            
        } else if(pickerView.tag==3){
            return self.height.count
        }
        else{
             return 0
        }
        
    }
    
}


extension HarvardCheckBaseInfo1:UIPickerViewDelegate{
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if(pickerView.tag == 0){
            
            return gender[row]
        }
        
       else if(pickerView.tag == 1){
            return "\(self.age[row] )"
        } else if(pickerView.tag == 2){
            
            
            return self.weight[row]
            
        }
        else if(pickerView.tag==3){
            return self.height[row]
        }
        else  {
            
            return "";
            
        }
        
    }
    //
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 0){
         println("you selected the name: \(self.gender[row])")
        }
        
        else if(pickerView.tag == 1){
            println("you selected the name: \(self.age[row])")
        } else if (pickerView.tag == 2){
            println("you selected the name: \(self.weight[row])")
        }
        else if(pickerView.tag==3){
             println("you selected the name: \(self.height[row])")
        }
        
    }
}

extension HarvardCheckBaseInfo1:AlertPickerViewControllerDelegate{
    func didSelect(){
        println("didSelect")
    }
    func didCancel()
    {
        println("didCancel")
    }
}

