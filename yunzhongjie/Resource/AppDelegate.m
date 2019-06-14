//
//  AppDelegate.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLTabBarControllerConfig.h"
#import "LoginVC.h"
#import "GuideVC.h"
//#import "SystemMessageVC.h"
//#import "WorkMessageVC.h"
#import <WebKit/WebKit.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"

// 引入JAnalytics功能所需头文件
//#import "JANALYTICSService.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

//#define UmengAppkey @"5ac9debcb27b0a2147000050"
//#define QQAPPID @"1106811849"
//#define QQAppkey @"Yik2oC5WcDQ5IOrpc"
//#define WechatAppId @"wx3e34d92e8b8cb53e"
//#define WechatSecret @"200ee15186843d67c0d9ba6a66f3a6ba"
#define JpushAppKey @"2dd909361c253b51e0cd05a9"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initUI];
//    [self UpdateRequest];
//    [self NetworkingStart];
//    [self configThirdWithOptions:launchOptions];
    
    
    return YES;
}


- (void)initUI{
    if (![UserModelArchiver unarchive].agent_id) {
        [UserModel defaultModel].agent_id = @"0";
        [UserModelArchiver archive];
    }
    //注册通知，退出登陆时回到首页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comeBackLoginVC) name:@"goLoginVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goHome) name:@"goHome" object:nil];
    
    NSString *logIndentifier = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINENTIFIER];
    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:@"Guided"];
    if (flag == YES) {
        [self deleteWebCache];
        if ([logIndentifier isEqualToString:@"logInSuccessdentifier"]) {
            CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
            _window.rootViewController = tabBarControllerConfig.tabBarController;
        }else {
            //未登录
            LoginVC *mainLogin_vc = [[LoginVC alloc] init];
            UINavigationController *mainLogin_nav = [[UINavigationController alloc] initWithRootViewController:mainLogin_vc];
            mainLogin_nav.navigationBarHidden = YES;
            _window.rootViewController = mainLogin_nav;
            [_window makeKeyAndVisible];
            
        }
        
    } else {
        GuideVC *guideVC = [[GuideVC alloc] init];
        UINavigationController *guideNav = [[UINavigationController alloc] initWithRootViewController:guideVC];
        guideNav.navigationBarHidden = YES;
        _window.rootViewController = guideNav;
        [_window makeKeyAndVisible];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Guided"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

//- (void)UpdateRequest{
//
//    NSError *error;
//    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",@"1371978352"]]] returningResponse:nil error:nil];
//    if (response == nil) {
//
//        //        NSLog(@"你没有连接网络哦");
//        return;
//    }
//    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//
//    if (error) {
//
//        NSLog(@"hsUpdateAppError:%@",error);
//        return;
//    }
//    NSArray *array = appInfoDic[@"results"];
//    NSDictionary *dic = array[0];
//    NSString *appStoreVersion = dic[@"version"];
//    if ([[appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue] > [[YQDversion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue]) {
//
//        //        if ([UpdateAlert defaultAlert].alert) {
//        //
//        //            if ([UpdateAlert defaultAlert].isMust) {
//        //
//        //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //
//        //                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[UpdateAlert defaultAlert].alert animated:YES completion:^{
//        //
//        //                    }];
//        //                });
//        //            }
//        //        }else{
//
//        [BaseRequest GET:@"getVersionInfo" parameters:nil success:^(id resposeObject) {
//
//            if ([resposeObject[@"code"] integerValue] == 200) {
//
//
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"系统更新" message:resposeObject[@"data"][@"content"] preferredStyle:UIAlertControllerStyleAlert];
//
//                [alert addAction:[UIAlertAction actionWithTitle:@"去下载" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1371978352?mt=8"]];
//
//                }]];
//                if (![resposeObject[@"data"][@"must"] integerValue]) {
//
//                    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//
//                    }]];
//                }
//
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
//
//                    }];
//                });
//            }
//        } failure:^(NSError *error) {
//
//        }];
//    }
//
//    //    }
//}

//网络请求
- (void)NetworkingStart {
    //    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    //    dispatch_group_t group = dispatch_group_create();
    //    //版本
    //    dispatch_group_async(group, queue1, ^{
    
    //配置文件
    //    dispatch_group_async(group, queue1, ^{
    
    [BaseRequest GET:Config_URL parameters:nil success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue] == 200) {
            [UserModel defaultModel].Configdic = resposeObject[@"data"];
            [UserModelArchiver archive];
        }
    } failure:^(NSError *error) {
        
    }];
    //    });
    //获取配套UI
    //    dispatch_group_async(group, queue1, ^{
    
    [BaseRequest GET:HouseRecordUI_URL parameters:@{@"type":@"2"} success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue] == 200) {
//            [UserModel defaultModel].storeArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
//            [UserModelArchiver archive];
        }
    } failure:^(NSError *error) {
        
    }];
    
    [BaseRequest GET:HouseRecordUI_URL parameters:@{@"type":@"1"} success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue] == 200) {
//            [UserModel defaultModel].houseArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
//            [UserModelArchiver archive];
        }
    } failure:^(NSError *error) {
        
    }];
    
    //    });
    //完成勘察UI
    //    dispatch_group_async(group, queue1, ^{
    
    [BaseRequest GET:HouseRecordUI_URL parameters:@{@"type":@"3"} success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue] == 200) {
//            [UserModel defaultModel].officeArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
            [UserModelArchiver archive];
        }
    } failure:^(NSError *error) {
        
    }];
    
    //    });
    //获取源标签
    //    dispatch_group_async(group, queue1, ^{
    [BaseRequest GET:ProjectResources_URL parameters:nil success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue] == 200) {
            NSArray *arr = resposeObject[@"data"];
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            NSMutableArray *allarr = [NSMutableArray array];
            NSMutableArray *selctarr = [NSMutableArray array];
            for (NSUInteger i=0; i<arr.count; i++) {
                [dic setValue:arr[i] forKey:arr[i][@"tag"]];
                [allarr addObject:arr[i][@"tag"]];
            }
//            [UserModel defaultModel].tagDic = dic;
//            [UserModel defaultModel].tagAllArr = allarr;
//            if (![UserModel defaultModel].tagSelectArr) {
//                for (NSUInteger i= 0; i<5; i++) {
//                    [selctarr addObject:arr[i][@"tag"]];
//                }
//                [UserModel defaultModel].tagSelectArr = selctarr;
//            }
//            [UserModelArchiver archive];
        }
    } failure:^(NSError *error) {
        
    }];
    
    //    });
    //开放城市
    //    dispatch_group_async(group, queue1, ^{
    [BaseRequest GET:OpenCity_URL parameters:nil success:^(id resposeObject) {
        if ([resposeObject[@"code"] integerValue] == 200) {
//            [UserModel defaultModel].cityArr = [NSMutableArray arrayWithArray:resposeObject[@"data"]];
//            [UserModelArchiver archive];
        }
    } failure:^(NSError *error) {
        
    }];
    
    //    });
}



//配置三方
- (void)configThirdWithOptions:(NSDictionary *)launchOptions{
//    [self configUSharePlatforms];
//    [self configBaiduMap];
//    [self configBugTags];
    [self conifgJpushWithOptions:launchOptions];
    [self configJAnalisties];
}

//配置极光统计

- (void)configJAnalisties
{
    //    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    //
    //    config.appKey = kJpushAPPKey;
    //
    //    config.isProduction = YES;
    //
    //
    //    [JANALYTICSService setupWithConfig:config];
    //
    //    [JANALYTICSService crashLogON];
    //
    //    [JANALYTICSService setFrequency:0];
}



//配置极光推送
- (void)conifgJpushWithOptions:(NSDictionary *)launchOptions  {
    //极光配置
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
    }else{
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    //    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    [JPUSHService setupWithOption:launchOptions appKey:JpushAppKey
                          channel:@"appstore"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            [self SetTagsAndAlias];
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    if (launchOptions) {
        NSDictionary *remote = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        if (remote) {
            [self GotoHome];
        }else{
            NSString *loggIndentifier;
            loggIndentifier = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINENTIFIER];
            if ([loggIndentifier isEqualToString:@"logInSuccessdentifier"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
            }
        }
    }
}

////配置bugtags
//- (void)configBugTags
//{
//    [Bugtags startWithAppKey:@"1560323d00d5dac86cd32d7b0d130787" invocationEvent:BTGInvocationEventNone];
//}

//删除web缓存
- (void)deleteWebCache {
    
    //    if([UIDevice currentDevice])
    if(@available(iOS 9.0, *)) {
        NSSet * websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSDate * dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore]removeDataOfTypes: websiteDataTypes
                                                  modifiedSince:dateFrom completionHandler:^{
                                                      
                                                  }];
        
    }else{
        
        NSString*libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES)objectAtIndex:0];
        NSString* cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError * errors;
        [[NSFileManager defaultManager]removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

- (void)GotoHome{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
    [UIApplication sharedApplication].keyWindow.cyl_tabBarController.selectedIndex = 0;
}





- (void)SetTagsAndAlias{
    NSString *logIndentifier = [[NSUserDefaults standardUserDefaults] objectForKey:LOGINENTIFIER];
    if (logIndentifier) {
        NSSet *tags;
        
        [JPUSHService setAlias:[NSString stringWithFormat:@"agent_%@",[UserModel defaultModel].agent_id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
            NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);;
        } seq:0];
    }
}



//-(void)tagsAliasCallback:(int)iResCode
//                    tags:(NSSet*)tags
//                   alias:(NSString*)alias
//{
//    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
//}

- (void)comeBackLoginVC {
    //未登录
    NSSet *tags;
    
    [JPUSHService setAlias:@"exit" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);
    } seq:0];
    LoginVC *mainLogin_vc = [[LoginVC alloc] init];
    UINavigationController *mainLogin_nav = [[UINavigationController alloc] initWithRootViewController:mainLogin_vc];
    mainLogin_nav.navigationBarHidden = YES;
    _window.rootViewController = mainLogin_nav;
    [_window makeKeyAndVisible];
    
}

- (void)goHome{
    
    NSSet *tags;
    
    [JPUSHService setAlias:[NSString stringWithFormat:@"agent_%@",[UserModel defaultModel].agent_id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);;
    } seq:0];
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    _window.rootViewController = tabBarControllerConfig.tabBarController;
}


//U盟回调
// 支持所有iOS系统
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//
//    //    [JANALYTICSService handleUrl:url];
////    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
////    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
////    if (!result) {
////        // 其他如支付等SDK的回调
////    }
//    return result;
//}

//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
//{
//
//    //    [JANALYTICSService handleUrl:url];
//    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//
//}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    
//    //    [JANALYTICSService handleUrl:url];
//
//}

//极光方法

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}


//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//实现注册APNs失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

//添加处理APNs通知回调方法
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    NSLog(@"22222222%@",userInfo);
    
//    if (userInfo[@"agent_type"]) {
//
//        switch ([userInfo[@"agent_type"] integerValue]) {
//            case 0:
//            {
//                break;
//            }
//            case 1:
//            {
//                [UserModel defaultModel].agent_identity = @"1";
//                break;
//            }
//            case 2:
//            {
//                [UserModel defaultModel].agent_identity = @"1";
//                break;
//            }
//            case 3:
//            {
//                [UserModel defaultModel].agent_identity = @"2";
//                break;
//            }
//            case 4:{
//
//                [UserModel defaultModel].agent_identity = @"3";
//                break;
//            }
//            default:
//                break;
//        }
//        [UserModelArchiver archive];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadType" object:nil];
//    }
//
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//
//
//    }
//    else {
//        // 判断为本地通知
//        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
//    }
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    //    NSLog(@"1111111%@",userInfo);
    
//    if (userInfo[@"agent_type"]) {
//
//        switch ([userInfo[@"agent_type"] integerValue]) {
//            case 0:
//            {
//                break;
//            }
//            case 1:
//            {
//                [UserModel defaultModel].agent_identity = @"1";
//                break;
//            }
//            case 2:
//            {
//                [UserModel defaultModel].agent_identity = @"1";
//                break;
//            }
//            case 3:
//            {
//                [UserModel defaultModel].agent_identity = @"2";
//                break;
//            }
//            case 4:{
//
//                [UserModel defaultModel].agent_identity = @"3";
//                break;
//            }
//            default:
//                break;
//        }
//        [UserModelArchiver archive];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadType" object:nil];
//    }
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        [self GotoHome];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    //    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:[badge integerValue]];
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    
    completionHandler();  // 系统要求执行这个方法
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    //    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    completionHandler(UIBackgroundFetchResultNewData);
    
    [self GotoHome];
    if (application.applicationState == UIApplicationStateActive) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
        
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"%@",userInfo);
    application.applicationIconBadgeNumber += 1;
    
//    if (userInfo[@"agent_type"]) {
//
//        switch ([userInfo[@"agent_type"] integerValue]) {
//            case 0:
//            {
//                break;
//            }
//            case 1:
//            {
//                [UserModel defaultModel].agent_identity = @"1";
//                break;
//            }
//            case 2:
//            {
//                [UserModel defaultModel].agent_identity = @"1";
//                break;
//            }
//            case 3:
//            {
//                [UserModel defaultModel].agent_identity = @"2";
//                break;
//            }
//            case 4:{
//
//                [UserModel defaultModel].agent_identity = @"3";
//                break;
//            }
//            default:
//                break;
//        }
    
//        [UserModelArchiver archive];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadType" object:nil];
//    }
    application.applicationIconBadgeNumber += 1;
    
    [self GotoHome];
    
    if (application.applicationState == UIApplicationStateActive) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    //    [self UpdateRequest];
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //    [self UpdateRequest];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
