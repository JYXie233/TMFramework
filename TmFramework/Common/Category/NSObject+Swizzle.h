//
//  NSObject+Swizzle.h
//  TmFramework
//
//  Created by Tom on 15/4/13.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)
+(void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;
@end
