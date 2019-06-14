//
//  BaseRequest.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <AFNetworkReachabilityManager.h>

@interface BaseRequest : NSObject

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure;

+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure;


//+ (void)ThirdLogin:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure;
//
//+ (void)Updateimg:(NSString *)url parameters:(NSDictionary *)parameters  constructionBody:(void (^)(id <AFMultipartFormData> formData))blocks success:(void (^)(id resposeObject))success failure:(void (^)(NSError *error))failure;
+ (void)UpdateFile:(void (^)(id <AFMultipartFormData> formData))blocks url:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id resposeObject))success failure:(void(^)(NSError *error))failure;




@end
