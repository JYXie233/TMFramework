//
//  JSONModelViewController.m
//  TmFramework
//
//  Created by Tom on 15/4/15.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "JSONModelViewController.h"
#import "Network.h"
@interface JSONModelViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation JSONModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Network GET:@"jsonlist" withParams:nil withHandler:^(id response, NSError *error) {
        _label.text = [NSString stringWithFormat:@"%@", response];
    } isShowHub:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
