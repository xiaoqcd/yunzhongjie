//
//  MessageCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell


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
    _titelL.text = @"号码判重";
    _titelL.textColor = CLTitleLabColor;
    _titelL.font = FONT(13);
    [self addSubview:_titelL];

    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 30*SIZE, 350*SIZE, 14*SIZE)];
    _nameL.text = @"姓名：李想";
    _nameL.textColor = CLContentLabColor;
    _nameL.font = FONT(12);
    [self addSubview:_nameL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 50*SIZE, 350*SIZE, 13*SIZE)];
    _phoneL.text = @"客户电话：18381383883";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CLContentLabColor;
    [self addSubview:_phoneL];
    
    _infoL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 70*SIZE, 350*SIZE, 13*SIZE)];
    _infoL.text = @"角色：勘察，带看，签约，过户";
    _infoL.font = FONT(12);
    _infoL.textColor = CLContentLabColor;
    [self addSubview:_infoL];
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 90*SIZE, 350*SIZE, 13*SIZE)];
    _timeL.text = @"失效时间：2019.01.01 17:40";
    _timeL.font = FONT(12);
    _timeL.textColor = CLContentLabColor;
    [self addSubview:_timeL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 114*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(300*SIZE, 75*SIZE, 50*SIZE, 25*SIZE);
    _sureBtn.backgroundColor = CLLoginBtnColor;
    [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_sureBtn];
    
}
@end
