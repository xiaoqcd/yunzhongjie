//
//  RoomBrokerageTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomBrokerageTableHeader.h"

@implementation RoomBrokerageTableHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionDropBtn:(UIButton *)btn{
    
    _dropBtn.selected =!_dropBtn.selected;
    if (self.dropBtnBlock) {
        self.dropBtnBlock(_dropBtn.tag);
    }
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 50 *SIZE)];
    view.backgroundColor = CLBackColor;
    [self.contentView addSubview:view];
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 20 *SIZE, 300 *SIZE, 11 *SIZE)];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _dropBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dropBtn.frame = CGRectMake(331 *SIZE, 15 *SIZE, 22 *SIZE, 22 *SIZE);
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionDropBtn:)]];
    [self.contentView addSubview:_dropBtn];
}

@end
