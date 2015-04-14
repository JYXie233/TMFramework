//
//  APPUtils.h
//  TmFramework
//
//  Created by Tom on 15/4/12.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPUtils : NSObject

+(void)showInfo:(NSString*)msg;

+(void)showError:(NSString*)msg;

+(void)showSuccess:(NSString*)msg;

+(void)showProgress;

+(void)dismissProgress;

@end
