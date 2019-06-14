//
//  CountBtn.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/5.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSUInteger, BtnState){
    UnSelect_State=0,
    Select_State=1
};

@interface CountBtn : UIButton

@property (nonatomic , strong) UILabel *titleL;
@property (nonatomic , strong) UILabel *contentL;

-(void)SettitleL:(NSString *)title contentL:(NSString *)content;
-(void)SetBtnState:(BtnState)btnState;

@end

NS_ASSUME_NONNULL_END
