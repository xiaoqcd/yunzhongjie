//
//  StoreMainVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreMainVC.h"
#import "StoreMannerCell.h"
#import "StoreInfoHeader.h"
#import "StoreCountHeader.h"
#import "StoreCountCell.h"


@interface StoreMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_datasource;
    NSMutableArray *_countArr;
}


@property (nonatomic, strong) UITableView *table;

@end

@implementation StoreMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
    _datasource = @[@"",@"",@""];
}

-(void)Post{
    [BaseRequest GET:StoreDetail_URL
          parameters:@{
                    @"store_id":_store_id
                    }
             success:^(id resposeObject) {
                 
             }
             failure:^(NSError *error) {
                 
             }];
}

-(void)SetDataBydata:(NSDictionary *)datadic
{
     _countArr = [@[@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"recommend"][@"all"]]},@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"recommend"][@"month"]]},@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"recommend"][@"day"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"visit"][@"all"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"visit"][@"month"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"visit"][@"day"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"deal"][@"all"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"deal"][@"month"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"deal"][@"day"]]}] mutableCopy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 64*SIZE;
    }
    else{
        return 210*SIZE;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        StoreMannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreMannerCell"];
        if (!cell) {
            cell = [[StoreMannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreMannerCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        StoreCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCountCell"];
        if (!cell) {
            cell = [[StoreCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreCountCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section ==0)
        return 85*SIZE;
    else
        return 35*SIZE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0)
    {
        StoreInfoHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreInfoHeader"];
        if (!header) {
            header = [[StoreInfoHeader alloc]initWithReuseIdentifier: @"StoreInfoHeader"];
        }
//        cell set
        return header;
    }else{
        StoreCountHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreCountHeader"];
        if (!header) {
            header = [[StoreCountHeader alloc]initWithReuseIdentifier: @"StoreCountHeader"];
        }
        return header;
    }
}

- (void)initUI{

    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
//    _table.rowHeight = UITableViewAutomaticDimension;
//    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}



@end
