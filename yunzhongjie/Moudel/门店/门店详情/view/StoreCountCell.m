//
//  StoreCountCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreCountCell.h"

@implementation StoreCountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
        self.backgroundColor = CL248Color;
    }
    return self;
}


- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
    //  线条颜色
    border.strokeColor = [UIColor blackColor].CGColor;
    
    border.fillColor = nil;
    
    
    UIBezierPath *pat = [UIBezierPath bezierPath];
    [pat moveToPoint:CGPointMake(0, 0)];
    if (CGRectGetWidth(view.frame) > CGRectGetHeight(view.frame)) {
        [pat addLineToPoint:CGPointMake(view.bounds.size.width, 0)];
    }else{
        [pat addLineToPoint:CGPointMake(0, view.bounds.size.height)];
    }
    border.path = pat.CGPath;
    
    border.frame = view.bounds;
    
    // 不要设太大 不然看不出效果
    border.lineWidth = 1;
    border.lineCap = @"butt";
    
    //  第一个是 线条长度   第二个是间距    nil时为实线
    border.lineDashPattern = @[@6, @10];
    
    [view.layer addSublayer:border];
}

-(void)initUI{
    
    UIView *dottedline = [[UIView alloc]initWithFrame:CGRectMake(0, 39*SIZE, 360*SIZE, 1)];
    [self addBorderToLayer:dottedline];
//    [dottedline setNeedsDisplay];
    [self addSubview:dottedline];
    NSArray *arr = @[@"累计",@"本月",@"今日"];
    
    for (int i = 0; i<3; i++) {
        UILabel *title =  [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE+120*SIZE*i, 10*SIZE, 100*SIZE, 15*SIZE)];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = FONT(15*SIZE);
        title.text = arr[i];
        title.textColor = CLTitleLabColor;
        [self addSubview:title];
        
        for (int j = 0; j<3; j++) {
            CountBtn *btn = [[CountBtn alloc]initWithFrame:CGRectMake(10*SIZE+120*SIZE*i, 40*SIZE+60*SIZE*j, 100*SIZE, 50*SIZE)];
            [btn SettitleL:@"全部笔数" contentL:@"2000"];
            btn.tag = i+j*10;
            [btn addTarget:self action:@selector(action_touch:) forControlEvents:UIControlEventTouchUpInside];
//            [btn SetBtnState:Select_State];
//            [btn SetBtnState:UnSelect_State];

//            btn.frame = CGRectMake(10*SIZE+120*SIZE*i, 40*SIZE+60*SIZE*j, 100*SIZE, 50*SIZE);
//            btn.backgroundColor =[UIColor grayColor];
            [self addSubview:btn];
            if (j==0) {
                if (i==0) {
                    _btn1 = btn;
                }
                else if(i==1)
                {
                    _btn2 = btn;
                }else{
                    _btn3 = btn;
                }
            }
            else if(j==1){
                if (i==0) {
                    _btn4 = btn;
                }
                else if(i==1)
                {
                    _btn5 = btn;
                }else{
                    _btn6 = btn;
                }
            }
            else{
                if (i==0) {
                    _btn7 = btn;
                }
                else if(i==1)
                {
                    _btn8 = btn;
                }else{
                    _btn9 = btn;
                }
            }
        }
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 209*SIZE, 360*SIZE, 1*SIZE)];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
}

-(void)action_touch:(CountBtn *)btn
{
    if (self.btnblock) {
        
        self.btnblock(btn.tag);
    }
}
@end
