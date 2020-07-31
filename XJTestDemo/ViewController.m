//
//  ViewController.m
//  XJTestDemo
//
//  Created by mac on 2020/7/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleAry;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleAry = @[@"类与对象", @"CollectionView/TableView使用多个cell的解耦"];
    self.title = @"日常瞎搞";

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XJ_ScreenWidth, XJ_ScreenHeight)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    // Do any additional setup after loading the view.
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleAry[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleAry count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *title = self.titleAry[indexPath.row];
    if ([title containsString:@"类与对象"]) {
        [self xj_pushSimpleViewController:Cls_ClassViewController];
//        [self xj_presentViewController:^(XJ_Node * _Nonnull node) {
//            node.clsName = Cls_ClassViewController;
//            node.isNav = YES;
//        }];
    }
    else if([title containsString:@"CollectionView/TableView使用多个cell的解耦"]){
//        [self xj_pushSimpleViewController:Cls_MasterViewController];
        [self xj_pushViewController:^(XJ_Node * _Nonnull node) {
            node.title = @"CollectionView/TableView使用多个cell的解耦";
            node.clsName = Cls_MasterViewController;
        }];
    }

}


@end
