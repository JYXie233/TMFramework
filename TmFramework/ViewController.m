//
//  ViewController.m
//  TmFramework
//
//  Created by Tom on 15/4/12.
//  Copyright (c) 2015年 Tom. All rights reserved.
//

#import "ViewController.h"
#import "GVUserDefaults+Properties.h"
#import "Network.h"
#import <JSONModel/JSONModelLib.h>
#import "TestEntity.h"
#import "TestModel.h"
#import "UITableView+TMCategory.h"
#import <MJRefresh.h>
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

static int p  = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_btn setTitle:[GVUserDefaults standardUserDefaults].userName forState:UIControlStateNormal];
    [Network GET:@"json" withParams:nil withHandler:^(NSDictionary *response, NSError *error) {
        TestModel * test = [[TestModel alloc]initWithDictionary:response error:nil];
        TestEntity * entity = [TestEntity MR_createEntity];
        [entity setValuesForKeysWithDictionary:[test toDictionary]];
        [[NSManagedObjectContext MR_defaultContext] save:nil];
        NSLog(@"%@\n%@\n%@", entity.debugDescription, [test toDictionary],test.description);

    }];
    [_tableView addGifHeaderWithRefreshingBlock:^{
        sleep(3);
        p = 5;
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer noticeNoMoreData];
    } dateKey:@"ad"];
    
    [_tableView addLegendFooterWithRefreshingBlock:^{
        
    }];
    
    [_tableView addReloadBlock:^{
        [_tableView.header beginRefreshing];
    }];

    _tableView.footer.automaticallyRefresh = NO;
    
    NSDictionary * d = @{@"d": [NSNull null]};
    NSString*m = [d objectForKey:@"d"];
    NSInteger count = m.length;
}
- (IBAction)btn:(id)sender {
    UIButton *b = sender;
    b.selected = !b.selected;
    if (b.selected) {
            p = 10;
        [GVUserDefaults standardUserDefaults].userName = @"tom";
    }else{
            p = 0;
        [b setTitle:[GVUserDefaults standardUserDefaults].userName forState:UIControlStateNormal];
    }


    [_tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return p;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
    }
    cell.textLabel.text = @"详细信息";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
