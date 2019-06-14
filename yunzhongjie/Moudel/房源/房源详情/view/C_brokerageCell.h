//
//  C_brokerageCell.h
//  云渠道
//
//  Created by xiaoq on 2018/5/24.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C_brokerageCell : UITableViewCell

@property (nonatomic, strong) UIView *ruleView;

@property (nonatomic, strong) UIImageView *ruleImg;

@property (nonatomic, strong) UILabel *ruleL;

-(void)SetRuleContent:(NSString *)content;

@end
