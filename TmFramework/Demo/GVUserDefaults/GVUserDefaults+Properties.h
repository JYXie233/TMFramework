//
//  TMUserDefaults+(Properties).h
//  TmFramework
//
//  Created by Tom on 15/4/12.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GVUserDefaults.h"
@interface GVUserDefaults (Properties)
@property (nonatomic, weak) NSString *userName;
@property (nonatomic, weak) NSNumber *userId;
@property (nonatomic) NSInteger integerValue;
@property (nonatomic) BOOL boolValue;
@property (nonatomic) float floatValue;
@end