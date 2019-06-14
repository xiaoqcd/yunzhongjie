//
//  CYLTabBarControllerConfig.m
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "CYLTabBarControllerConfig.h"
#import "HouseVC.h"
#import "StoreVC.h"
#import "MessageVC.h"
#import "WorkVC.h"
#import "MineVC.h"

@implementation CYLTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    
    if (_tabBarController == nil) {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        //[_tabBarController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -10)];
        [self customizeTabBarAppearance];
        _tabBarController = tabBarController;
        
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    
    
    
    
    MessageVC *message_vc = [[MessageVC alloc] init];
    UIViewController *message_nav = [[CYLBaseNavigationController alloc]
                                  initWithRootViewController:message_vc];
    message_vc.navigationController.navigationBar.hidden = YES;
    message_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    
    HouseVC *house_vc = [[HouseVC alloc] init];
    UIViewController *house_nav = [[CYLBaseNavigationController alloc] initWithRootViewController:house_vc];
    house_vc.navigationController.navigationBar.hidden = YES;
    //调整文字位置
    house_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    StoreVC *store_vc = [[StoreVC alloc] init];
    UIViewController *store_nav = [[CYLBaseNavigationController alloc]
                                    initWithRootViewController:store_vc];
    store_vc.navigationController.navigationBar.hidden = YES;
    store_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    WorkVC *work_vc = [[WorkVC alloc] init];
    UIViewController *work_nav = [[CYLBaseNavigationController alloc]
                                    initWithRootViewController:work_vc];
    work_vc.navigationController.navigationBar.hidden = YES;
    work_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    
    MineVC *mine_vc = [[MineVC alloc] init];
    UIViewController *mine_nav = [[CYLBaseNavigationController alloc]
                                  initWithRootViewController:mine_vc];
    mine_vc.navigationController.navigationBar.hidden = YES;
    mine_nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    //_tabBarController.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    //_tabBarController.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
    //[_tabBarController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, MAXFLOAT)];
    
    NSArray *viewControllers = @[
                                 message_nav,
                                 house_nav,
                                 store_nav,
                                 work_nav,
                                 mine_nav
                                 ];
    return viewControllers;
}

/**
 *  在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (NSArray *)tabBarItemsAttributesForController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"classify",
                            CYLTabBarItemSelectedImage : @"classify_1",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"房源",
                            CYLTabBarItemImage : @"work_2",
                            CYLTabBarItemSelectedImage : @"work_1",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"门店",
                            CYLTabBarItemImage : @"fangyuan",
                            CYLTabBarItemSelectedImage : @"fangyuan_1",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"工作",
                            CYLTabBarItemImage : @"report_2",
                            CYLTabBarItemSelectedImage : @"report",
                            };
    NSDictionary *dict5 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"me",
                            CYLTabBarItemSelectedImage : @"me_1",
                            };
    
    NSArray *tabBarItemsAttributes;
    tabBarItemsAttributes = @[
                              dict1,
                              dict2,
                              dict3,
                              dict4,
                              dict5
                              ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance {
    //warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //tabBarController.tabBarHeight = 40.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = COLOR(68, 68, 68, 1);
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = COLOR(39, 161, 217, 1);
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    [self customizeTabBarSelectionIndicatorImage];
    
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    //[[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: (CYLTabBarController *) [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor clearColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
