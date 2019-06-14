//
//  HNChannelView.h
//  headlineNews
//
//  Created by dengweihao on 2017/11/21.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^hideBlook)(void);
typedef void (^ClickBlook)(int selctnum);
@interface HNChannelView : UIScrollView
@property (nonatomic , copy) hideBlook hideblook;
@property (nonatomic , copy) ClickBlook clickblook;

- (void)show;
- (void)hide;
@end
