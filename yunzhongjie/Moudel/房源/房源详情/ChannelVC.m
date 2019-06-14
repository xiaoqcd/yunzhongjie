//
//  ChannelVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ChannelVC.h"
#import "RoomBrokerageTableHeader.h"
#import "C_brokerageCell.h"

@interface ChannelVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_selectArr;
    NSMutableArray *_data;
//    RoomListModel *_roomModel;
//    BrokerModel *_model;
}
@property (nonatomic, strong) UITableView *brokerageTable;
@property (nonatomic, strong) UIView *DefaultView;
@end

@implementation ChannelVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    [self RequestMethod];
}

- (void)initDataSource{
    
    _selectArr = [@[] mutableCopy];
    //    _dataArr = [@[] mutableCopy];
    _data = [NSMutableArray array];
    _selectArr = [NSMutableArray arrayWithArray:@[@1,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]];
}

- (void)RequestMethod{
    
    [BaseRequest GET:ProjectGetRule_URL
          parameters:@{
                       @"project_id":_project_id
                       }
             success:^(id resposeObject) {
                                                     
                 NSLog(@"%@",resposeObject);
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                [self setData:resposeObject[@"data"]];
//                _data = resposeObject[@"data"];
                if (_data.count == 0) {
                    [self.view addSubview:self.DefaultView];
                }
                else{
                    
                    [_brokerageTable reloadData];
                }
                
            }
            else
            {
                [self showContent:resposeObject[@"msg"]];
            }

        }
             failure:^(NSError *error) {
                                                     
                 
                 NSLog(@"%@",error);
                 [self showContent:@"网络错误"];
                 
             }];
}

-(void)setData:(NSArray *)data{
    
    for (int i = 0; i<data.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if ([data[i][@"end_time"] isEqualToString:@"2037-12-31 23:59:59"]) {
            [dic setValue:[NSString stringWithFormat:@"%@起",data[i][@"begin_time"]] forKey:@"title"];
        }
        else{
            [dic setValue:[NSString stringWithFormat:@"%@ - %@",data[i][@"begin_time"],data[i][@"end_time"]] forKey:@"title"];
        }
        if (data[i][@"describe"]) {
             [dic setValue:data[i][@"describe"] forKey:@"content"];
        }
        else{
             [dic setValue:@"" forKey:@"content"];
        }
       
        [_data addObject:dic];
    }
    [_brokerageTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 51 *SIZE;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([_selectArr[section] integerValue]) {
        
        return 1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

        
        RoomBrokerageTableHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"RoomBrokerageTableHeader"];
        if (!header) {
            
            header = [[RoomBrokerageTableHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 51 *SIZE)];
        }
        header.titleL.text = _data[section][@"title"];
        header.dropBtn.tag = section;
        if ([_selectArr[section] integerValue]) {
            
            [header.dropBtn setImage:[UIImage imageNamed:@"uparrow"] forState:UIControlStateNormal];
        }else{
            
            [header.dropBtn setImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        }
//        header.titleL.text = [NSString stringWithFormat:@""]
        header.dropBtnBlock = ^(NSInteger index) {
            
            if ([_selectArr[index] integerValue]) {
                
                [_selectArr replaceObjectAtIndex:index withObject:@0];
            }else{
                
                [_selectArr replaceObjectAtIndex:index withObject:@1];
            }
            [tableView reloadData];
        };
        return header;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        C_brokerageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"C_brokerageCell"];
        if (!cell) {
            
            cell = [[C_brokerageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"C_brokerageCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.ruleL.text = _data[indexPath.section][@"content"];
        [cell SetRuleContent:_data[indexPath.section][@"content"]];
    
        return cell;
   
}

- (void)initUI{
    
    _brokerageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - TAB_BAR_MORE) style:UITableViewStylePlain];
    _brokerageTable.rowHeight = UITableViewAutomaticDimension;
    _brokerageTable.estimatedRowHeight = 500 *SIZE;
    
    _brokerageTable.backgroundColor = [UIColor whiteColor];;
    _brokerageTable.delegate = self;
    _brokerageTable.dataSource = self;
    _brokerageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_brokerageTable];
}

-(UIView *)DefaultView
{
    if (!_DefaultView) {
        _DefaultView = [[UIView alloc]initWithFrame:CGRectMake(0, 100*SIZE , SCREEN_Width , 20*SIZE)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 20*SIZE)];
        lab.text = @"暂无渠道规则，还不能推荐哦";
        lab.textColor = CLContentLabColor;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13*SIZE];
        [_DefaultView addSubview:lab];
    }
    return _DefaultView;
}


@end
