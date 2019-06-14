//
//  StoreCell.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreCell : UITableViewCell
@property (nonatomic , strong) UIImageView *headerImg;
@property (nonatomic , strong) UILabel *companyL;
@property (nonatomic , strong) UILabel *adressL;
@property (nonatomic , strong) UILabel *nameL;
@property (nonatomic , strong) UILabel *phoneL;

@end

NS_ASSUME_NONNULL_END
