//
//  ProjectDetailVC.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectDetailVC : BaseViewController
@property (nonatomic , strong) NSString *project_id;

@property (nonatomic , strong) NSString *rule_id;

@property (nonatomic , strong) NSString *start;
@end

NS_ASSUME_NONNULL_END
