//
//  NSMutableDictionary+Safe.m
//  TmFramework
//
//  Created by Tom on 15/4/13.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+Swizzle.h"
@implementation NSMutableDictionary (Safe)

+(void)load{
    [[[self dictionary] class] swizzleSelector:@selector(objectForKey:) withSelector:@selector(safe_objectForKey:)];
}

-(id)safe_objectForKey:(id)key{
    id value = [self safe_objectForKey:key];
    if ([value isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return value;
}

@end
