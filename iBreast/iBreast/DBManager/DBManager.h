//
//  DBManager.h
//  SwiftWithOC
//
//  Created by yfs on 14-12-11.
//  Copyright (c) 2014年 yfs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DBManager : NSObject
{
    NSString * _name;
}

@property (nonatomic, readonly) FMDatabase * dataBase;  // 数据库操作对象
/// 单例模式
+(DBManager *) defaultDBManager;

// 关闭数据库
- (void) close;

@end
