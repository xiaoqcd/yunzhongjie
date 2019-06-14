//
//  ProjectDetailVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ProjectDetailVC.h"
#import "StoreMannerCell.h"
#import "ProjectHeader.h"
#import "StoreCountCell.h"
#import "CustomerListVC.h"
#import "StoreCountHeader.h"
//#import "YBImageBrowser.h"

@interface ProjectDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_imgArr;
    NSArray *_confirmArr;
//    NSArray *_imgArr;
    NSMutableArray *_countArr;
    NSMutableDictionary *_headerDic;
//    NSDictionary *_datasouse;
}


@property (nonatomic, strong) UITableView *table;

@end

@implementation ProjectDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
    _imgArr = [NSArray array];
    _confirmArr = [NSArray array];
    _countArr = [@[@{@"title":@"推荐客户",@"content":@"0"},@{@"title":@"推荐客户",@"content":@"0"},@{@"title":@"推荐客户",@"content":@"0"},@{@"title":@"到访客户",@"content":@"0"},@{@"title":@"到访客户",@"content":@"0"},@{@"title":@"到访客户",@"content":@"0"},@{@"title":@"成交客户",@"content":@"0"},@{@"title":@"成交客户",@"content":@"0"},@{@"title":@"成交客户",@"content":@"0"}] mutableCopy];
    _headerDic = [NSMutableDictionary dictionary];
//    _datasouse = [NSDictionary dictionary];
    [self Post];
}

-(void)Post{
    [BaseRequest GET:HouseDetail_URL
          parameters:@{@"project_id":_project_id,
                        @"rule_id":_rule_id
                        }
             success:^(id resposeObject) {
                 if ([resposeObject[@"code"] integerValue]==200) {
                     NSLog(@"%@",resposeObject);
                     [self SetDataBydata:resposeObject[@"data"]];
                 }
                 else{
                     [self showContent:resposeObject[@"msg"]];
                 }
                [self.table.mj_header endRefreshing];
             }
             failure:^(NSError *error) {
                 [self showContent:@"网络错误"];
                   [self.table.mj_header endRefreshing];
             }];
}

-(void)SetDataBydata:(NSDictionary *)datadic
{
    
    _imgArr = datadic[@"project"][@"img"];
    _confirmArr = datadic[@"project"][@"confirm"];
    _countArr = [@[@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"recommend"][@"all"]]},@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"recommend"][@"month"]]},@{@"title":@"推荐客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"recommend"][@"day"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"visit"][@"all"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"visit"][@"month"]]},@{@"title":@"到访客户",@"content":[NSString stringWithFormat:@"%@",datadic[@"visit"][@"day"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"deal"][@"all"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"deal"][@"month"]]},@{@"title":@"成交客户",@"content": [NSString stringWithFormat:@"%@",datadic[@"deal"][@"day"]]}] mutableCopy];
    
    [_headerDic setValue:datadic[@"project"][@"project_name"] forKey:@"project_name"];
     [_headerDic setValue:datadic[@"project"][@"absolute_address"] forKey:@"address"];
    if ([datadic[@"project"][@"average_price"] integerValue]==0) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 暂无数据"]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, attr.length)];
        [attr addAttribute:NSForegroundColorAttributeName value:CLContentLabColor range:NSMakeRange(0, attr.length)];
        [_headerDic setValue:attr forKey:@"average_price"];
    }
    else{
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 ￥%@/㎡",datadic[@"project"][@"average_price"]]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, 3)];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 *SIZE] range:NSMakeRange(3, attr.length-3)];
        [attr addAttribute:NSForegroundColorAttributeName value:CLContentLabColor range:NSMakeRange(0, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, attr.length-3)];
     [_headerDic setValue:attr forKey:@"average_price"];
    }
    [_headerDic setValue:datadic[@"project"][@"latitude"] forKey:@"lat"];
    [_headerDic setValue:datadic[@"project"][@"longitude"] forKey:@"lon"];
    [_headerDic setValue:datadic[@"project"][@"img"] forKey:@"img"];
    [_headerDic setValue:datadic[@"project"][@"project_name"] forKey:@"project_name"];
    NSMutableArray *PROPERTYARR = [NSMutableArray array];
    NSArray *DATAARR =datadic[@"project"][@"project_tags"];
    for (int i= 0; i<DATAARR.count; i++) {
        [PROPERTYARR addObject:DATAARR[i][@"param"]];
    }
    [_headerDic setValue:PROPERTYARR forKey:@"property"];
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _confirmArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
    
    if (indexPath.section==0) {
        StoreMannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreMannerCell"];
        if (!cell) {
            cell = [[StoreMannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreMannerCell"];
        }
        cell.nameL.text = _confirmArr[indexPath.row][@"name"];
        cell.phoneL.text = _confirmArr[indexPath.row][@"tel"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        StoreCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCountCell"];
        if (!cell) {
            cell = [[StoreCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoreCountCell"];
        }
        [cell.btn1 SettitleL:_countArr[0][@"title"] contentL:_countArr[0][@"content"]];
        [cell.btn2 SettitleL:_countArr[1][@"title"] contentL:_countArr[1][@"content"]];
        [cell.btn3 SettitleL:_countArr[2][@"title"] contentL:_countArr[2][@"content"]];
        [cell.btn4 SettitleL:_countArr[3][@"title"] contentL:_countArr[3][@"content"]];
        [cell.btn5 SettitleL:_countArr[4][@"title"] contentL:_countArr[4][@"content"]];
        [cell.btn6 SettitleL:_countArr[5][@"title"] contentL:_countArr[5][@"content"]];
        [cell.btn7 SettitleL:_countArr[6][@"title"] contentL:_countArr[6][@"content"]];
        [cell.btn8 SettitleL:_countArr[7][@"title"] contentL:_countArr[7][@"content"]];
        [cell.btn9 SettitleL:_countArr[8][@"title"] contentL:_countArr[8][@"content"]];
        cell.btnblock = ^(NSInteger tag) {
            NSLog(@"tag = %ld",tag);
            [self btntouch:tag];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


-(void)btntouch:(NSInteger )tag
{
//    NSString *end_time = [self gettime:[NSDate date]];
    NSString *end_time = @"";
    NSString *start_time = @"";
    NSString *type = @"2";
//    NSTimeInterval month = 24 * 60 * 60 *30;
    if (tag/10 == 0) {
        type = @"0";
        if (tag==0) {
            
        }
        else if(tag == 1)
        {

            end_time = [self gettime:[NSDate date]];
            NSMutableArray *arr = [[end_time componentsSeparatedByString:@"-"] mutableCopy];
            [arr replaceObjectAtIndex:2 withObject:@"01"];
            start_time = [arr componentsJoinedByString:@"-"];

            
        }else{
            end_time = [self gettime:[NSDate date]];
            start_time = [self gettime:[NSDate date]];
        }
        
    }
    else if(tag/10 == 1){
        type = @"1";
        
        if (tag==0) {
            
        }
        else if(tag == 1)
        {
            
            end_time = [self gettime:[NSDate date]];
            NSMutableArray *arr = [[end_time componentsSeparatedByString:@"-"] mutableCopy];
            [arr replaceObjectAtIndex:1 withObject:@"01"];
            [arr replaceObjectAtIndex:2 withObject:@"01"];
            start_time = [arr componentsJoinedByString:@"-"];

            
        }else{
            end_time = [self gettime:[NSDate date]];
            start_time = [self gettime:[NSDate date]];
        }
        
    }
    else{
        
        if (tag==0) {
            
        }
        else if(tag == 1)
        {
            
            end_time = [self gettime:[NSDate date]];
            NSMutableArray *arr = [[end_time componentsSeparatedByString:@"-"] mutableCopy];
            [arr replaceObjectAtIndex:1 withObject:@"01"];
            [arr replaceObjectAtIndex:2 withObject:@"01"];
            start_time = [arr componentsJoinedByString:@"-"];
            
        }else{
            end_time = [self gettime:[NSDate date]];
            start_time = [self gettime:[NSDate date]];
        }
        
    }
    
    CustomerListVC *next_vc = [[CustomerListVC alloc]init];
    next_vc.type = type;
    next_vc.rule_id = self.rule_id;
    next_vc.end_time = end_time;
    next_vc.start_time = start_time;
    [self.navigationController pushViewController:next_vc animated:YES];
    

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 301*SIZE;
    }
    else
    {
        return 40*SIZE;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        ProjectHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ProjectHeader"];
        if (!header) {
            header = [[ProjectHeader alloc]initWithReuseIdentifier: @"ProjectHeader"];
        }
        header.titleL.text = _headerDic[@"project_name"];
        header.stateL.text = [_start isEqualToString:@"1"]?@"分销中":@"以结束";
        header.priceL.attributedText = _headerDic[@"average_price"];
        header.addressL.text = _headerDic[@"address"];
        header.lat = _headerDic[@"lat"];
        header.lon = _headerDic[@"lon"];
        [header setImgArr:_headerDic[@"img"]];
        header.propertyArr = [NSMutableArray arrayWithArray:_headerDic[@"property"]];
        [header.propertyColl reloadData];
        
//        [header.imgBtnBlock = ^(NSInteger num, NSArray *imgArr) {
//
//            NSMutableArray *tempArr = [NSMutableArray array];
//            [imgArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                YBImageBrowserModel *model = [YBImageBrowserModel new];
//                model.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,obj[@"img_url"]]];
//                [tempArr addObject:model];
//            }];
//
//                YBImageBrowser *browser = [YBImageBrowser new];
//                browser.delegate = self;
//                browser.dataArray = tempArr;
////                browser.albumArr = _albumArr;
////                browser.infoid = _info_id;
//                browser.currentIndex = num;
//                [browser show];
//        }];
        [header.propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(header.propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
        }];
        
        
        return header;
    }
    else{
        
        StoreCountHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"StoreCountHeader"];
        if (!header) {
            header = [[StoreCountHeader alloc]initWithReuseIdentifier: @"StoreCountHeader"];
        }
        header.titelL.text =@"客户统计";
        return header;
    }
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStyleGrouped];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    _table.mj_header = [GZQGifHeader headerWithRefreshingBlock:^{
        [self.table.mj_header beginRefreshing];
        [self Post];
    }];
    [self.view addSubview:_table];
}




@end
