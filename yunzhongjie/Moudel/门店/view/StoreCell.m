//
//  StoreCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

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
    //    _headerImg.layer.masksToBounds = YES;
    //    _headerImg.layer.cornerRadius = 24*SIZE;
    [self addSubview:_headerImg];
    _companyL = [[UILabel alloc]initWithFrame:CGRectMake(80*SIZE, 20*SIZE, 200*SIZE, 14*SIZE)];
    _companyL.text = @"云算科技";
    _companyL.textColor = CLTitleLabColor;
    _companyL.font = FONT(13);
    [self addSubview:_companyL];
    
    _adressL = [[UILabel alloc]initWithFrame:CGRectMake(80*SIZE, 40*SIZE, 200*SIZE, 14*SIZE)];
    _adressL.text = @"四川省成都市成华区富乐路88号";
    _adressL.textColor = CLContentLabColor;
    _adressL.font = FONT(12);
    [self addSubview:_adressL];
    
    //    [self addSubview:_headerImg];
    _nameL = [[UILabel alloc]initWithFrame:CGRectMake(80*SIZE, 58*SIZE, 200*SIZE, 14*SIZE)];
        _nameL.text = @"店长：张三，李四";
    _nameL.textColor = CLContentLabColor;
    _nameL.font = FONT(12);
    [self addSubview:_nameL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(80*SIZE, 76*SIZE, 200*SIZE, 13*SIZE)];
        _phoneL.text = @"联系方式：18888888888";
    _phoneL.font = FONT(12);
    _phoneL.textColor = CLContentLabColor;
    [self addSubview:_phoneL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 94*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
}

@end
