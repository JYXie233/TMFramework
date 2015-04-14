//
//  EmptyView.h
//  TmFramework
//
//  Created by Tom on 15/4/13.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PathAnimationDemo.h"
@interface EmptyView : UIView
@property (weak, nonatomic) IBOutlet PathAnimationDemo *pathView;
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;

@end
