//
//  WorkVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "WorkVC.h"
//#import "PowerMannerger.h"
#import "WorkPhoneConfirmVC.h"
#import "WorkRecommendVC.h"
#import "WorkCell.h"

@interface WorkVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
    NSArray *_projectArr;
    
    NSArray *_showArr;
    NSMutableArray *_powerArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation WorkVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
//    [self RequestMethod];
}

- (void)initDataSource{
    
//    if ([UserModel defaultModel].agent_company_info_id) {
    
        _imgArr = @[@"laifang",@"ys_find",@"recommended",@"laifang",@"paihao",@"signing_2",@"shoukuan_2",@"audit",@"rotational"];
        _titleArr = @[@"经纪人管理",@"号码判重",@"新房推荐"];
//    }
//    _projectArr = [UserModel defaultModel].project_list;
//    _showArr = [PowerModel defaultModel].WorkListPower;
}


//- (void)RequestMethod{
//
//    if ([[UserModel defaultModel].projectinfo count]) {
//
//        [BaseRequest GET:WorkCount_URL parameters:@{@"project_id":[UserModel defaultModel].projectinfo[@"project_id"]} success:^(id  _Nonnull resposeObject) {
//
//            if ([resposeObject[@"code"] integerValue] == 200) {
//
//                //            [UserModel defaultModel].projectPowerDic = resposeObject[@"data"];
//                [self SetData:resposeObject[@"data"]];
//
//            }else{
//
//                [self showContent:resposeObject[@"msg"]];
//            }
//        } failure:^(NSError * _Nonnull error) {
//
//            [self showContent:@"网路错误"];
//        }];
//    }
//
//}

- (void)SetData:(NSDictionary *)data{
    
    //    for (int i = 0; i < _titleArr.count; i++) {
    //
    //        [_showArr replaceObjectAtIndex:i withObject:@0];
    //        [_powerArr replaceObjectAtIndex:i withObject:@{}];
    //    }
    //    NSLog(@"%@",data);
    //    NSArray *arr = data[@"app_operate"];
    //    for (int i = 0 ; i < arr.count; i++) {
    //
    //        for (int j = 0; j < _titleArr.count; j++) {
    //
    //            if ([arr[i][@"type"] containsString:_titleArr[j]]) {
    //
    //                [_showArr replaceObjectAtIndex:j withObject:@1];
    //                [_powerArr replaceObjectAtIndex:j withObject:arr[i]];
    //            }
    //        }
    //    }
    //
    //    if ([data[@"duty_operate"] integerValue] == 1) {
    //
    //        [_showArr replaceObjectAtIndex:9 withObject:@1];
    //    }
    //
    //    if ([data[@"is_butter"] integerValue] == 1) {
    //
    //        [_showArr replaceObjectAtIndex:1 withObject:@1];
    //        [_showArr replaceObjectAtIndex:2 withObject:@1];
    //    }
    //
    //    if ([data[@"person_check"] integerValue] == 1) {
    //
    //        [_showArr replaceObjectAtIndex:8 withObject:@1];
    //    }
    
    [_table reloadData];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if ([_showArr[indexPath.row] integerValue] == 1) {
    
        return UITableViewAutomaticDimension;
//    }else{
//
//        return 0;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkCell"];
    if (!cell) {
        
        cell = [[WorkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WorkCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell SetImg:_imgArr[indexPath.row] title:_titleArr[indexPath.row] content:@""];
//    if ([_showArr[indexPath.row] integerValue] == 1) {
//
//        cell.hidden = NO;
//    }else{
//
//        cell.hidden = YES;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
//
//        CallTelegramVC * nextVC = [[CallTelegramVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
//        nextVC.powerDic = [PowerModel defaultModel].telCallPower;
//        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 1){
        
        WorkPhoneConfirmVC *nextVC = [[WorkPhoneConfirmVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if (indexPath.row == 2){
        
        WorkRecommendVC *nextVC = [[WorkRecommendVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }else if(indexPath.row == 3){
        
//        VisitCustomVC *nextVC = [[VisitCustomVC alloc] initWithProjectId:[UserModel defaultModel].projectinfo[@"project_id"] info_id:[UserModel defaultModel].projectinfo[@"info_id"]];
//        nextVC.powerDic = [PowerModel defaultModel].visitPower;//_powerArr[3];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else{
//
//        AuditTaskVC *nextVC = [[AuditTaskVC alloc] init];
//        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)initUI{
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"工作";
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    

}
@end

