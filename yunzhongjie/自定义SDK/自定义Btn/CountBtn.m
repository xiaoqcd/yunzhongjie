//
//  CountBtn.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "CountBtn.h"

@implementation CountBtn


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2 *SIZE;
        [self addSubview:self.titleL];
        [self addSubview:self.contentL];
    }
     return self;
}

-(UILabel *)titleL{

    if (!_titleL) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(0,10*SIZE, 100*SIZE, 15*SIZE)];
        _titleL.textColor = CLTitleLabColor;
        _titleL.font = FONT(13);
//        _titleL.text =@"累计笔数";
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}

-(UILabel *)contentL{
    
    if (!_contentL) {
        _contentL = [[UILabel alloc]initWithFrame:CGRectMake(0,25*SIZE, 100*SIZE, 15*SIZE)];
        _contentL.textColor = CLTitleLabColor;
//        _contentL.text =@"累计笔数";
        _contentL.font = FONT(13);
        _contentL.textAlignment = NSTextAlignmentCenter;
    }
    return _contentL;
}

-(void)SetBtnState:(BtnState)btnState{
    if (btnState == UnSelect_State) {
        self.backgroundColor = CLLightGrayColor;
    }
    else{
        self.backgroundColor = CLBlueBtnColor;
    }
}

- (void)SettitleL:(NSString *)title contentL:(NSString *)content
{
    _titleL.text = title;
    _contentL.text = content;
}

@end
