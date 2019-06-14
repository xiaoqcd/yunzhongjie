//
//  HouseCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "HouseCell.h"

@implementation HouseCell

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
    _headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"project_def"]];
    _headerImg.frame = CGRectMake(10*SIZE, 10*SIZE, 110*SIZE, 80*SIZE);
//    _headerImg.layer.masksToBounds = YES;
//    _headerImg.layer.cornerRadius = 35*SIZE;
    [self addSubview:_headerImg];
    _companyL = [[UILabel alloc]initWithFrame:CGRectMake(130*SIZE, 10*SIZE, 200*SIZE, 14*SIZE)];
//    _companyL.text = @"云算公馆";
    _companyL.textColor = CLTitleLabColor;
    _companyL.font = FONT(13);
    [self addSubview:_companyL];
    
    _adressL = [[UILabel alloc]initWithFrame:CGRectMake(130*SIZE, 30*SIZE, 200*SIZE, 14*SIZE)];
//    _adressL.text = @"四川省成都市成华区";
    _adressL.textColor = CLContentLabColor;
    _adressL.font = FONT(12);
    [self addSubview:_adressL];
    
    //    [self addSubview:_headerImg];
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(130*SIZE, 50*SIZE, 200*SIZE, 14*SIZE)];
//    _nameL.text = @"推荐等级：";
    _nameL.textColor = CLContentLabColor;
    _nameL.font = FONT(12);
    [self addSubview:_nameL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(130*SIZE, 70*SIZE, 200*SIZE, 13*SIZE)];
    _phoneL.text = @"推荐等级：";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CLContentLabColor;
    [self addSubview:_phoneL];
    
    _timeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 95*SIZE, 340*SIZE, 13*SIZE)];
    _timeL.text = @"2018.01.01 09:00 - 2019.01.03 10:00";
    _timeL.font = FONT(12);
    _timeL.textColor = CLContentLabColor;
    [self addSubview:_timeL];

    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 114*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    
}

@end
