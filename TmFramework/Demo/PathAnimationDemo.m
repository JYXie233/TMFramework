//
//  PathAnimationDemo.m
//  TmFramework
//
//  Created by Tom on 15/4/13.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "PathAnimationDemo.h"
#import <POP.h>
@implementation PathAnimationDemo{
    CAShapeLayer * shapeLayer;
}

-(void)awakeFromNib{
    shapeLayer = [CAShapeLayer layer];
}

-(void)layoutSubviews{
    [self startAnimation];
}

-(void)removeAnimation{
    shapeLayer.path = nil;
    [shapeLayer removeFromSuperlayer];
}

-(void)startAnimation{
    
    [self.layer addSublayer:shapeLayer];
    CAShapeLayer *layer = shapeLayer;
    layer.frame         = self.bounds;                // 与showView的frame一致
    layer.strokeColor   = [UIColor greenColor].CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    layer.lineCap       = kCALineCapSquare;               // 边缘线的类型
    layer.path          = [self makePath].CGPath;                    // 从贝塞尔曲线获取到形状
    layer.lineWidth     = 1.0f;                           // 线条宽度
    layer.strokeStart   = 0.0f;
    layer.strokeEnd     = 0.f;
    
    POPBasicAnimation * pathAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    pathAnimation.autoreverses = YES;
    pathAnimation.repeatForever = YES;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.duration = 3.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    
    [layer pop_addAnimation:pathAnimation forKey:nil];
}

-(UIBezierPath*)makePath{
    CGRect frame = self.bounds;

    UIBezierPath* starPath = UIBezierPath.bezierPath;
    [starPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48125 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.17500 * CGRectGetHeight(frame))];
    [starPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.54223 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34010 * CGRectGetHeight(frame))];
    [starPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64570 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39669 * CGRectGetHeight(frame))];
    [starPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.57992 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55532 * CGRectGetHeight(frame))];
    [starPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.58289 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75539 * CGRectGetHeight(frame))];
    [starPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.48125 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68833 * CGRectGetHeight(frame))];
    [starPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.37961 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75539 * CGRectGetHeight(frame))];
    [starPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.38258 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55532 * CGRectGetHeight(frame))];
    [starPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.31680 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39669 * CGRectGetHeight(frame))];
    [starPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.42027 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34010 * CGRectGetHeight(frame))];
    [starPath closePath];
    return starPath;
}

@end
