//
//  CustomerListCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CustomerListCell.h"

@implementation CustomerListCell

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
    
    _titelL =[[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 10*SIZE, 350*SIZE, 14*SIZE)];
//    _titelL.text = @"号码判重";
    _titelL.textColor = CLTitleLabColor;
    _titelL.font = FONT(13);
    [self addSubview:_titelL];
    
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 30*SIZE, 350*SIZE, 14*SIZE)];
//    _nameL.text = @"姓名：李想";
    _nameL.textColor = CLContentLabColor;
    _nameL.font = FONT(12);
    [self addSubview:_nameL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 50*SIZE, 350*SIZE, 13*SIZE)];
//    _phoneL.text = @"客户电话：18381383883";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CLContentLabColor;
    [self addSubview:_phoneL];
    
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 70*SIZE, 350*SIZE, 13*SIZE)];
//    _timeL.text = @"失效时间：2019.01.01 17:40";
    _timeL.font = FONT(12);
    _timeL.textColor = CLContentLabColor;
    [self addSubview:_timeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 94*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    

}

@end
