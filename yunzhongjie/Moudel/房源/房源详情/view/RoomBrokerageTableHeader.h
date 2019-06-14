//
//  RoomBrokerageTableHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RoomBrokerageTableHeader;

typedef void(^DropBtnBlock)(NSInteger index);

@interface RoomBrokerageTableHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) DropBtnBlock dropBtnBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *dropBtn;

@property (nonatomic , strong)UIButton *headerbtn;

@end
