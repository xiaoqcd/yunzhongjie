//
//  StoreMannerCell.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreMannerCell.h"

@implementation StoreMannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _nameL.text = @"小煤球";
   
    _phoneL.text = @"1801010313";

}

- (void)ActionPhone{
    
//    if (self.addressBookCellPhoneBlock) {
//
//        self.addressBookCellPhoneBlock();
//    }
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10*SIZE, 15*SIZE, 43*SIZE, 43*SIZE)];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    _headImg.layer.cornerRadius = 21.5 *SIZE;
    _headImg.backgroundColor = CLBackColor;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(68*SIZE, 19*SIZE, 200*SIZE, 13*SIZE)];
    _nameL.textColor = CLTitleLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_nameL];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(68*SIZE, 39*SIZE, 200*SIZE, 13*SIZE)];
    _phoneL.textColor = CLTitleLabColor;
    _phoneL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_phoneL];

    
    _phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(330*SIZE, 19*SIZE, 20*SIZE, 20*SIZE)];
    _phoneImg.image = IMAGE_WITH_NAME(@"phone");
    _phoneImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionPhone)];
    [_phoneImg addGestureRecognizer:tap];
    [self.contentView addSubview:_phoneImg];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 63*SIZE, 360*SIZE, 1*SIZE)];
    _line.backgroundColor = CLBackColor;
    [self.contentView addSubview:_line];
    
    _nameL.text = @"小煤球";
    
    _phoneL.text = @"1801010313";
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
//    [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(self.contentView).offset(15 *SIZE);
//        make.height.width.mas_equalTo(43 *SIZE);
//    }];
//
//    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(68 *SIZE);
//        make.top.equalTo(self.contentView).offset(19 *SIZE);
//        make.width.mas_equalTo(self->_nameL.mj_textWith + 5 *SIZE);
//    }];
//
//    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(68 *SIZE);
//        make.top.equalTo(self->_nameL.mas_bottom).offset(10 *SIZE);
//        make.width.mas_equalTo(120 *SIZE);
//    }];
    
//    [_phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.contentView).offset(-10 *SIZE);
//        make.top.equalTo(self.contentView).offset(18 *SIZE);
//        make.height.width.mas_equalTo(16 *SIZE);
//    }];
    
 

    
//    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(0 *SIZE);
//        make.top.equalTo(self->_headImg.mas_bottom).offset(15 *SIZE);
//        make.height.mas_equalTo(1 *SIZE);
//        make.width.mas_equalTo(360 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-0 *SIZE);
//    }];
}
@end
