//
//  About.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/8/4.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class About: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController!.title = "关于我们"
//        
//        var webView:UIWebView = UIWebView(frame:CGRect(x: 0,y: 0,width: 320,height: 400))
//        
//        self.view.addSubview(webView)
//        
//        webView.scalesPageToFit = true
//        
//        
//        let wordPath:String? = NSBundle.mainBundle().pathForResource("aboutus", ofType: "docx")
//        
//        
//        let wordUrl:NSURL = NSURL(string: wordPath!)!
//        
//        let wordRequest:NSURLRequest = NSURLRequest(URL:wordUrl)
//        
//        
//        webView.loadRequest(wordRequest)
        
        var aboutImg = UIImage(named: "about")
        
        var aboutImageView = UIImageView(frame: CGRectMake(0
            , 65, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height-100))
        aboutImageView.contentMode =  UIViewContentMode.ScaleToFill
        
        aboutImageView.image = aboutImg
        
        self.view.addSubview(aboutImageView)
        
        
        
        
    }

}
