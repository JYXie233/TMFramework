//
//  TestModel.h
//  TmFramework
//
//  Created by Tom on 15/4/12.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "JSONModel.h"

@interface TestModel : JSONModel
@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* country;
@property (strong, nonatomic) NSString<Optional>* dialCode;

@end
