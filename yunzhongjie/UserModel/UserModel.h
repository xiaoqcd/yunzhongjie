//
//  UserModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserModel : NSObject


@property (nonatomic , strong) NSString *Token;
@property (nonatomic , strong) NSString *Account;
@property (nonatomic , strong) NSString *Password;
@property (nonatomic , strong) NSString *agent_id;
@property (nonatomic , strong) NSArray *butter_project;
@property (nonatomic , strong) NSString *company_id;
@property (nonatomic , strong) NSString *company_name;
@property (nonatomic , strong) NSString *head_img;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *state;
@property (nonatomic , strong) NSString *store_id;
@property (nonatomic , strong) NSString *store_identity;
@property (nonatomic , strong) NSString *tel;
@property (nonatomic , strong) NSString *sex;
@property (nonatomic , strong) NSString *province;
@property (nonatomic , strong) NSString *city;
@property (nonatomic , strong) NSString *district;
@property (nonatomic , strong) NSString *birth;


@property (nonatomic , strong) NSDictionary *Configdic;
+ (UserModel *)defaultModel;

@end
