//
//  HouseVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "HouseVC.h"
#import "HNChannelView.h"
#import "HouseListVC.h"


@interface HouseVC ()
{
//    NSMutableArray *_datasource;
//    NSString *_page;
//    NSString *_search;
    NSArray *_items;
}


@property (nonatomic, strong) UITableView *table;
//@property (nonatomic , strong) UISearchBar *searchbar;

@property (nonatomic, strong) UIButton *moreBtn;


@end

@implementation HouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)initDataSource{
    _items = @[@"新房",@"二手房",@"租房"];
//    _search = @"";
//    _page = @"1";
//    [self RequestWithPage:_page];
    [self ReloadType];

}

- (void)ReloadType{
    
    [self pageController:self willEnterViewController:self.childViewControllers[0] withInfo:@{}];
}

- (void)ActionMoreBtn:(UIButton *)btn{
    
    HNChannelView *view = [[HNChannelView alloc]initWithFrame:CGRectMake(0, SCREEN_Height, SCREEN_Width, SCREEN_Height -STATUS_BAR_HEIGHT)];
    
    view.clickblook = ^(int selctnum) {
//        _titlearr = [UserModel defaultModel].tagSelectArr;
        
        self.selectIndex = selctnum;
        [self reloadData];
    };
    
    view.hideblook = ^{
//        _titlearr = [UserModel defaultModel].tagSelectArr;
        //        self.selectIndex = 0;
        [self reloadData];
        [self forceLayoutSubviews];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view show];
}











- (void)initUI{
    
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
    self.titleColorSelected = [UIColor colorWithRed:27.0/255.0 green:155.0/255.0 blue:255.0/255.0 alpha:1];
    self.menuView.backgroundColor   = [UIColor whiteColor];
    
    //    self.menuViewContentMargin = 20*SIZE;
    [self reloadData];
    
    self.navBackgroundView.hidden = NO;
    self.leftButton.hidden = YES;
    self.titleLabel.text = @"房源";
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.backgroundColor = COLOR(255, 255, 255, 0.9);
    _moreBtn.frame = CGRectMake(320 *SIZE, NAVIGATION_BAR_HEIGHT+20*SIZE, 40 *SIZE, 40 *SIZE);
    [_moreBtn addTarget:self action:@selector(ActionMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setImage:[UIImage imageNamed:@"add_50"] forState:UIControlStateNormal];
    [self.view addSubview:_moreBtn];
    
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return 3;
    
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
//
//    if ([viewController isKindOfClass:[RoomChildVC class]]) {
//        NSLog(@"%@",viewController);
//        if ([((RoomChildVC *)viewController).city isEqualToString:_city]) {
//
//
//        }else{
//
//            ((RoomChildVC *)viewController).city = _city;
//
//            [(RoomChildVC *) viewController RequestMethod];
//        }
//    }
//    else{
//
//
//    }
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    
    NSString *tempStr = @"新房";
    NSDictionary *dic;
    HouseListVC *vc = [[HouseListVC alloc]init];
    return vc;
//    dic = [UserModel defaultModel].tagDic[tempStr];
//    RoomChildVC *vc;
//    if ([((NSString *)dic[@"tag"]) containsString:@"新房"]) {
//
//        vc = [[RoomChildVC alloc] initWithType:2];
//    }else if([((NSString *)dic[@"tag"]) containsString:@"推荐"] || [((NSString *)dic[@"tag"]) containsString:@"关注"]) {
//
//        vc = [[RoomChildVC alloc] initWithType:1];
//    }else if([((NSString *)dic[@"tag"]) containsString:@"租房"]){
//
//        vc = [[RoomChildVC alloc] initWithType:3];
//    }else{
//
//        vc = [[RoomChildVC alloc] initWithType:0];
//    }
//    vc.status = dic[@"tag"];
//    vc.typeId = [NSString stringWithFormat:@"%@",dic[@"type_id"]];
//    vc.param = [NSString stringWithFormat:@"%@",dic[@"param"]];
//    vc.city = _city;
//    vc.roomChildVCRoomModelBlock = ^(RoomListModel *model) {
//
//        if ([dic[@"tag"] isEqualToString:@"关注"]) {
//
//            RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
//            if ([model.guarantee_brokerage integerValue] == 2) {
//
//                nextVC.brokerage = @"no";
//            }else{
//
//                if ([[UserModelArchiver unarchive].agent_identity integerValue] == 1) {
//
//                }else{
//
//                    nextVC.isRecommend = @"NO";
//                }
//                nextVC.brokerage = @"yes";
//            }
//
//            nextVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }else{
//
//            RoomDetailVC1 *nextVC = [[RoomDetailVC1 alloc] initWithModel:model];
//            if ([model.guarantee_brokerage integerValue] == 2) {
//
//                nextVC.brokerage = @"no";
//            }else{
//
//                if ([model.sort integerValue] == 0 && [model.cycle integerValue] == 0){
//
//                    nextVC.isRecommend = @"NO";
//                }
//                else{
//
//                    if ([[UserModelArchiver unarchive].agent_identity integerValue] == 1) {
//
//                    }else{
//
//                        nextVC.isRecommend = @"NO";
//                    }
//                }
//                nextVC.brokerage = @"yes";
//            }
//
//            nextVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:nextVC animated:YES];
//        }
//    };
//
//    vc.roomChildVCSecModelBlock = ^(SecdaryAllTableModel *model) {
//
//        SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//
//    };
//
//    vc.roomChildVCAttentionSecModelBlock = ^(AttentionHouseModel *model) {
//
//        SecAllRoomDetailVC *nextVC = [[SecAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    __weak RoomChildVC *weakvc = vc;
//    vc.roomChildVCSecComModelBlock = ^(SecdaryComModel *model) {
//
//        SecComRoomDetailVC *nextVC = [[SecComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//
//        nextVC.type = weakvc.typeId;
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCAttentionSecComModelBlock = ^(AttetionComModel *model) {
//
//        SecComRoomDetailVC *nextVC = [[SecComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//
//        nextVC.type = weakvc.typeId;
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCRecommendBlock = ^(NSDictionary *dataDic) {
//
//        RecommendNewInfoVC *vc = [[RecommendNewInfoVC alloc] initWithUrlStr:dataDic[@"content_url"] titleStr:dataDic[@"title"] imageUrl:dataDic[@"img_url"] briefStr:dataDic[@"desc"] recommendId:dataDic[@"recommend_id"] companyStr:dataDic[@"nick_name"]];
//        [self.navigationController pushViewController:vc animated:YES];
//    };
//    //    vc.roomChildVCRecommendBlock = ^(RecommendInfoModel *model) {
//    //
//    //        RecommendInfoVC *vc = [[RecommendInfoVC alloc] initWithUrlStr:model.content_url titleStr:model.title imageUrl:model.img_url briefStr:model.desc];
//    //        [self.navigationController pushViewController:vc animated:YES];
//    //    };
//
//    vc.roomChildVCRentModelBlock = ^(RentingAllTableModel *model) {
//
//        RentingAllRoomDetailVC *nextVC = [[RentingAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCAttentionRentModelBlock = ^(AtteionRentingHouseModel *model) {
//
//        RentingAllRoomDetailVC *nextVC = [[RentingAllRoomDetailVC alloc] initWithHouseId:model.house_id city:_city];
//        nextVC.type = [model.type integerValue];
//        nextVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCRentComModelBlock = ^(RentingComModel *model) {
//
//        RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//        nextVC.type = weakvc.typeId;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    vc.roomChildVCAttentionRentComModelBlock = ^(AttetionRentingComModel *model) {
//
//        RentingComRoomDetailVC *nextVC = [[RentingComRoomDetailVC alloc] initWithProjectId:model.project_id infoid:model.info_id city:_city];
//        nextVC.type = weakvc.typeId;
//        [self.navigationController pushViewController:nextVC animated:YES];
//    };
//
//    return vc;
//
    return self;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return _items[index];
}


#pragma mark - WMPageControllerDataSource

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT, 320*SIZE, 40*SIZE);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    return CGRectMake(0, NAVIGATION_BAR_HEIGHT+40*SIZE, 360*SIZE, SCREEN_Height-NAVIGATION_BAR_HEIGHT-40*SIZE-TAB_BAR_MORE);
    
}


@end
