//
//  HarvardCheckResultVC.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/9.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit


var harvardResultData:NSDictionary?

class HarvardCheckResultVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var timer:NSTimer!
    
    var  activityIndicatorView:UIActivityIndicatorView!
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        tableView.dataSource=self
        tableView.delegate=self
        
        
        
        RiskCalcHttp.sharedInstance.wrapHormoneReplacementTherapy(harvardExamModel.hormoneReplacementTherapy)
        
        RiskCalcHttp.sharedInstance.printRisk()
        
        AZNotification.showNotificationWithTitle("该结果暂为测试数据，无科学依据", controller: self, notificationType: .Success, shouldShowNotificationUnderNavigationBar: true)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "stopLoading:", userInfo: nil, repeats: false)
        
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle:UIActivityIndicatorViewStyle.Gray)
        activityIndicatorView.frame = CGRectMake(140.0, 220.0, 40.0, 40.0)
        activityIndicatorView.startAnimating()
        self.view.addSubview(activityIndicatorView)
        
        
    }
    
    func stopLoading(sender:AnyObject?){
        
        activityIndicatorView.stopAnimating()
        
        var resultViewController = HarvardCheckResultVC()
        
        //self.navigationController!.pushViewController(resultViewController, animated:true)
        
    }

    
    func showAzNotification(sender :AnyObject)
    {
        var button = sender as! UIButton
        
        switch button.tag
        {
        case 1 :
            AZNotification.showNotificationWithTitle("Success", controller: self, notificationType: .Success, shouldShowNotificationUnderNavigationBar: true)
        case 2:
            AZNotification.showNotificationWithTitle("Opps something went wrong", controller: self, notificationType: .Error, shouldShowNotificationUnderNavigationBar: true)
            
        default :
            AZNotification.showNotificationWithTitle("Success", controller: self, notificationType: .Success, shouldShowNotificationUnderNavigationBar: true)
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

//}
//
//extension HarvardCheckResultVC:UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        if(indexPath.row==0){
            return 140
        }
        else if(indexPath.row==1)
        {
            return 120
        }
        else if( indexPath.row==2){
            return 130
        }
        return 40
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
       return  3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier0="harvardResultCell0";
        let cellIdentifier1="harvardResultCell1";
        let cellIdentifier2="harvardResultCell2";
        
        var cell:UITableViewCell?
        
        if(indexPath.section==0){
            if(indexPath.row==0){
                cell=tableView.dequeueReusableCellWithIdentifier(cellIdentifier0) as? UITableViewCell
            }
            else if(indexPath.row==1){
                cell=tableView.dequeueReusableCellWithIdentifier(cellIdentifier1) as? UITableViewCell
            }
            if(indexPath.row==2){
                cell=tableView.dequeueReusableCellWithIdentifier(cellIdentifier2) as? UITableViewCell
            }
            
        }
            
        else{
            
            
            var c=tableView.dequeueReusableCellWithIdentifier(cellIdentifier0)
            
            if c != nil
            {
                cell = c as! UITableViewCell
            }
            
        }
        
        
        
        return cell!
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is
    {
        return 1
    }

    
}
