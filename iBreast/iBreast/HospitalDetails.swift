//
//  HospitalDetails.swift
//  iBreast
//
//  Created by 许仕永 on 15/8/8.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class HospitalDetails: UIViewController,HttpObjectMapper,HttpCallBack {
    
    @IBOutlet weak var hospital_name: UILabel!
    @IBOutlet weak var hospital_image: UIImageView!
    @IBOutlet weak var hospital_address: UITextView!

    // 定义数据模型对象
    var clinics:[ClinicBriefModel] = [ClinicBriefModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var httpRequest = HttpRequest()
        httpRequest.mapKey="history"
        httpRequest.objMapper = self
        httpRequest.callback = self
        httpRequest.urlRequest = URLRouter.Router.PopularClinics(0, 10)
        
        hospital_address.editable = false;

        var http = HttpObject()
        
        http.fetch(httpRequest)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    // 加载完成后的回调方法
    func callback(result:AnyObject){
        println("--------------------\(result)")
        
        
        
        let imageURL = clinics[0].imageUrl
        
        dispatch_async(dispatch_get_main_queue()){
        Alamofire.request(.GET, imageURL).response() {
            (_, _, data, _) in
            
            let image = UIImage(data: data! as! NSData)
            self.hospital_image.image = image;
        }
        
        self.hospital_name.text = self.clinics[0].name;
        self.hospital_address.text = self.clinics[0].address;
        //        tabview.reloadData()
        }
    }

}
