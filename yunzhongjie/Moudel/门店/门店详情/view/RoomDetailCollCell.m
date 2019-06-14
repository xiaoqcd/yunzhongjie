
//
//  RoomDetailCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailCollCell.h"

@implementation RoomDetailCollCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 66 *SIZE, 14 *SIZE)];
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleL];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(20 *SIZE, 42, 28 *SIZE, 2)];
    _line.backgroundColor = COLOR(27, 152, 255, 1);
    _line.hidden = YES;
    [self.contentView addSubview:_line];
}

- (void)setSelected:(BOOL)selected{
    
    if (selected) {
        
        _titleL.textColor = COLOR(27, 152, 255, 1);
        _line.hidden = NO;
    }else{
        
        _titleL.textColor = CLTitleLabColor;
        _line.hidden = YES;
    }
}

@end
