//
//  User.swift
//  iBreast
//
//  Created by 钟其鸿 on 15/7/17.
//  Copyright (c) 2015年 钟其鸿. All rights reserved.
//

import Foundation
import CoreData
@objc(User)
class User: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var password: String
    @NSManaged var birthday: NSDate
    @NSManaged var nickname: String
    @NSManaged var isInClimacterium: NSNumber
    @NSManaged var imageUrl: String
    @NSManaged var gender: NSNumber
    @NSManaged var local: String

}
