//
//  Appointment.swift
//  iBreast
//
//  Created by 许仕永 on 15/7/19.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class  Appointment:UIViewController,HttpObjectMapper,HttpCallBack {
    //appointmentCell
    
    @IBOutlet weak var tabview: UITableView!
    
    var clinics:[ClinicBriefModel] = [ClinicBriefModel]()
    var alter:UIAlertView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabview.dataSource = self
        
        
        var httpRequest = HttpRequest()
        httpRequest.mapKey="history"
        httpRequest.objMapper = self
        httpRequest.callback = self
        httpRequest.urlRequest = URLRouter.Router.PopularClinics(0, 10)
        
        var http = HttpObject()
        
        http.fetch(httpRequest)
        
        if(alter == nil )
        {
            alter = UIAlertView(title: "提示", message: "正在加载门诊医院，请稍后", delegate: nil, cancelButtonTitle: "知道了")
         
        }
        alter.show()


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    func objectMap(data:AnyObject)->AnyObject?{
        
        var obj = data as! NSDictionary
        
        var time = NSDate()
        
        var model = ClinicBriefModel()
        model.id = obj.valueForKey("id") as! Int
        model.name = obj.valueForKey("name") as! String
        model.address = obj.valueForKey("address") as! String
        model.imageUrl = obj.valueForKey("imgageUrl") as! String
        
        

        
        println("id:\(model.id) , name:\(model.name) , address:\(model.address) , imageUrl: \(model.imageUrl)")
        
        clinics.append(model)
        
        return model
    }
    
    func callback(result:AnyObject){
        println("\(result)")
        
        
        dispatch_async(dispatch_get_main_queue()){
            
             self.tabview.reloadData()
             self.alter.dismissWithClickedButtonIndex(0, animated: true)
        }
      
    }

}


extension Appointment:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return clinics.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "appointmentCell"
        
        var cell:UITableViewCell!
        
        var c = self.tabview.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if(c == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
        }
        else {
            cell = c as! UITableViewCell
        }
        
        var name = cell.viewWithTag(101) as! UILabel
        
        name.text = clinics[indexPath.row].name
        
        var address = cell.viewWithTag(102) as! UILabel
        
        address.text = clinics[indexPath.row].address
        
        
         var pic = cell.viewWithTag(100) as! UIImageView
        
         pic.layer.cornerRadius = 8;
         pic.layer.masksToBounds = true;
        
        let imageURL = clinics[indexPath.row].imageUrl
        
            Alamofire.request(.GET, imageURL).response() {
                (_, _, data, _) in
            
                let image = UIImage(data: data! as! NSData)
                
               
                
                pic.image = image
        }

        
        
        
        //var model = selfExamHisList[indexPath.row] as SelfExamHisModel
        //
        //var title=cell.viewWithTag(200) as! UILabel
        //title.text="ssss"
        //
        //        var subTitle=cell.viewWithTag(101) as! UILabel
        //subTitle.text=model.detail
        
        
        //subTitle.text=dateStr
        
        
        
        var locale=NSLocale.currentLocale()
        let dateFormatt=NSDateFormatter.dateFormatFromTemplate("yyyy-mm-dd", options: 0, locale: locale)
        
        let dateFormatter=NSDateFormatter()
        dateFormatter.dateFormat=dateFormatt
        
        //let dateStr=dateFormatter.stringFromDate(model.time)
        
        
        return cell
        
    }
}
