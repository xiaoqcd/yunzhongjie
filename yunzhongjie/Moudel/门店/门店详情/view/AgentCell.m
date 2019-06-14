//
//  AgentCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/30.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AgentCell.h"

@implementation AgentCell

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
    _headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"company"]];
    _headerImg.frame = CGRectMake(10*SIZE, 10*SIZE, 70*SIZE, 70*SIZE);
        _headerImg.layer.masksToBounds = YES;
        _headerImg.layer.cornerRadius = 35*SIZE;
    [self addSubview:_headerImg];
    _companyL = [[UILabel alloc]initWithFrame:CGRectMake(80*SIZE, 20*SIZE, 200*SIZE, 14*SIZE)];
    _companyL.text = @"姓名：2019";
    _companyL.textColor = CLTitleLabColor;
    _companyL.font = FONT(13);
    [self addSubview:_companyL];
    
    _adressL = [[UILabel alloc]initWithFrame:CGRectMake(80*SIZE, 40*SIZE, 200*SIZE, 14*SIZE)];
    _adressL.text = @"联系方式：18888888888";
    _adressL.textColor = CLContentLabColor;
    _adressL.font = FONT(12);
    [self addSubview:_adressL];
    
    //    [self addSubview:_headerImg];
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(80*SIZE, 58*SIZE, 200*SIZE, 14*SIZE)];
    _nameL.text = @"角色：经纪人";
    _nameL.textColor = CLContentLabColor;
    _nameL.font = FONT(12);
    [self addSubview:_nameL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(80*SIZE, 76*SIZE, 200*SIZE, 13*SIZE)];
    _phoneL.text = @"入职时间：2019.01.01 17:55";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CLContentLabColor;
    [self addSubview:_phoneL];
    
    _newcountL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 95*SIZE, 110*SIZE, 13*SIZE)];
    _newcountL.text = @"新房排名：2";
    _newcountL.font = FONT(12);
    _newcountL.textColor = CLContentLabColor;
    [self addSubview:_newcountL];
    _twocountL = [[UILabel alloc]initWithFrame:CGRectMake(120*SIZE, 95*SIZE, 120*SIZE, 13*SIZE)];
    _twocountL.text = @"新房排名：2";
    _twocountL.font = FONT(12);
    _twocountL.textColor = CLContentLabColor;
    _twocountL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_twocountL];
    _rentcountL = [[UILabel alloc]initWithFrame:CGRectMake(240*SIZE, 95*SIZE, 110*SIZE, 13*SIZE)];
    _rentcountL.text = @"新房排名：2";
    _rentcountL.font = FONT(12);
    _rentcountL.textAlignment = NSTextAlignmentRight;
    _rentcountL.textColor = CLContentLabColor;
    [self addSubview:_rentcountL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 114*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    
}
@end
