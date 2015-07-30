//
//  GuideViewController.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/29.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController,UIScrollViewDelegate  {

    var scrollView:UIScrollView!
    var pageControl:UIPageControl!
    var startBtn:UIButton!
    
    var size = DeviceInfo.getDeviceSize()
    
    override func viewDidLoad() {
        loadLayout()
    }
    //scrollview委托
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset=scrollView.contentOffset
        pageControl.currentPage=Int(offset.x/size.width)
        if(pageControl.currentPage==2){
            startBtn.hidden=false
        }else{
            startBtn.hidden=true
        }
    }
    
    func loadLayout(){
        
        scrollView=UIScrollView(frame: CGRectMake(0, 0, size.width, size.height))
        scrollView.pagingEnabled=true
        scrollView.showsHorizontalScrollIndicator=false
        scrollView.showsVerticalScrollIndicator=false
        scrollView.contentSize=CGSizeMake(3*size.width,size.height)
        for i in 1...3{
            var image=UIImage(named: "Guideline-\(i)")
            var imageView=UIImageView(image: image)
            imageView.frame=CGRectMake(CGFloat((i-1))*size.width, 0, size.width, size.height)
            imageView.contentMode = UIViewContentMode.ScaleToFill
            scrollView.addSubview(imageView)
            
        }
        pageControl=UIPageControl(frame: CGRectMake(size.width/2-100, size.height-100, 200, 100))
        startBtn=UIButton(frame: CGRectMake(size.width/2-60, size.height/2+150, 120, 35))
        
        pageControl.numberOfPages=3;
        pageControl.currentPage=0
        
        startBtn.setTitle("马上体验", forState: UIControlState.Normal)
        startBtn.setBackgroundImage(UIImage(named: "StartButton"), forState: UIControlState.Normal)
        startBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        startBtn.addTarget(self, action: "guideOver", forControlEvents: UIControlEvents.TouchUpInside)
        startBtn.hidden=true
        
        
        scrollView.bounces=false
        scrollView.delegate=self
        self.view.addSubview(scrollView)
        //self.view.addSubview(pageControl)
        self.view.addSubview(startBtn)
    }
    //开始使用app
    func guideOver(){
        
        var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewCtrl:UITabBarController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! UITabBarController
        var mainVC=UINavigationController(rootViewController: UITableViewController())
        self.presentViewController(viewCtrl, animated: true, completion: nil)
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
