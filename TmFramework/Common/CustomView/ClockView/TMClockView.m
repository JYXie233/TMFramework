//
//  TMClockView.m
//  TmFramework
//
//  Created by Tom on 15/4/18.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "TMClockView.h"
#import "ColorMacro.h"
@implementation TMClockView{
    NSTimer * timer;
    CAShapeLayer * secondLayer;
    CAShapeLayer * hoursLayer;
    CAShapeLayer * minsLayer;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self install];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self install];
    }
    return self;
}
double radians(float degrees) {
    return ( degrees * M_PI ) / 180.0;
}

-(void)tick {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hoursAngle = (components.hour / 12.0) *M_PI * 2.0;
    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secsAngle = radians(360 / 60 * components.second );
    NSLog(@"%f  %i", secsAngle, components.second);

    [self startAnimationWithLayer:hoursLayer forAngle:hoursAngle];
    [self startAnimationWithLayer:minsLayer forAngle:minsAngle];
    [self startAnimationWithLayer:secondLayer forAngle:secsAngle];
}

-(void)startAnimationWithLayer:(CALayer*)layer forAngle:(CGFloat)angle{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 1.;
    NSArray *frameValues = [NSArray arrayWithObjects:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(angle, 0, 0, 1)],nil];
    animation.values = frameValues;
    [layer addAnimation:animation forKey:nil];
}

-(void)install{
    _centerColor = UIColorFromRGB(0xdbdbdb);
    _outColor = UIColorFromRGB(0xeeeeee);
    secondLayer = [CAShapeLayer layer];
    secondLayer.backgroundColor = [UIColor blackColor].CGColor;
    secondLayer.anchorPoint = CGPointMake(0.0, 1.);
    [self.layer addSublayer:secondLayer];
    hoursLayer = [CAShapeLayer layer];
    hoursLayer.backgroundColor = [UIColor blackColor].CGColor;
    hoursLayer.anchorPoint = CGPointMake(0.0, 1.);
    [self.layer addSublayer:hoursLayer];
    minsLayer = [CAShapeLayer layer];
    minsLayer.backgroundColor = [UIColor blackColor].CGColor;
    minsLayer.anchorPoint = CGPointMake(0.0, 1.);
    [self.layer addSublayer:minsLayer];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self tick];
}

-(void)layoutSubviews{
    CGRect currentBounds = self.bounds;
    secondLayer.frame = CGRectMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds), 1, - currentBounds.size.width / 2 + 25);
    minsLayer.frame = CGRectMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds), 1, - currentBounds.size.width / 2 + 40);
    hoursLayer.frame = CGRectMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds), 1, - currentBounds.size.width / 2 + 50);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect currentBounds = self.bounds;
    
    CGContextSaveGState(context);
    CGContextClipToRect(context, rect);

    CGGradientRef backgroundGradient;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    const CGFloat *start =CGColorGetComponents(_centerColor.CGColor);
    const CGFloat *end =CGColorGetComponents(_outColor.CGColor);
    CGFloat components[8] = { start[0], start[1], start[2], start[3], // Start color
        end[0], end[1], end[2], end[3]
    }; // End color
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    backgroundGradient = CGGradientCreateWithColorComponents (rgbColorspace, components, locations, num_locations);
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
    CGContextDrawRadialGradient (context, backgroundGradient, centerPoint, 0.0, centerPoint, currentBounds.size.width / 2, kCGGradientDrawsBeforeStartLocation);
    CGContextSetShouldAntialias(context, YES);
    CGGradientRelease(backgroundGradient);
    
    CGFloat borderWidth = 2;
    CGFloat graduationOffset = 1;
    CGFloat graduationLength = 20;
    for (int i = 0; i<60; i++) {
       
        
        CGPoint P1 = CGPointMake((self.frame.size.width/2 + ((self.frame.size.width - borderWidth*2 - graduationOffset) / 2) * cos((6*i)*(M_PI/180)  - (M_PI/2))), (self.frame.size.width/2 + ((self.frame.size.width - borderWidth*2 - graduationOffset) / 2) * sin((6*i)*(M_PI/180)  - (M_PI/2))));
        CGPoint P2 = CGPointMake((self.frame.size.width/2 + ((self.frame.size.width - borderWidth*2 - graduationOffset - graduationLength) / 2) * cos((6*i)*(M_PI/180)  - (M_PI/2))), (self.frame.size.width/2 + ((self.frame.size.width - borderWidth*2 - graduationOffset - graduationLength) / 2) * sin((6*i)*(M_PI/180)  - (M_PI/2))));
        
        CAShapeLayer  *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        shapeLayer.path = path1.CGPath;
        [path1 setLineWidth:1];
        [path1 moveToPoint:P1];
        [path1 addLineToPoint:P2];
        path1.lineCapStyle = kCGLineCapSquare;
        [[UIColor blackColor] set];
        
        [path1 strokeWithBlendMode:kCGBlendModeNormal alpha:1.];
    }

}


@end
