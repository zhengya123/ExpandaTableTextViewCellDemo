//
//  ViewController.m
//  ZYExpandableTextCellDemo
//
//  Created by 中商国际 on 2018/2/6.
//  Copyright © 2018年 中商国际. All rights reserved.
//

#import "ViewController.h"
#import "textViewTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,ExpandableTableViewDelegate>

{
CGFloat _cellHeight[7];
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * cellData;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.cellData addObjectsFromArray:@[
                                        @{@"left":@"餐饮单位",@"right":@""},
                                        @{@"left":@"消毒日期",@"right":@""},
                                        @{@"left":@"消毒时间",@"right":@""},
                                        @{@"left":@"消毒方式",@"right":@""},
                                        @{@"left":@"餐具数量",@"right":@""},
                                        @{@"left":@"人员签名",@"right":@""},
                                        @{@"left":@"备注",@"right":@""}
                                        ]];
    [self.tableView reloadData];
    
    UIView * footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(20, 10, CGRectGetMaxX(footV.frame) - 40, 30);
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitClick:) forControlEvents:UIControlEventTouchUpInside];
    [footV addSubview:commitBtn];
    self.tableView.tableFooterView = footV;
}
- (void)commitClick:(UIButton *)btn{
//    NSMutableDictionary * dic = [NSMutableDictionary new];
//    [dic setObject:[self.cellData[0] objectForKey:@"right"] forKey:@"CateringUnit"];
//    [dic setObject:[self.cellData[1] objectForKey:@"right"] forKey:@"Date"];
//    [dic setObject:[self.cellData[2] objectForKey:@"right"] forKey:@"Date"];
//    [dic setObject:[self.cellData[3] objectForKey:@"right"] forKey:@"Method"];
//    [dic setObject:[self.cellData[4] objectForKey:@"right"] forKey:@"TableWareQuantity"];
//    [dic setObject:[self.cellData[5] objectForKey:@"right"] forKey:@"Signature"];
//    [dic setObject:[self.cellData[6] objectForKey:@"right"] forKey:@"Remark"];
    
    NSDictionary * dic = @{
                           @"CateringUnit":[NSString stringWithFormat:@"%@",[self.cellData[0] objectForKey:@"right"]],
                           @"Date":[self.cellData[1] objectForKey:@"right"],
                           @"Time":[self.cellData[2] objectForKey:@"right"],
                           @"Method":[self.cellData[3] objectForKey:@"right"],
                           @"TableWareQuantity":[self.cellData[4] objectForKey:@"right"],
                           @"Signature":[self.cellData[5] objectForKey:@"right"],
                           @"Remark":[self.cellData[6] objectForKey:@"right"]
                           };
    NSLog(@"要提交的数据 == %@",dic);

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    textViewTableViewCell * cell = [tableView expandableTextCellWithId:@"Cell"];
    cell.text = [[self.cellData objectAtIndex:indexPath.section] objectForKey:@"right"];
    cell.leftLabel.text =[[self.cellData objectAtIndex:indexPath.section] objectForKey:@"left"];
    cell.textView.placeholder = @"Placeholder";
    return cell;

}
#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MAX(50.0, _cellHeight[indexPath.section]);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
    _cellHeight[indexPath.section] = height;
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary * dic = [NSMutableDictionary new];
    [dic setObject:[self.cellData[indexPath.section]objectForKey:@"left"] forKey:@"left"];
    [dic setObject:[NSString stringWithFormat:@"%@",text] forKey:@"right"];
    [self.cellData replaceObjectAtIndex:indexPath.section withObject:dic];
    NSLog(@"%@",self.cellData);
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //[_tableView registerClass:[textViewTableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}
- (NSMutableArray *)cellData{
    if (_cellData == nil) {
        _cellData = [NSMutableArray new];
    }
    return _cellData;
}
@end
