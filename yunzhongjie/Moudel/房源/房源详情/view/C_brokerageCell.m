//
//  C_brokerageCell.m
//  云渠道
//
//  Created by xiaoq on 2018/5/24.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "C_brokerageCell.h"

@implementation C_brokerageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBackColor;
    
    _ruleView = [[UIView alloc] init];
    _ruleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_ruleView];
    
    UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(11 *SIZE, 12 *SIZE, 17 *SIZE, 17 *SIZE)];
    titleImg.image = [UIImage imageNamed:@"rules"];
    [_ruleView addSubview:titleImg];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(42 *SIZE, 13 *SIZE, 200 *SIZE, 14 *SIZE)];
    titleL.textColor = CLTitleLabColor;
    titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    titleL.text = @"佣金规则";
    [_ruleView addSubview:titleL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = CLBackColor;
    [_ruleView addSubview:line];
    
    _ruleL = [[UILabel alloc] init];
    _ruleL.textColor = CL86Color;
    _ruleL.font = [UIFont systemFontOfSize:12 *SIZE];
    _ruleL.numberOfLines = 0;
    [_ruleView addSubview:_ruleL];
    
    [self MasonryUI];
}

-(void)SetRuleContent:(NSString *)content
{
    _ruleL.text = content;
    [_ruleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ruleView).offset(41 *SIZE);
        make.top.equalTo(_ruleView).offset(58 *SIZE);
        make.width.mas_equalTo(290 *SIZE);
//        make.bottom.equalTo(_ruleView).offset(-31 *SIZE);
    }];
}

- (void)MasonryUI{
    
    [_ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
    
    [_ruleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_ruleView).offset(41 *SIZE);
        make.top.equalTo(_ruleView).offset(58 *SIZE);
        make.width.mas_equalTo(304 *SIZE);
        make.bottom.equalTo(_ruleView).offset(-31 *SIZE);
    }];
}

@end
