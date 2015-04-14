//
//  TextAnimationView.m
//  TmFramework
//
//  Created by Tom on 15/4/13.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "TextAnimationView.h"
#import <CoreText/CoreText.h>
#import <POP.h>
@implementation TextAnimationView{
    CAShapeLayer * shapeLayer;
}

-(void)awakeFromNib{
    shapeLayer = [CAShapeLayer layer];
}

-(void)layoutSubviews{
    if (_text) {
        [self startAnimation];
    }
}

-(void)removeAnimation{
    shapeLayer.path = nil;
    [shapeLayer pop_removeAllAnimations];
    [shapeLayer removeFromSuperlayer];
}

-(void)startAnimation{
    
    [self.layer addSublayer:shapeLayer];
    CAShapeLayer *layer = shapeLayer;
    layer.frame         = self.bounds;                // 与showView的frame一致
    layer.strokeColor   = [UIColor greenColor].CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    layer.lineCap       = kCALineCapSquare;               // 边缘线的类型
    layer.path          = [self pathRefFromText];                    // 从贝塞尔曲线获取到形状
    layer.lineWidth     = 1.0f;                           // 线条宽度
    layer.strokeStart   = 0.0f;
    layer.strokeEnd     = 0.f;
    
    POPBasicAnimation * pathAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    pathAnimation.autoreverses = YES;
    pathAnimation.repeatForever = YES;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.duration = 0.5 * _text.length;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    
    [layer pop_addAnimation:pathAnimation forKey:nil];
}


-(CGPathRef)pathRefFromText{

    UIFont * font = [UIFont systemFontOfSize:30];
    UIColor *foregroundColor = [UIColor whiteColor];
    NSDictionary *attrsDic = @{NSForegroundColorAttributeName: foregroundColor,
                               NSFontAttributeName: font
                                                              };
    NSAttributedString *attributed = [[NSAttributedString alloc] initWithString:_text attributes:attrsDic];
    CGMutablePathRef letters = CGPathCreateMutable();
    
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attributed);
    
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++){
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++){
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
            CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
            CGPathAddPath(letters, &t, letter);
            CGPathRelease(letter);
        }
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:letters];
    CGRect boundingBox = CGPathGetBoundingBox(letters);
    
    CGPathRelease(letters);
    
    CFRelease(line);
    
    [path applyTransform:CGAffineTransformMakeScale(1.0, -1.0)];
    
    [path applyTransform:CGAffineTransformMakeTranslation(0.0, boundingBox.size.height)];
    
    
    return path.CGPath;
}

-(void)setText:(NSString *)text{
    _text = text;
    [self startAnimation];
    [self layoutIfNeeded];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
