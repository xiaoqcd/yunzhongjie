//
//  DealCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DealCell.h"

@implementation DealCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    return self;
}

-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    //    _selectImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"default"]];
    //    _selectImg.frame = CGRectMake(10*SIZE, 29*SIZE, 15*SIZE, 15*SIZE);
    //    [self addSubview:_selectImg];
//    _headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"company"]];
//    _headerImg.frame = CGRectMake(10*SIZE, 10*SIZE, 100*SIZE, 70*SIZE);
//    //    _headerImg.layer.masksToBounds = YES;
//    //    _headerImg.layer.cornerRadius = 35*SIZE;
//    [self addSubview:_headerImg];
    _customerL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 20*SIZE, 200*SIZE, 14*SIZE)];
    _customerL.text = @"客户：张三  18381685663";
    _customerL.textColor = CLContentLabColor;
    _customerL.font = FONT(12);
    [self addSubview:_customerL];
    
    _agentL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 40*SIZE, 300*SIZE, 14*SIZE)];
    _agentL.text = @"推荐人：李四/大禹东路门店  18888888888";
    _agentL.textColor = CLContentLabColor;
    _agentL.font = FONT(12);
    [self addSubview:_agentL];
    
    //    [self addSubview:_headerImg];
    _typeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 60*SIZE, 300*SIZE, 14*SIZE)];
    _typeL.text = @"类型：成交佣金";
    _typeL.textColor = CLContentLabColor;
    _typeL.font = FONT(12);
    [self addSubview:_typeL];
    
    _houseL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 80*SIZE, 300*SIZE, 13*SIZE)];
    _houseL.text = @"房号：一批次/1栋202";
    _houseL.font = FONT(12);
    _houseL.textColor = CLContentLabColor;
    [self addSubview:_houseL];
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 100*SIZE, 340*SIZE, 13*SIZE)];
    _timeL.text = @"推荐时间：2019.01.01 18:00";
    _timeL.font = FONT(12);
    _timeL.textColor = CLContentLabColor;
    [self addSubview:_timeL];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 119*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    
}

@end
