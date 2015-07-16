//
//  HarvardCheckBaseInfo3VC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/3.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class HarvardCheckBaseInfo3VC: UIViewController ,UITableViewDataSource{
    
    @IBOutlet weak var tableBaseInfo3: UITableView!
    
    let HFCHECK_MENU_SECTION=0
    let harvardBaseInfoCellTag:String="hfcheckBI3TableCell"
    var selfData:NSDictionary?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        initHarvardCheckMenuData()
        initSelfData()
        
        tableBaseInfo3.dataSource=self
    }
    
    func initSelfData(){
        
        selfData=(data!.allValues[HFCHECK_MENU_SECTION] as! NSDictionary)
        
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return (selfData!.allValues[section] as! NSArray).count
        
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        
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
    
}
