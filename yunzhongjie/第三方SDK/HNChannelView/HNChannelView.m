//
//  HNChannelView.m
//  headlineNews
//
//  Created by dengweihao on 2017/11/21.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "HNChannelView.h"
#import "HNChannelModel.h"
#import "HNTitleView.h"
#import "HNButton.h"
#import "UIView+Frame.h"



#define MYCHANNEL_FRAME(i) CGRectMake(itemSpace + (i % column)* (_labelWidth + itemSpace), CGRectGetMaxY(wself.header1_frame) + lineSpace + (i / column)*(labelHeight + lineSpace), _labelWidth, labelHeight)
#define RECOMMEND_FRAME(i)  CGRectMake(itemSpace + ((i) % column)* (_labelWidth + itemSpace),CGRectGetMaxY(wself.divisionModel.frame) + wself.header1_frame.size.height + lineSpace + ((i) / column)*(labelHeight + lineSpace), _labelWidth, labelHeight)

static CGFloat itemSpace = 10;
static CGFloat lineSpace = 10;
static int column = 4;
static CGFloat labelHeight = 40;


@interface HNChannelView ()<UIScrollViewDelegate>

@property (nonatomic , strong)NSMutableArray *myChannelArr;
@property (nonatomic , strong)NSMutableArray *recommendChannelArr;
// iOS6 之后不用自己手动回收 
@property (nonatomic , strong)dispatch_queue_t queue;
@property (nonatomic , strong)NSMutableArray *datas;
@property (nonatomic , assign)CGFloat labelWidth;
@property (nonatomic , weak)HNTitleView *header1;
@property (nonatomic , weak)HNTitleView *header2;
@property (nonatomic , weak)HNChannelModel *divisionModel;
@property (nonatomic , assign)CGRect header1_frame;

@end

@interface HNHeaderView : UIView
@property (nonatomic , copy) void(^callBack)(void);

@end

@implementation HNChannelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _myChannelArr =
//        _recommendChannelArr =
//        for (int i=0; i<_myChannelArr.count; i++) {
//            [_recommendChannelArr removeObject:_myChannelArr[i]];
//        }
        [self setUI];
        _labelWidth = (self.frame.size.width - itemSpace *(column + 1))/column;
        _datas = [NSMutableArray array];
        _queue = dispatch_queue_create("com.headlineNews.queue", DISPATCH_QUEUE_SERIAL);
        self.delegate = self;
        [self configData];
    }
    return self;
}

- (void)setUI {
    __weak typeof(self) wself = self;
    HNTitleView *header1 = [[HNTitleView alloc]initWithTitle:@"我的频道" subTitle:@"点击进入频道" needEditBtn:YES];
    header1.frame = CGRectMake(0, 40, self.frame.size.width, 54);
    _header1 = header1;
    [wself.header1 setCallBack:^(BOOL selected) {
        [wself refreshEidtBtnWithStatus:selected];
    }];
    HNTitleView *header2 = [[HNTitleView alloc]initWithTitle:@"推荐频道" subTitle:@"点击添加频道" needEditBtn:NO];
    _header2 = header2;
    _header2.hidden = YES;
    _header2.frame = _header2.bounds;
    
    HNHeaderView *headerView = [[HNHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40)];
    [headerView setCallBack:^{
        [wself hide];
    }];
    
    [self addSubview:headerView];
    [self addSubview:_header1];
    [self addSubview:_header2];
    self.backgroundColor = [UIColor whiteColor];
    _header1_frame = wself.header1.frame;
}


- (void)configData {
    __weak typeof(self) wself = self;
    dispatch_async(_queue, ^{
        for (int i = 0 ; i < wself.myChannelArr.count; i++) {
            HNChannelModel *model = [[HNChannelModel alloc]init];
            model.name = wself.myChannelArr[i];
            model.isMyChannel = YES;
            if ([wself.myChannelArr[i] isEqualToString:@"推荐"]||[wself.myChannelArr[i] isEqualToString:@"关注"]) {
                model.isRegular = YES;
            }
            else{
                model.isRegular = NO;
            }
            [wself.datas addObject:model];
        }
        for (int i = 0 ; i < wself.recommendChannelArr.count; i++) {
            HNChannelModel *model = [[HNChannelModel alloc]init];
            model.name = wself.recommendChannelArr[i];
            model.isMyChannel = NO;
            model.isRegular = NO;
            [wself.datas addObject:model];
            
        }
        [wself refreshFrames];
    });
}

- (void)refreshFrames {
    __weak typeof(self) wself = self;

    for (int i = 0 ; i < wself.datas.count; i++) {
        HNChannelModel *model = wself.datas[i]; // model.tag 等于btn的tag 且为该数组中元素的下标
        model.tag = i;
        if (model.isMyChannel) {
            model.frame = MYCHANNEL_FRAME(i);
            wself.divisionModel = model;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        wself.header2.top = CGRectGetMaxY(wself.divisionModel.frame) + lineSpace;
        wself.header2.hidden = NO;
    });
    
    for (int i = 0 ; i < wself.datas.count; i++) {
        HNChannelModel *model = wself.datas[i];
        if (!model.isMyChannel) {
            int index = i - wself.divisionModel.tag - 1; // 从0开始tag
             model.frame = RECOMMEND_FRAME(index);
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        for (HNChannelModel *model in wself.datas) {
            HNButton *button = [[HNButton alloc]initWithMyChannelHandleBlock:^(HNButton *btn) {
                if (!btn.deleImageView.hidden) {
                    [wself removeBtn:btn];
                }else
                {
                    NSMutableArray *arr = [NSMutableArray array];
                    for (int i= 0; i<_datas.count; i++) {
                        HNChannelModel *model = _datas[i];
                        if (model.isMyChannel) {
                            [arr addObject:model.name];
                        }
                    }
//                    [UserModel defaultModel].tagSelectArr = arr;
                    [UserModelArchiver archive];
                    self.clickblook(btn.model.tag);
                    [self hide];
                }
                
            } recommondChannelHandleBlock:^(HNButton *btn) {
                [wself addBtn:btn];
            }];
            
            [button addLongPressBeginBlock:^(HNButton *btn) {
                [wself addSubview:btn];
            } longPressMoveBlock:^(HNButton *btn, UILongPressGestureRecognizer *ges) {
                [wself adjustCenterForBtn:btn withGes:ges];
            } longPressEndBlock:^(HNButton *btn) {
                [wself resetBtnFrame:btn];
            }];
            button.model = model;
            if (button.model.name.length > 2) {
                button.titleLabel.adjustsFontSizeToFitWidth = YES;
            }
            if (model.tag == wself.datas.count - 1) {
                wself.contentSize = CGSizeMake(0, CGRectGetMaxY(model.frame) + 30);
            }
            [wself addSubview:button];
        }
    });
}

#pragma mark - 展示 和 隐藏
- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, STATUS_BAR_HEIGHT, self.width, self.height);
    }];
}

- (void)hide {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i= 0; i<_datas.count; i++) {
        HNChannelModel *model = _datas[i];
        if (model.isMyChannel) {
            [arr addObject:model.name];
        }
    }
//    [UserModel defaultModel].tagSelectArr = arr;
    [UserModelArchiver archive];
    self.hideblook();
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, self.height, self.width, self.height);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}



#pragma mark - 刷新编辑按钮的状态

- (void)refreshEidtBtnWithStatus:(BOOL)show {
    __weak typeof(self) wself = self;
    if (!show) {
        for (HNButton *btn in wself.subviews) {
            if (![btn isKindOfClass:[HNButton class]]) continue;
            if (btn.model.isMyChannel) {
                btn.deleImageView.hidden = YES;
            }else {
                btn.deleImageView.hidden = YES;
            }
        }
    }else {
        for (HNButton *btn in wself.subviews) {
            if (![btn isKindOfClass:[HNButton class]]) continue;
            if (btn.model.isMyChannel) {
                if (btn.model.isRegular) {
                    btn.deleImageView.hidden = YES;
                }
                else{
                
                    btn.deleImageView.hidden = NO;
                }
            }else {
                btn.deleImageView.hidden = YES;
            }
        }
    }
    
}

#pragma mark - 调整按钮的frame & 顺序

- (void)addBtn:(HNButton *)addbtn {

    __weak typeof(self) wself = self;
    [self.datas removeObject:addbtn.model];
    [self.datas insertObject:addbtn.model atIndex:self.divisionModel.tag + 1];
    addbtn.model.isMyChannel = YES;
    int divisionIndex = self.divisionModel.tag + 1;
    BOOL editBtnSelected = wself.header1.editBtn.selected;
    dispatch_async(_queue, ^{
        for (int i = 0 ; i < self.datas.count; i++) {
            HNChannelModel *channelModel = self.datas[i];
            channelModel.tag = i;
            if (channelModel.isMyChannel) {
                channelModel.frame = MYCHANNEL_FRAME(i);
               channelModel.hideDeleBtn = editBtnSelected ? NO : YES;
            }else {
                int index = i - wself.divisionModel.tag - 1;
                channelModel.frame = RECOMMEND_FRAME(index);
                channelModel.hideDeleBtn = YES;
            }
            if (i == divisionIndex) {
                self.divisionModel = channelModel;
            }
        }
        [self refreshBtn];

    });
    
    
}
- (void)removeBtn:(HNButton *)removeBtn {
 
    if (removeBtn.model.isRegular) {

        return;
    }
    else{
    __weak typeof(self) wself = self;
    [self.datas removeObject:removeBtn.model];
    [self.datas insertObject:removeBtn.model atIndex:self.divisionModel.tag];
    removeBtn.model.isMyChannel = NO;
    int divisionIndex = self.divisionModel.tag - 1;
    dispatch_async(_queue, ^{
        for (int i = 0 ; i < self.datas.count; i++) {
            HNChannelModel *channelModel = self.datas[i];
            channelModel.tag = i;
            if (channelModel.isMyChannel) {
                channelModel.frame = MYCHANNEL_FRAME(i);
                channelModel.hideDeleBtn = NO;
            }else {
                int index = i - self.divisionModel.tag - 1;
                channelModel.frame = RECOMMEND_FRAME(index);
                channelModel.hideDeleBtn = YES;
            }
            if (i == divisionIndex) {
                self.divisionModel = channelModel;
            }
        }
        [self refreshBtn];
    });
    }
    
}

- (void)refreshBtn {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        for (HNChannelModel *model in self.datas) {
            [UIView animateWithDuration:0.25 animations:^{
                model.btn.frame = model.frame;
            }];
            model.btn.deleImageView.hidden = model.hideDeleBtn;
            [model.btn reloadData];
        }
    });
}

#pragma mark - 调整按钮的 header2 的尺寸
- (void)setDivisionModel:(HNChannelModel *)divisionModel {
    _divisionModel = divisionModel;
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshHeader2Frame];
        });
    }else {
        [self refreshHeader2Frame];
    }
   
}
- (void)refreshHeader2Frame {
    if (self.header2.hidden) {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.header2.frame = CGRectMake(0, CGRectGetMaxY(self.divisionModel.frame)+lineSpace, self.frame.size.width, 54);
    }];
}

#pragma mark - 交换两个按钮的位置
- (void)adjustCenterForBtn:(HNButton *)btn withGes:(UILongPressGestureRecognizer *)ges{
    if (btn.model.isRegular) {
        return;
    }
    else{
    CGPoint newPoint = [ges locationInView:self];
    btn.center = newPoint;
    __weak typeof(self) wself = self;
    [self newLocationTagForBtn:btn locationBlock:^(HNChannelModel* targetModel) {
        if (wself.divisionModel == btn.model) {
            HNChannelModel *divisionModel = self.datas[btn.model.tag - 1];
            _divisionModel = divisionModel;
        }else if (wself.divisionModel == targetModel){
            _divisionModel = btn.model;
            
        }
        if (targetModel.tag ==0||targetModel.tag==1) {
            
        }
        else
        {
        [wself.datas removeObject:btn.model];
        [wself.datas insertObject:btn.model atIndex:targetModel.tag];
        
        for (int i = 0 ; i < wself.datas.count; i++) {
            HNChannelModel *model = wself.datas[i];
            model.tag = i;
            if (model.isMyChannel && model != btn.model) {
                model.frame = MYCHANNEL_FRAME(i);
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            for (int i = 0 ; i < wself.datas.count; i++) {
                HNChannelModel *model = wself.datas[i];
                if (model.isMyChannel && model != btn.model) {
                    [UIView animateWithDuration:0.25 animations:^{
                        model.btn.frame = model.frame;
                    }];
                }
            }

        });
        }
    }];
    }
}
- (void)newLocationTagForBtn:(HNButton *)moveBtn locationBlock:(void(^)(HNChannelModel* targetModel))locationBlock {
    HNChannelModel *moveBtnModel = moveBtn.model;
    CGPoint moveBtnCenter = moveBtn.center;
    dispatch_async(_queue, ^{
        NSMutableArray *models = [[NSMutableArray alloc]initWithArray:self.datas];
        for (HNChannelModel *model in models) {
            if (model == moveBtnModel) {
                continue;
            }
            if (!model.isMyChannel) {
                continue;
            }
            if (CGRectContainsPoint(model.frame,moveBtnCenter)) {
                locationBlock(model);
            }
        }
    });
}
- (void)resetBtnFrame:(HNButton *)btn {
    __weak typeof(self) wself = self;
    HNChannelModel *model = btn.model;
    dispatch_async(_queue, ^{
        model.frame = MYCHANNEL_FRAME(btn.model.tag);
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations:^{
                btn.frame = model.frame;
            }];
        });
    });
}

#pragma mark - scrollView的代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -50) {
        [self hide];
    }
    
}
@end

@implementation HNHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"close_sdk_login_14x14_"] forState:UIControlStateNormal];
//        UIButton.button(UIButtonTypeCustom).setShowImage([UIImage imageNamed:@"close_sdk_login_14x14_"],UIControlStateNormal);
        
        btn.frame = CGRectMake(15, 0, 40, 40);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)btnClick:(UIButton *)btn {
    if (_callBack) {
        _callBack();
    }
}
@end


