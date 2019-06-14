//
//  StoreCountCell.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountBtn.h"
//#import "DottedLine.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreCountCell : UITableViewCell
typedef void(^BtnBlock)(NSInteger tag);

@property (nonatomic, copy) BtnBlock btnblock;

@property (nonatomic , strong) CountBtn *btn1;
@property (nonatomic , strong) CountBtn *btn2;
@property (nonatomic , strong) CountBtn *btn3;
@property (nonatomic , strong) CountBtn *btn4;
@property (nonatomic , strong) CountBtn *btn5;
@property (nonatomic , strong) CountBtn *btn6;
@property (nonatomic , strong) CountBtn *btn7;
@property (nonatomic , strong) CountBtn *btn8;
@property (nonatomic , strong) CountBtn *btn9;


@end

NS_ASSUME_NONNULL_END
