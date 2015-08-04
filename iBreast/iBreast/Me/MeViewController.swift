//
//  MeViewController.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/8.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

var meData:NSDictionary?

class MeViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var userManager:UserManager = UserManager()
    
    var alertPicker:AlertDatePickerView = AlertDatePickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRecordMenuData()
        tableView.dataSource=self
        tableView.delegate=self
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        
//        userManager.save();
//        
//        
//        println(UserManager.getUser())
//        
//        var selfExamService =  SelfExamHisService()
//        var httpRequest = HttpRequest()
//        httpRequest.mapKey="productlist"
//        httpRequest.objMapper = selfExamService
//        httpRequest.callback = selfExamService
//        httpRequest.urlRequest = URLRouter.Router.PopularPhotos(0)
//        
//        var http = HttpObject()
//       
//        http.fetch(httpRequest)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initRecordMenuData(){
        
        if meData==nil
        {
            var pathStr = NSBundle.mainBundle().pathForResource("MeMenuList", ofType:"plist")
            if let newPathStr = pathStr //pathStr可能为nil
            {
                meData = NSDictionary(contentsOfFile: newPathStr);
                
            }
        }
        
    }

   
}

extension MeViewController:UITableViewDataSource,UITableViewDelegate{
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
       // alertPicker.showPickerInActionSheet(indexPath.row)
        
        if(indexPath.section == 0) {
            if(indexPath.row==0){
                
            }
            else if(indexPath.row==1){
                
            }
            else if(indexPath.row==2){
                
            }
            else if(indexPath.row==3){
                
            }
        }
        else if(indexPath.section == 1)
        {
            if(indexPath.row==0){
                
            }
            else if(indexPath.row==1){
                
                let myStoryBoard = self.storyboard
                let anotherView:UIViewController = myStoryBoard?.instantiateViewControllerWithIdentifier("about")! as! UIViewController
                
                self.navigationController!.pushViewController(anotherView, animated: true)
                
              //  self.presentViewController(anotherView, animated: true, completion: nil)
                
                
            }
            else if(indexPath.row==2){
                
            }
            else if(indexPath.row==3){
                
            }

            
        }
        else if(indexPath.section == 2){
            
        }
        
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        if( indexPath.section==0 && indexPath.row==0){
            return 150
        }
        else
        {
            return 40
        }
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if(section==0){
            return 0
        }
        return CGFloat(20)
        
    }
//     func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
//        return CGFloat(40)
//    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
        return (meData!.allValues[section] as! NSArray).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        
        let cellIdentifier="meTableViewCellIdentifierKey";
        let cellIdentifierForFirstRow="meTableViewCellIdentifierKeyInfo";
        
        var cell:UITableViewCell?
        
        if(indexPath.section==0){
            if(indexPath.row==0){
                cell=tableView.dequeueReusableCellWithIdentifier(cellIdentifierForFirstRow) as? UITableViewCell
            }
            else{
                var c=tableView.dequeueReusableCellWithIdentifier( cellIdentifier)
                
                if c != nil{
                    cell = c as! UITableViewCell
                }
            }
            
            
        }
            
        else{
            
            
            var c=tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
            
            if c != nil
            {
                cell = c as! UITableViewCell
            }
            
        }
        
        if(cell==nil){
            
            if(indexPath.section==2 && indexPath.row==0){
                cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifierForFirstRow)
                //
                //                var sw=UISwitch()
                //                sw.addTarget(self, action: "onNoticeValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
                //                cell?.accessoryView=sw
            }
                
            else{
                cell=UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
            }
        }
        
        if(indexPath.section==0 && indexPath.row==0 ){
            cell?.accessoryType=UITableViewCellAccessoryType.None
            
            var name=cell?.viewWithTag(101) as! UILabel
            name.text="林志玲"
        }
        else{
            
            //
            var label=cell?.textLabel?.text=(meData!.allValues[indexPath.section] as! NSArray).objectAtIndex(indexPath.row) as! String;
            //
            
            
            
            cell?.detailTextLabel?.text=String(indexPath.row)
        }
        
        
        
        
        return cell!
      
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is
     {
          return (meData?.allKeys as! NSArray).count
     }
}
