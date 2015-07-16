//
//  HarvarCheckFamilyInfoVC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/9.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

var mHarvardCheckModel:HarvardCheckModel?

class HarvarCheckFamilyInfoVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var familyInfos:[HarvardCheckModel.HarvardCheckFamilyInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       
        
        mHarvardCheckModel=HarvardCheckModel()
        
        mHarvardCheckModel?.initData()
        
        familyInfos=mHarvardCheckModel?.familyInfos
        
        tableView.dataSource=self
        tableView.delegate=self
        
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
