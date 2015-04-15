//
//  Network.m
//  TmFramework
//
//  Created by Tom on 15/4/12.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "Network.h"
#import "NetworkConfig.h"
#import <AFNetworking.h>
#import "APPUtils.h"
@interface Network()
@property (nonatomic,strong) AFHTTPSessionManager * httpManager;
@end

@implementation Network

+(Network*)sharedManager
{
    static Network *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
        shareInstance.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kServiceHost]];
        shareInstance.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        shareInstance.httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return shareInstance;
}

+(void)GET:(NSString *)api withParams:(NSDictionary *)params withHandler:(NetworkCompleteBlock)block{
    [self GET:api withParams:params withHandler:block isShowHub:YES];
}

+(void)GET:(NSString *)api withParams:(NSDictionary *)params withHandler:(NetworkCompleteBlock)block isShowHub:(BOOL)isShowHub{
    if (isShowHub) {
        [APPUtils showProgress];
    }
    [[self sharedManager].httpManager GET:api parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [[self sharedManager] disposeResponse:responseObject withBlock:block withApi:api isShowHub:isShowHub];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
        if (isShowHub) {
            [APPUtils showError:error.localizedDescription];
        }
        
#if DEBUG
        NSLog(@"\n\t接口地址：%@%@\n\t错误信息：%@", kServiceHost, api, error.localizedDescription);
#endif
    }];
}

+(void)POST:(NSString *)api withParams:(NSDictionary *)params withHandler:(NetworkCompleteBlock)block{
    [self POST:api withParams:params withFormDataHandler:nil withHandler:block isShowHub:YES];
}

+(void)POST:(NSString *)api withParams:(NSDictionary *)params withHandler:(NetworkCompleteBlock)block isShowHub:(BOOL)isShowHub{
    [self POST:api withParams:params withFormDataHandler:nil withHandler:block isShowHub:isShowHub];
}

+(void)POST:(NSString *)api withParams:(NSDictionary *)params withFormDataHandler:(NetworkFormDataHandler)handler withHandler:(NetworkCompleteBlock)block isShowHub:(BOOL)isShowHub{
    if (isShowHub) {
        [APPUtils showProgress];
    }
    [[self sharedManager].httpManager POST:api parameters:params constructingBodyWithBlock:handler success:^(NSURLSessionDataTask *task, id responseObject) {
        [[self sharedManager] disposeResponse:responseObject withBlock:block withApi:api isShowHub:isShowHub];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        block(nil, error);
        if (isShowHub) {
            [APPUtils showError:error.localizedDescription];            
        }

#if DEBUG
        NSLog(@"\n\t接口地址：%@%@\n\t错误信息：%@", kServiceHost, api, error.localizedDescription);
#endif
    }];
}

-(void)disposeResponse:(id)response withBlock:(NetworkCompleteBlock)block withApi:(NSString*)api isShowHub:(BOOL)isShowHub{
    if (isShowHub) {
        [APPUtils showSuccess:[response description]];
    }
    block(response, nil);
#if DEBUG
    NSLog(@"\n\t接口地址：%@%@\n\t收到数据：%@", kServiceHost, api, response);
#endif
}

@end
