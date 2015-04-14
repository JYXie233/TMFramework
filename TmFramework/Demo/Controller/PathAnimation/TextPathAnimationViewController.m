//
//  TextPathAnimationViewController.m
//  TmFramework
//
//  Created by Tom on 15/4/13.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "TextPathAnimationViewController.h"
#import "TextAnimationView.h"
@interface TextPathAnimationViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet TextAnimationView *textAnimationView;

@end

@implementation TextPathAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _textAnimationView.text = @"正在加载中...";
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    _textAnimationView.text = textField.text;
    return YES;
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
