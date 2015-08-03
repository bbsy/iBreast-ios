//
//  HarvarCheckFamilyInfoVC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/9.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

var mHarvardCheckModel:HarvardCheckModel!

class SectionRow{
    var section:Int = -1
    var row:Int = -1
    
    //0:表示选择的是血缘关系 1：选择的是癌症年龄和癌症名字,-Int.max:表示该选择无效
    var tag:Int = -1
}

class HarvarCheckFamilyInfoVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var familyInfos:[HarvardCheckModel.HarvardCheckFamilyInfo]?
    //0 表示选择血缘关系， 1 把表示选择癌症和年纪
    var tag:Int = 0
    var age:[Int]=[Int]()
    let pickerAlert:AlertPickerViewController=AlertPickerViewController()
    var sectionRow = SectionRow()
    var bloodline:String!
    var relationship:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        mHarvardCheckModel=HarvardCheckModel()
        
        mHarvardCheckModel?.initData()
        
        familyInfos=mHarvardCheckModel?.familyInfos
        
        pickerAlert.dataSource = self
        pickerAlert.delegate = self
        pickerAlert.mUIViewController = self
        pickerAlert.mViewControllerDelegate=self
        
        
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

var cancer = "";
var ageTemp = 10;
var sectionId = 0;
extension HarvarCheckFamilyInfoVC:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        println("row: \(indexPath.row) , section: \(indexPath.section)")
        
        //点击了已固定存在的section组
        if(indexPath.section<familyInfos?.count)
        {
            if(indexPath.row==familyInfos![indexPath.section]._cancerCount-1)
            {//增加一行癌症历史
                println("add new item in the section")
                tag = 1
                sectionId = indexPath.section;
                
                var newItem=familyInfos![indexPath.section]
                newItem.addCancer("第\(familyInfos![indexPath.section]._cancerCount)次癌症", age:20)
                
                
                tableView.reloadData()
                
                resetSectionRow()
                //pickerAlert.showPickerInActionSheet(indexPath.row)
            }
            else if(indexPath.row == 0){//选择血缘关系
                tag = 0
                
                
                sectionRow.tag = 0
                
                pickerAlert.showPickerInActionSheet(indexPath.row)
            }
            else {//选择癌症历史
                tag = 1
                sectionRow.tag = 1
                pickerAlert.showPickerInActionSheet(indexPath.row)
                
            }
            sectionRow.row = indexPath.row
            sectionRow.section = indexPath.section
        }
            // 点击了固定section之外的增加
        else{
            var family=HarvardCheckModel.HarvardCheckFamilyInfo(relationship: "self",bloodline: "mother",cancerName: "brain",age: 20)
            familyInfos!.append(family)
            
            
            //family.addCancer("乳腺癌", age:18)
            
            
            resetSectionRow()
            
            tableView.reloadData()
            
        }
    }
    
    func resetSectionRow(){
        sectionRow.row = -Int.max
        sectionRow.section = -Int.max
        sectionRow.tag = -Int.max
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
        return cell!
    }
    
    // tabview的section组个数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is
    {
        //最后一个是“增加”项
        return familyInfos!.count+1
    }
}


// 选择（确定）和取消按钮的事件将在此触发
extension HarvarCheckFamilyInfoVC:AlertPickerViewControllerDelegate{
    func didSelect(){
        println("didSelect")
        
        //        var newItem=familyInfos![sectionId]
        //        newItem.addCancer(cancer,age:ageTemp)
        //
        //tableView.reloadData()
        //tableBaseInof2.reloadData();
        
        if(sectionRow.tag == -Int.max){
            return
        }
        else{
            
            if(sectionRow.tag == 0){
                //选择的是血缘关系
                //
                var newItem=familyInfos![sectionRow.section]
                //
                newItem._relationship = relationship
                newItem._bloodline = bloodline
                
            }
            else if(sectionRow.tag == 1){
                //选择的是癌症历史
                
                var newItem=familyInfos![sectionRow.section]
                
                newItem._age[sectionRow.row] = ageTemp
                newItem._cancerName[sectionRow.row] = cancer
                
                
                //  newItem.addCancer("第\(familyInfos![indexPath.section]._cancerCount)次癌症", age:20)
            }
            tableView.reloadData()
        }
    }
    func didCancel()
    {
        println("didCancel")
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
        
        if(component == 0)
        {
            if(tag == 1){
                cancer = "\(mHarvardCheckModel.cancersForSelf[row])"
            }
            else{
                relationship = mHarvardCheckModel.relationShips[row];
            }
            
        }
        else
        {
            if(tag == 1){
                ageTemp = mHarvardCheckModel.age[row]
            }
            else{
                bloodline = "\(mHarvardCheckModel.bloodLines[row])"
            }
            
        }
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
