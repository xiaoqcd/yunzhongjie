//
//  HouseCell.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HouseCell : UITableViewCell
@property (nonatomic , strong) UIImageView *headerImg;
@property (nonatomic , strong) UILabel *companyL;
@property (nonatomic , strong) UILabel *adressL;
@property (nonatomic , strong) UILabel *nameL;
@property (nonatomic , strong) UILabel *phoneL;
@property (nonatomic , strong) UILabel *timeL;

@end

NS_ASSUME_NONNULL_END
