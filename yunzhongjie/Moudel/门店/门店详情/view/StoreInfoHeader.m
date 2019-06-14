//
//  StoreInfoHeader.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreInfoHeader.h"

@implementation StoreInfoHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}


-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    _storenumL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 5*SIZE, 300*SIZE, 14*SIZE)];
    _storenumL.text = @"门店编号：0001";
    _storenumL.textColor = CLTitleLabColor;
    _storenumL.font = FONT(13);
    [self addSubview:_storenumL];
    
    _storenameL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 25*SIZE, 300*SIZE, 14*SIZE)];
    _storenameL.text = @"门店名称：大禹东路二店";
    _storenameL.textColor = CLTitleLabColor;
    _storenameL.font = FONT(13);
    [self addSubview:_storenameL];
    
    _storeadressL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 45*SIZE, 300*SIZE, 14*SIZE)];
    _storeadressL.text = @"门店地址：四川省成都市郫都区大禹东路96号";
    _storeadressL.textColor = CLTitleLabColor;
    _storeadressL.font = FONT(13);
    [self addSubview:_storeadressL];
    

    
    _peoplenumL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 65*SIZE, 300*SIZE, 14*SIZE)];
    _peoplenumL.text = @"经纪人总数：20";
    _peoplenumL.textColor = CLTitleLabColor;
    _peoplenumL.font = FONT(13);
    [self addSubview:_peoplenumL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 84*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    
}

@end
