//
//  SelfExamDirection.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/29.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamDirection: UIViewController {

    
    var webView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var frameRect = UIApplication.sharedApplication().statusBarFrame
       
        var rect = UIScreen.mainScreen().bounds;
        var size = rect.size;
        var width = size.width;
        var height = size.height;
        
        println("width: \(width) ,height: \(height)")
        
        webView = UIWebView(frame: CGRectMake(0, 0, width, height))
        self.view.addSubview(webView)
        
        loadWeb()
    }
    
    func loadWeb(){
        var webString = "http://www.baidu.com"
        
        var url = NSURL(string:webString)
        
        var request:NSURLRequest = NSURLRequest(URL:url!)
        
        webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
