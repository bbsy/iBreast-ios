//
//  HarvarCheckFamilyInfoVC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/9.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

var mHarvardCheckModel:HarvardCheckModel!

class HarvarCheckFamilyInfoVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var familyInfos:[HarvardCheckModel.HarvardCheckFamilyInfo]?
    //0 表示选择血缘关系， 1 把表示选择癌症和年纪
    var tag:Int = 0
    var age:[Int]=[Int]()
    let pickerAlert:AlertPickerViewController=AlertPickerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
        
        mHarvardCheckModel=HarvardCheckModel()
        
        mHarvardCheckModel?.initData()
        
        familyInfos=mHarvardCheckModel?.familyInfos
        
        pickerAlert.dataSource = self
        pickerAlert.delegate = self
        pickerAlert.mUIViewController = self
        
        tableView.dataSource=self
        tableView.delegate=self
        
        
        
                for i in 1...108 {
                    age.append(i)
        
                }
    
        
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

extension HarvarCheckFamilyInfoVC:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        println("row: \(indexPath.row) , section: \(indexPath.section)")
        
        if(indexPath.section<familyInfos?.count)
        {
            if(indexPath.row==familyInfos![indexPath.section]._cancerCount-1)
            {
                println("add new item in the section")
                
                var newItem=familyInfos![indexPath.section]
                newItem.addCancer("第\(familyInfos![indexPath.section]._cancerCount)次癌症", age:20)
                
                tableView.reloadData()
                
            }
            else if(indexPath.row == 0){//选择血缘关系
                 tag = 0
                 pickerAlert.showPickerInActionSheet(indexPath.row)
            }
            else {//选择癌症历史
                tag = 1
                pickerAlert.showPickerInActionSheet(indexPath.row)
            }
        }
        else{
            var family=HarvardCheckModel.HarvardCheckFamilyInfo(relationship: "self",bloodline: "mother",cancerName: "brain",age: 20)
            familyInfos!.append(family)
            
           
            family.addCancer("乳腺癌", age:18)
            

            
            
            tableView.reloadData()

        }
    }
    
     func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 40
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
        
        if(section >= familyInfos?.count){
              return 1
        }
        
        else{
            return familyInfos![section]._cancerCount
        }
        
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let indentifierAdd="harvardCheckCellAdd"
        
        let indentifierDetail="harvardCheckCellDetail"
        
        var cell:UITableViewCell?
        
        
        if(indexPath.section < familyInfos!.count){
            
            var count = familyInfos![indexPath.section]._cancerCount
            
            
            if(indexPath.row==count-1){
                 cell=tableView.dequeueReusableCellWithIdentifier(indentifierAdd) as! UITableViewCell
            }
            else {
                 cell=tableView.dequeueReusableCellWithIdentifier(indentifierDetail) as! UITableViewCell
                
                
                //第一个表示个人关系
                if(indexPath.row==0){
                    var bloodline=cell?.detailTextLabel
                    
                    bloodline?.text=familyInfos![indexPath.section]._bloodline
                    
                    
                    var relationship=cell?.textLabel
                    
                    relationship?.text=familyInfos![indexPath.section]._relationship
                    
                }
                else {
                    
                  
                        var cancer=cell?.textLabel
                        
                        cancer?.text=familyInfos![indexPath.section]._cancerName![indexPath.row]
                        
                        var bloodline=cell?.detailTextLabel
                        
                        bloodline!.text="\(familyInfos![indexPath.section]._age![indexPath.row])"
                    

                }
            }

        }
        else{
                  cell=tableView.dequeueReusableCellWithIdentifier(indentifierAdd) as! UITableViewCell
            
            
        }
//        
//        cell=tableView.dequeueReusableCellWithIdentifier(indentifierAdd) as! UITableViewCell
        
        
        return cell!
        
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is
    {
        //最后一个是“增加”项
        return familyInfos!.count+1
    }
}

extension HarvarCheckFamilyInfoVC:UIPickerViewDataSource ,UIPickerViewDelegate{
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        
        return 2
        
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if(component==0)
        {
            if(tag == 1){
             return mHarvardCheckModel.cancersForSelf.count
            }
            else {
                return mHarvardCheckModel.relationShips.count
            }
        }
        else
        {
            if(tag == 1){
                return age.count;
            }
            else {
                return mHarvardCheckModel.bloodLines.count
            }
        }
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        if(component==0)
        {
            if(tag == 1){
                return mHarvardCheckModel.cancersForSelf[row];
            }
            else{
                return mHarvardCheckModel.relationShips[row];
            }
            
        }
        else
        {
             if(tag == 1){
                return "\(age[row])"
            }
             else{
                 return "\(mHarvardCheckModel.bloodLines[row])"
            }
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        println("component: \(component), row: \(row)")
    }
    //设置行的长度
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat{
        if(component == 0){
            if(tag == 1){
                return 240
            }
            else {
                return 150
            }
        }
        else {
            if(tag == 1){
                
                return 60
            }
            else {
                return 150
            }

        }
    }
}
