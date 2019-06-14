//
//  ProjectHeader.h
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZQFlowLayout.h"

typedef void(^ImgBtnBlock)(NSInteger num,NSArray *imgArr);
NS_ASSUME_NONNULL_BEGIN

@interface ProjectHeader : UITableViewHeaderFooterView

//@property (nonatomic, copy) AttentBtnBlock attentBtnBlock;

@property (nonatomic , copy) ImgBtnBlock imgBtnBlock;

@property (nonatomic , strong) UIScrollView *imgScroll;

@property (nonatomic , strong) UILabel *numL;

@property (nonatomic , strong) NSMutableArray *imgArr;

@property (nonatomic , strong) UIImageView *imgV;

@property (nonatomic , strong) UILabel *titleL;

@property (nonatomic , strong) UILabel *priceL;

@property (nonatomic, strong) UIImageView *addressImg;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic , strong) UILabel *stateL;

@property (nonatomic , strong) NSString *lon;

@property (nonatomic , strong) NSString *lat;

@property (nonatomic , strong) NSMutableArray *propertyArr;

-(void)setImgArr:(NSMutableArray *)imgArr;


@end
NS_ASSUME_NONNULL_END
