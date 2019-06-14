//
//  StoreHeader.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreHeader.h"

@implementation StoreHeader


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self initUI];
//    }
//    return self;
//}

-(void)initUI{
    _storeL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 5*SIZE, 170*SIZE, 14*SIZE)];
    _storeL.text = @"门店总数：32";
    _storeL.textColor = CLTitleLabColor;
    _storeL.font = FONT(13);
    [self addSubview:_storeL];
    
    _agentL = [[UILabel alloc]initWithFrame:CGRectMake(180*SIZE, 5*SIZE, 170*SIZE, 14*SIZE)];
    _agentL.text = @"经纪人总数：332";
    _agentL.textAlignment = NSTextAlignmentRight;
    _agentL.textColor = CLTitleLabColor;
    _agentL.font = FONT(13);
    [self addSubview:_agentL];
    
}

@end
