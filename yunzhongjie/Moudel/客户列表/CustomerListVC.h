//
//  CustomerListVC.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomerListVC : BaseViewController

@property (nonatomic , strong) NSString *rule_id;

@property (nonatomic , strong) NSString *start_time;
@property (nonatomic , strong) NSString *end_time;
@property (nonatomic , strong) NSString *type;



@end

NS_ASSUME_NONNULL_END
