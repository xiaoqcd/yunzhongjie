//
//  AgentVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentVC.h"
#import "AgentCell.h"

@interface AgentVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    
    NSArray *_datasource;
}
@property (nonatomic, strong) UITableView *table;
@property (nonatomic , strong) UISearchBar *searchbar;



@end

@implementation AgentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
    _datasource = @[@"",@"",@""];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSArray *results;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120*SIZE;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentCell"];
    if (!cell) {
        
        cell = [[AgentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AgentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}






- (void)initUI{

    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 40*SIZE, SCREEN_Width, SCREEN_Height- NAVIGATION_BAR_HEIGHT  - TAB_BAR_MORE-40*SIZE) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 40*SIZE)];
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



@end
