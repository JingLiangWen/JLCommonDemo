//
//  JLViewController.m
//  JLCommonDemo
//
//  Created by 温敬亮 on 17/1/7.
//  Copyright © 2017年 lanyou. All rights reserved.
//

#import "JLViewController.h"
#import "Masonry.h"

@interface JLViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray *examples;

@end

@implementation JLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSArray *)examples
{
    if (!_examples) {
        //
        _examples = @[
                      // 表单组件
                      @{
                          @"title" : @"原理问题",
                          @"list" : @[
                                  @[@"JLHitTestController",@"坐标转化"],
                                  @[@"JLHitTestController2",@"hitTest-超出父View也可以触发事件方案"],
                                  ]
                          }
                      
                      ,
                      // 组件
                      @{
                          @"title" : @"控制器组件",
                          @"list" : @[@[@"TestBaseSegmentedControl",@"segmentController"]
                                      ]
                          },
                      
                      
                      ];
        
    }
    return _examples;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 60;
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = self.examples[section];
    NSArray *s= (NSArray *)dic[@"list"];
    return s.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSDictionary *dic = self.examples[section];
    return  dic[@"title"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"example";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    NSDictionary *dic = self.examples[indexPath.section];
    NSArray *array = [dic[@"list"] objectAtIndex:indexPath.row];
    cell.textLabel.text = array[1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.examples[indexPath.section];
    NSArray *array = [dic[@"list"] objectAtIndex:indexPath.row];
    UIViewController *vc = [[NSClassFromString(array[0]) alloc]init];
    vc.title = array[1];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}


@end
