//
//  CustomerListVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomerListVC.h"
#import "CustomerListCell.h"
#import "DropBtn.h"
#import "DateChooseView.h"

@interface CustomerListVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableArray *_datasource;
    NSString *_urlStr;
    NSString *_searchStr;
    NSString *_page;
}

@property (nonatomic, strong) UITableView *table;
@property (nonatomic , strong) UISearchBar *searchbar;
@property (nonatomic , strong) DropBtn *startBtn;
@property (nonatomic , strong) DropBtn *endBtn;


@property ( nonatomic , strong ) UIView *maskView;
@property ( nonatomic , strong ) UIView *tanchuanView;



@end

@implementation CustomerListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
    _urlStr =  RecommendCustomerList_URL;
    if ([_type isEqualToString:@"1"]) {
        _urlStr = VisitCustomerList_URL;
    }
    if([_type isEqualToString:@"2"])
    {
        _urlStr = DealCustomerList_URL;
    }
    _page = @"1";
    _searchStr = @"";
    [self RequestWithPage:_page];
    
}

-(void)RequestWithPage:(NSString *)page{
    NSDictionary *prame;
    if ([_end_time isEqualToString:@""]) {
        prame = @{
                  @"page":page,
                  @"rule_id":_rule_id,
                  @"search":_searchStr
                  };
    }else{
        prame = @{
                  @"page":page,
                  @"rule_id":_rule_id,
                  @"search":_searchStr,
                  @"start_time":_start_time,
                  @"end_time":_end_time
                  };
    }
    
    
    
    [BaseRequest GET:_urlStr
          parameters:prame
             success:^(id resposeObject) {
                 NSLog(@"%@",resposeObject);
                 
                 if ([resposeObject[@"code"] integerValue]==200) {
                     if ([page isEqualToString:@"1"]) {
                         
                         
                         _datasource = [self SetData:resposeObject[@"data"][@"data"]];
                         [_table reloadData];
                         [self.table.mj_footer endRefreshing];
                         
                     }
                     else{
                         NSMutableArray *dataarr =resposeObject[@"data"][@"data"];
                         if (dataarr.count>0) {
                             [_datasource addObjectsFromArray:[self SetData:dataarr]];
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

-(NSMutableArray *)SetData:(NSMutableArray *)data
{
    NSMutableArray * arr =  [NSMutableArray array];
    for (int i= 0; i<data.count; i++) {
        NSDictionary *datadic  =  data[i];
        NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
        [dic setValue:datadic[@"name"] forKey:@"name"];
        [dic setValue:[NSString stringWithFormat:@"联系电话:%@", datadic[@"tel"]] forKey:@"tel"];
        [dic setValue:[NSString stringWithFormat:@"推荐人:%@/%@", datadic[@"agent_name"],datadic[@"store_name"]] forKey:@"agent"];
        if ([_type isEqualToString:@"0"]) {
            [dic setValue:[NSString stringWithFormat:@"推荐时间:%@", datadic[@"create_time"]] forKey:@"time"];
        }
        else if ([_type isEqualToString:@"1"])
        {
            [dic setValue:[NSString stringWithFormat:@"到访时间:%@", datadic[@"visit_time"]] forKey:@"time"];
        }
        else{
            [dic setValue:[NSString stringWithFormat:@"成交时间:%@", datadic[@"subscribe_time"]] forKey:@"time"];
        }
        

        [arr addObject:dic];
    }
    
    return arr;
}

- (void)ActionRightBtn:(UIButton *)btn{
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.tanchuanView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95*SIZE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomerListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerListCell"];
    if (!cell) {
        
        cell = [[CustomerListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomerListCell"];
    }
    cell.timeL.text = _datasource[indexPath.row][@"time"];
    cell.titelL.text = _datasource[indexPath.row][@"name"];
    cell.nameL.text = _datasource[indexPath.row][@"tel"];
    cell.phoneL.text = _datasource[indexPath.row][@"agent"];
//    if (![_datasource[indexPath.row][@"img_url"] isEqualToString:@""]) {
//        [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_datasource[indexPath.row][@"img_url"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            if (error) {
//                cell.headerImg.image = [UIImage imageNamed:@"project_def"];
//            }
//        }];
//    }
//    else{
//        cell.headerImg.image = [UIImage imageNamed:@"project_def"];
//    }
//    cell.companyL.text = _datasource[indexPath.row][@"project_name"];
//    cell.adressL.text = _datasource[indexPath.row][@"adress"];
//    cell.nameL.text = _datasource[indexPath.row][@"agent"];
//    cell.timeL.text = _datasource[indexPath.row][@"time"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)initUI{
    self.navBackgroundView.hidden = NO;
//    self.leftButton.hidden = YES;
    self.titleLabel.text = @"客户列表";
    self.rightBtn.hidden = NO;
    self.rightBtn.center = CGPointMake(SCREEN_Width - 40 * SIZE, STATUS_BAR_HEIGHT + 20);
    self.rightBtn.bounds = CGRectMake(0, 0, 20 * SIZE, 20 * SIZE);
    [self.rightBtn setImage:[UIImage imageNamed:@"icon_date"] forState:UIControlStateNormal];
//    self.rightBtn.titleLabel.font = FONT(13 *SIZE);
//    [self.rightBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(ActionRightBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.rightBtn setTitle:@"日期筛选" forState:UIControlStateNormal];
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+40*SIZE, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
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
    
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, 360*SIZE, 40*SIZE)];
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
    _searchStr = searchBar.text;
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
    _searchStr = @"";
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

-(UIView *)tanchuanView
{
    if (!_tanchuanView) {
        _tanchuanView = [[UIView alloc]initWithFrame:CGRectMake(46*SIZE, 200*SIZE, 268*SIZE, 180*SIZE)];
        _tanchuanView.backgroundColor = [UIColor whiteColor];
        _tanchuanView.layer.masksToBounds = YES;
        _tanchuanView.layer.cornerRadius = 3*SIZE;
        [self initTanchuanView];
//        [self initFJXQ];
    }
    return _tanchuanView;
}

-(void)initTanchuanView{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10*SIZE, 268*SIZE, 15*SIZE)];
    title.text = @"选择日期";
    title.font = [UIFont boldSystemFontOfSize:14*SIZE];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:title];
    
    UILabel *strat = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 47*SIZE, 110*SIZE, 15*SIZE)];
    strat.text = @"开始时间:";
    strat.font = FONT(12);
//    strat.textAlignment = NSTextAlignmentCenter;
    strat.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:strat];
    
    UILabel *end = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 97*SIZE, 110*SIZE, 15*SIZE)];
    end.text = @"结束时间:";
    end.font = FONT(12);
//    end.textAlignment = NSTextAlignmentCenter;
    end.textColor = CLTitleLabColor;
    [_tanchuanView addSubview:end];
    
    _startBtn = [[DropBtn alloc]initWithFrame:CGRectMake(80 *SIZE,  40 *SIZE, 160 *SIZE, 33 *SIZE)];
   _startBtn.content.text = _start_time;
    [_startBtn addTarget:self action:@selector(action_start) forControlEvents:UIControlEventTouchUpInside];
    [_tanchuanView addSubview:_startBtn];
    
    _endBtn = [[DropBtn alloc]initWithFrame:CGRectMake(80 *SIZE,  90 *SIZE, 160 *SIZE, 33 *SIZE)];
    _endBtn.content.text = _end_time;
    [_endBtn addTarget:self action:@selector(action_end) forControlEvents:UIControlEventTouchUpInside];
    [_tanchuanView addSubview:_endBtn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0 *SIZE,  140 *SIZE, 134 *SIZE, 40 *SIZE)];
    btn1.backgroundColor = CLLightGrayColor;
    [btn1 addTarget:self action:@selector(maskViewTap) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [_tanchuanView addSubview:btn1];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(134 *SIZE,  140 *SIZE, 134 *SIZE, 40 *SIZE)];
    btn.backgroundColor = CLBlueBtnColor;
    [btn addTarget:self action:@selector(action_sure) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [_tanchuanView addSubview:btn];
}

-(void)action_start
{
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
//    __weak __typeof(&*self)weakSelf = self;
    view.dateblock = ^(NSDate *date) {
        _startBtn.content.text =[self gettime:date];
    };
    [self.view addSubview:view];
}

-(void)action_end
{
    DateChooseView *view = [[DateChooseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    //    __weak __typeof(&*self)weakSelf = self;
    view.dateblock = ^(NSDate *date) {
        _endBtn.content.text =[self gettime:date];
    };
    [self.view addSubview:view];
}

-(void)action_sure
{
    if (!_startBtn.content.text) {
        [self showContent:@"请选择开始时间"];
        return;
    }
    if (!_endBtn.content.text) {
        [self showContent:@"请选择结束时间"];
        return;
    }
    
    _start_time = _startBtn.content.text;
    _end_time = _endBtn.content.text;
    _page = @"1";
    [self RequestWithPage:_page];
    [self maskViewTap];
}


- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}


- (void)maskViewTap {
    [self.tanchuanView removeFromSuperview];
    //    [self.guanbi removeFromSuperview];
    self.tanchuanView = nil;
    [self.maskView removeFromSuperview];
//    _fjxx = nil;
}

@end
