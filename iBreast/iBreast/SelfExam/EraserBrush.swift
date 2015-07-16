//
//  EraserBrush.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/5.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import UIKit

class EraserBrush: PencilBrush {
    
    override func drawInContext(context: CGContextRef) {
        
        CGContextSetBlendMode(context, kCGBlendModeClear);
        
        super.drawInContext(context)
    }
   
}
