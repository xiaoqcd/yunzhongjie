//
//  AgentCell.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentCell : UITableViewCell
@property (nonatomic , strong) UIImageView *headerImg;
@property (nonatomic , strong) UILabel *companyL;
@property (nonatomic , strong) UILabel *adressL;
@property (nonatomic , strong) UILabel *nameL;
@property (nonatomic , strong) UILabel *phoneL;
@property (nonatomic , strong) UILabel *newcountL;
@property (nonatomic , strong) UILabel *twocountL;
@property (nonatomic , strong) UILabel *rentcountL;


@end

NS_ASSUME_NONNULL_END
