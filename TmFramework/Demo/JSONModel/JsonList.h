//
//  JsonList.h
//  TmFramework
//
//  Created by Tom on 15/4/16.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "JSONModel.h"
#import "TestModel.h"

@interface JsonList : JSONModel
@property (nonatomic,strong) NSArray<TestModel,Optional>*data;
@end
