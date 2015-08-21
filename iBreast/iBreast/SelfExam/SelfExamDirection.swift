//
//  SelfExamDirection.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/29.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class SelfExamDirection: UIViewController {

    
    let imageSize:CGFloat = 200
    let imageOffsetX:CGFloat = 60
    let imageOffsetY:CGFloat = 100
    var scrollView:UIScrollView!
    var pageCtrl:UIPageControl!
    
    var webView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var frameRect = UIApplication.sharedApplication().statusBarFrame
       
        var rect = UIScreen.mainScreen().bounds;
        var size = rect.size;
        var width = size.width;
        var height = size.height;
        
        println("width: \(width) ,height: \(height)")
        
//        webView = UIWebView(frame: CGRectMake(0, 0, width, height))
//        self.view.addSubview(webView)
//        
//        loadWeb()
        
        layoutScrollPage()
    }
    func layoutScrollPage(){
        scrollView = UIScrollView(frame:CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height))
        //scrollView.backgroundColor = UIColor.grayColor()
        scrollView.pagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.delegate = self
        
        var pic1Image = UIImage(named: "se_1")
        //var bikeScaledImage = ImageUtil.scaleImage(bikeImage!,scaleSize:imageSize)
        
        var pic1ImageView = UIImageView(image:pic1Image)
        pic1ImageView.frame = CGRectMake(0, 0,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height)
        scrollView.addSubview(pic1ImageView)
        
        
        
        
        
        
        
        var pic2Image = UIImage(named: "se_2")
        var pic2ImageView = UIImageView(image:pic2Image)
        pic2ImageView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height)
        scrollView.addSubview(pic2ImageView)
        
        var pic3Image = UIImage(named: "se_3")
        var pic3ImageView = UIImageView(image:pic3Image)
        pic3ImageView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height*2,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height)
        scrollView.addSubview(pic3ImageView)
        
        var pic4Image = UIImage(named: "se_4")
        var pic4ImageView = UIImageView(image:pic4Image)
        pic4ImageView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height*3,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height)
        scrollView.addSubview(pic4ImageView)
        
        var pic5Image = UIImage(named: "se_5")
        var pic5ImageView = UIImageView(image:pic5Image)
        pic5ImageView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height*4,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height)
        scrollView.addSubview(pic5ImageView)
        
        var pic6Image = UIImage(named: "se_6")
        var pic6ImageView = UIImageView(image:pic6Image)
        pic6ImageView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height*5,UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height)
        scrollView.addSubview(pic6ImageView)
        
        
        
        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height*6)
        scrollView.indicatorStyle = UIScrollViewIndicatorStyle.White
        
        
        
        
        
        
        self.view.addSubview(scrollView)
        self.view.backgroundColor = UIColor.darkGrayColor()
        
        
        
        pageCtrl = UIPageControl(frame:CGRectMake(imageOffsetX, imageOffsetY+imageSize+10, imageSize, 60))
        
       // self.view.addSubview(pageCtrl)
        
        pageCtrl.numberOfPages = 6
        pageCtrl.currentPage = 0
        pageCtrl.addTarget(self, action: "pageTurn:", forControlEvents: UIControlEvents.ValueChanged)
        
        
        
        
    }
    
    func pageTurn(sender:AnyObject?){
        var pageCtrl = sender as! UIPageControl
        
        var index = pageCtrl.currentPage
        
        scrollView.contentOffset = CGPointMake(CGFloat((Int(UIScreen.mainScreen().bounds.size.height)*index)),0)
        
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
extension SelfExamDirection: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        var offY:CGFloat = scrollView.contentOffset.y
        
        var index:Int = (Int)(offY / UIScreen.mainScreen().bounds.size.height)
        
        pageCtrl.currentPage = index
    }
}
