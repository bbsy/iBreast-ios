//
//  NewsUI.swift
//  iBreast
//
//  Created by 许仕永 on 15/7/31.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation
import UIKit

class NewsUI: UIViewController,HttpObjectMapper,HttpCallBack
{
    @IBOutlet weak var tableview: UITableView!
    var clinics:[ClinicBriefModel] = [ClinicBriefModel]()
    
//    @IBOutlet weak var newsTableView: UITableView!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self;
        
        
        var httpRequest = HttpRequest()
        httpRequest.mapKey="history"
        httpRequest.objMapper = self
        httpRequest.callback = self
        httpRequest.urlRequest = URLRouter.Router.PopularClinics(0, 10)
        
        var http = HttpObject()
        
        http.fetch(httpRequest)
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
            
            //self.tabview.reloadData()
        }
        
    }

    
}


extension NewsUI:UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell=tableView.dequeueReusableCellWithIdentifier("news_item", forIndexPath: indexPath)
            as? UITableViewCell
        return cell!;
    }
}


extension NewsUI:UITableViewDelegate
{
    
}