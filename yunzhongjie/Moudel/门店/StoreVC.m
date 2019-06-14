//
//  StoreVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreVC.h"
#import "StoreCell.h"
#import "StoreHeader.h"
#import "StoreDetailVC.h"

@interface StoreVC ()<UITableViewDelegate,UITableViewDataSource>
{

    NSArray *_datasource;
}

@property (nonatomic, strong) UITableView *table;


@end

@implementation StoreVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self Post];
    [self initDataSource];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
    _datasource = @[@"",@"",@""];
}

-(void)Post{
    [BaseRequest GET:StoreList_URL parameters:@{@"store_id":@"9"} success:^(id resposeObject) {
        NSLog(@"%@",resposeObject);
    } failure:^(NSError *error) {

    }];
}

-(NSMutableArray *)SetData:(NSMutableArray *)data
{
    NSMutableArray * arr =  [NSMutableArray array];
    for (int i= 0; i<data.count; i++) {
        NSDictionary *datadic  =  data[i];
        NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
        [dic setValue:datadic[@"longitude"] forKey:@"longitude"];
        [dic setValue:datadic[@"latitude"] forKey:@"latitude"];
        [dic setValue:datadic[@"store_id"] forKey:@"store_id"];
        [dic setValue:datadic[@"store_name"] forKey:@"store_name"];
        [dic setValue:datadic[@"address"] forKey:@"address"];
        [dic setValue:datadic[@"store_id"] forKey:@"store_id"];
        
        NSArray *agent = datadic[@"agnet"];
        if (agent.count>0) {
            NSString *agent_name = [NSString stringWithFormat:@"店长:%@", agent[0][@"name"]];
            NSString *agent_tel = [NSString stringWithFormat:@"联系方式:%@", agent[0][@"tel"]];
            for (int j= 1 ; j<agent.count; j++) {
                agent_name = [NSString stringWithFormat:@"%@,%@",agent_name,agent[i][@"name"]];
                agent_tel = [NSString stringWithFormat:@"%@,%@",agent_tel,agent[i][@"tel"]];
            }
            [dic setValue:agent_name forKey:@"name"];
            [dic setValue:agent_tel forKey:@"tel"];
            
        }
        else{
            [dic setValue:[NSString stringWithFormat:@"店长：无"] forKey:@"name"];
            [dic setValue:[NSString stringWithFormat:@"联系方式：无"] forKey:@"tel"];
        }
        [arr addObject:dic];
    }
    
    return arr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 95*SIZE;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCell"];
    if (!cell) {
        
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    [cell SetImg:_imgArr[indexPath.row] title:_titleArr[indexPath.row] content:@""];
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
    StoreDetailVC *next_vc = [[StoreDetailVC alloc]init];
    [self.navigationController pushViewController:next_vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25*SIZE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    StoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreHeader"];
    if (!header) {
        header = [[StoreHeader alloc]initWithReuseIdentifier: @"StoreHeader"];
    }
    return header;
    
}

- (void)initUI{
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"门店";
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
