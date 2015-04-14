//
//  APPUtils.m
//  TmFramework
//
//  Created by Tom on 15/4/12.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "APPUtils.h"
#import <SVProgressHUD.h>
@implementation APPUtils

+(void)showError:(NSString *)msg{
    [SVProgressHUD showErrorWithStatus:msg];
}

+(void)showInfo:(NSString *)msg{
    [SVProgressHUD showInfoWithStatus:msg];
}

+(void)showSuccess:(NSString *)msg{
    [SVProgressHUD showSuccessWithStatus:msg];
}

+(void)showProgress{
    [SVProgressHUD show];
}

+(void)dismissProgress{
    [SVProgressHUD dismiss];
}

@end
