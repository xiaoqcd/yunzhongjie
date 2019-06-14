//
//  StoreCountHeader.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreCountHeader.h"

@implementation StoreCountHeader

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
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 0 *SIZE, 7 *SIZE, 15 *SIZE)];
    colorView.backgroundColor = CLBlueBtnColor;
    [self.contentView addSubview:colorView];
    
    _titelL = [[UILabel alloc]initWithFrame:CGRectMake(30*SIZE, 0*SIZE, 300*SIZE, 14*SIZE)];
    _titelL.text = @"新房";
    _titelL.textColor = CLTitleLabColor;
    _titelL.font = FONT(15);
    [self addSubview:_titelL];
    
//    _countL = [[UILabel alloc]initWithFrame:CGRectMake(50*SIZE, 5*SIZE, 300*SIZE, 14*SIZE)];
//    _countL.text = @"排名：2";
//    _countL.textAlignment = NSTextAlignmentRight;
//    _countL.textColor = CLTitleLabColor;
//    _countL.font = FONT(13);
//    [self addSubview:_countL];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 34*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    
}

@end
