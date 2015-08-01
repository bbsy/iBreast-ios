//
//  NewsUI.swift
//  iBreast
//
//  Created by 许仕永 on 15/7/31.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation
import UIKit

class NewsUI: UIViewController
{
    
//    @IBOutlet weak var newsTableView: UITableView!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // newsTableView.dataSource = self;
        //newsTableView.delegate = self;
    }
    
    
    
}


extension NewsUI:UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1;
    }
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
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