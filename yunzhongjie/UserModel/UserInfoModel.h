//
//  UserInfoModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel

@property (nonatomic, strong) NSString *absolute_address;

@property (nonatomic, strong) NSString *account;

@property (nonatomic, strong) NSString *birth;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *district;

@property (nonatomic, strong) NSString *head_img;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *tel;

@property (nonatomic, strong) NSString *is_accept_grab;

@property (nonatomic, strong) NSString *is_accept_msg;

+ (UserInfoModel *)defaultModel;


@end
