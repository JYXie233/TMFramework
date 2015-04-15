//
//  Network.h
//  TmFramework
//
//  Created by Tom on 15/4/12.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void(^NetworkCompleteBlock)(id response, NSError* error);

typedef void(^NetworkFormDataHandler)(id <AFMultipartFormData> formData);

@interface Network : NSObject

+(void)POST:(NSString*)api withParams:(NSDictionary*)params withHandler:(NetworkCompleteBlock)block;

+(void)POST:(NSString*)api withParams:(NSDictionary*)params withHandler:(NetworkCompleteBlock)block isShowHub:(BOOL)isShowHub;

+(void)POST:(NSString*)api withParams:(NSDictionary*)params withFormDataHandler:(NetworkFormDataHandler)handler withHandler:(NetworkCompleteBlock)block isShowHub:(BOOL)isShowHub;


+(void)GET:(NSString*)api withParams:(NSDictionary*)params withHandler:(NetworkCompleteBlock)block;

+(void)GET:(NSString*)api withParams:(NSDictionary*)params withHandler:(NetworkCompleteBlock)block isShowHub:(BOOL)isShowHub;


@end
