//
//  DealVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DealVC.h"
#import "DealCell.h"
#import "CountBtn.h"

@interface DealVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *_datasource;
    NSString *_page;
    NSString *_tag_search;
    NSString *_search;
    NSString *_all;
    NSString *_pay;
    NSString *_unpay;
}
@property (nonatomic , strong) CountBtn *allBtn;
@property (nonatomic , strong) CountBtn *payBtn;
@property (nonatomic , strong) CountBtn *unpayBtn;
@property (nonatomic , strong) UISearchBar *searchbar;
@property (nonatomic , strong) UITableView *table;

@end

@implementation DealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
    _tag_search = @"0";
    _search = @"";
    _page = @"1";
    [self RequestWithPage:_page];
    
}

-(void)RequestWithPage:(NSString *)page
{
    
    [BaseRequest GET:DealList_URL
          parameters:@{
                       @"page":page,
                       @"tag_search":_tag_search,
                       @"search":_search,
                       @"rule_id":_rule_id
                       }
             success:^(id resposeObject) {
                 NSLog(@"%@",resposeObject);
                 if ([resposeObject[@"code"] integerValue]==200) {
                     if ([page isEqualToString:@"1"]) {
                         
                         
                         _datasource = [self SetData:resposeObject[@"data"]];
                         [_table reloadData];
                         [self.table.mj_footer endRefreshing];
                     }
                     else{
                         NSMutableArray *dataarr =resposeObject[@"data"][@"list"][@"data"];
                         if (dataarr.count>0) {
                             [_datasource addObjectsFromArray:[self SetData:resposeObject[@"data"]]];
                             [self.table.mj_footer endRefreshing];
                             [_table reloadData];
                         }
                         else{
                             [self.table.mj_footer endRefreshingWithNoMoreData];
                         }
                         
                     }
                 }
                 else{
                     
                     [self showContent:resposeObject[@"msg"]];
                     [self.table.mj_footer endRefreshing];
                     
                     
                 }
                 [self.table.mj_header endRefreshing];
             }
             failure:^(NSError *error) {
                 
                 [self showContent:@"网络错误"];
                 [self.table.mj_footer endRefreshing];
                 [self.table.mj_header endRefreshing];
                 
             }];
}

-(NSMutableArray *)SetData:(NSMutableDictionary *)data
{
    NSMutableArray *dataarr = data[@"list"][@"data"];
    NSMutableArray * arr =  [NSMutableArray array];
    for (int i= 0; i<dataarr.count; i++) {
        NSDictionary *datadic  =  dataarr[i];
        NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
        [dic setValue:[NSString stringWithFormat:@"客户:%@/%@",datadic[@"name"],datadic[@"tel"]] forKey:@"customer"];
        [dic setValue:[NSString stringWithFormat:@"推荐人:%@/%@/%@",datadic[@"name"],datadic[@"store_name"],datadic[@"tel"]] forKey:@"agent"];
        NSString *type = @"类型:成交佣金";
        if ([datadic[@"broker_type"] integerValue]==2) {
            type = @"类型:到访佣金";
        }
        if ([datadic[@"broker_type"] integerValue]==3) {
            type = @"类型:推荐佣金";
        }
        [dic setValue:type forKey:@"type"];
        [dic setValue:[NSString stringWithFormat:@"推荐时间:%@",datadic[@"create_time"]] forKey:@"time"];
//        [dic setValue:datadic[@"absolute_address"] forKey:@"adress"];
//        [dic setValue:datadic[@"project_name"] forKey:@"project_name"];
//        NSArray *agent = datadic[@"agnet"];
//        if (agent.count>0) {
//            NSString *agent_name = [NSString stringWithFormat:@"驻场人员:%@", agent[0][@"name"]];
//            for (int j= 1 ; j<agent.count; j++) {
//                agent_name = [NSString stringWithFormat:@"%@,%@",agent_name,agent[i][@"name"]];
//            }
//            [dic setValue:agent_name forKey:@"agent"];
//        }
//        else{
//            [dic setValue:[NSString stringWithFormat:@"驻场人员：无"] forKey:@"agent"];
//        }
//        [dic setValue:[NSString stringWithFormat:@"%@",datadic[@"start"]] forKey:@"start"];
//        if ([datadic[@"start"] integerValue]==1) {
//            [dic setValue:[NSString stringWithFormat:@"%@起",datadic[@"act_start"]] forKey:@"time"];
//        }
//        else{
//            [dic setValue:[NSString stringWithFormat:@"%@-%@",datadic[@"act_start"],datadic[@"act_end"]] forKey:@"time"];
//        }
//
//        [dic setValue:datadic[@"project_id"] forKey:@"project_id"];
//        [dic setValue:datadic[@"rule_id"] forKey:@"rule_id"];
        [arr addObject:dic];
    }
    
    return arr;
}

-(void)actin_touch:(CountBtn *)btn
{
    [_allBtn SetBtnState:UnSelect_State];
    [_payBtn SetBtnState:UnSelect_State];
    [_unpayBtn SetBtnState:UnSelect_State];
    [btn SetBtnState:Select_State];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 120*SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        DealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCell"];
        if (!cell) {
            cell = [[DealCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DealCell"];
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}





- (void)initUI{
    
//    _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _allBtn.frame = CGRectMake(10, 5*SIZE, 100*SIZE , 40*SIZE);
//    _allBtn.backgroundColor = CLLoginBtnColor;
//    [_allBtn setTitle:@"" forState:UIControlStateNormal];
    _allBtn = [[CountBtn alloc]initWithFrame: CGRectMake(10*SIZE, 10*SIZE, 100*SIZE , 50*SIZE)];
    [_allBtn SetBtnState:Select_State];
    [_allBtn SettitleL:@"全部笔数" contentL:@"2000"];
    [_allBtn addTarget:self action:@selector(actin_touch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_allBtn];
    
    _payBtn = [[CountBtn alloc]initWithFrame: CGRectMake(130*SIZE, 10*SIZE, 100*SIZE , 50*SIZE)];
    [_payBtn SetBtnState:UnSelect_State];
    [_payBtn SettitleL:@"已结笔数" contentL:@"1000"];
    [_payBtn addTarget:self action:@selector(actin_touch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payBtn];
    
    _unpayBtn = [[CountBtn alloc]initWithFrame: CGRectMake(250*SIZE, 10*SIZE, 100*SIZE , 50*SIZE)];
    [_unpayBtn SetBtnState:UnSelect_State];
    [_unpayBtn SettitleL:@"未结笔数" contentL:@"1000"];
    [_unpayBtn addTarget:self action:@selector(actin_touch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_unpayBtn];
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 110*SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE-110*SIZE) style:UITableViewStylePlain];
//    _table.rowHeight = UITableViewAutomaticDimension;
//    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        self->_page =@"1";
        [self.table.mj_header beginRefreshing];
        [self RequestWithPage:@"1"];
        
    }];
    _table.mj_footer = [GZQGifFooter footerWithRefreshingBlock:^{
        NSInteger page = [self->_page integerValue];
        page++;
        self->_page = [NSString stringWithFormat:@"%ld",page];
        [self.table.mj_footer beginRefreshing];
        [self RequestWithPage:self->_page];
    }];
    
    
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 70*SIZE, 360*SIZE, 40*SIZE)];
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.delegate = self;
    //    _searchbar.backgroundImage = [[UIImage alloc] init];
    _searchbar.barTintColor = [UIColor whiteColor];
    _searchbar.backgroundColor = CLBackColor;
    _searchbar.placeholder = @"请输入姓名/电话";
    //    _searchbar.showsCancelButton = YES;
    _searchbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_searchbar];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _page = @"1";
//    _searchStr = searchBar.text;
    [self RequestWithPage:_page];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.table.allowsSelection=YES;
    self.table.scrollEnabled=YES;
    //    [self.tableDate removeAllObjects];
    //    [self.tableDate addObjectsFromArray:results];
    //    [self.tableView reloadData];
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text=@"";
    _page = @"1";
//    _searchStr = @"";
    [self RequestWithPage:_page];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.table.allowsSelection=YES;
    self.table.scrollEnabled=YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    //     _searchbar.showsCancelButton = YES;
    self.table.allowsSelection=NO;
    self.table.scrollEnabled=NO;
}





@end
