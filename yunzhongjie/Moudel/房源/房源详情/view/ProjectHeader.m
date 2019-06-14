//
//  ProjectHeader.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/6/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ProjectHeader.h"
#import <MapKit/MapKit.h>
#import "TagCollCell.h"



@interface ProjectHeader()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSInteger _num;
    NSInteger _nowNum;
    float _longitude;
    float _latitude;

}

@end


@implementation ProjectHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}


-(void)initUI{
    
    _imgScroll = [[UIScrollView alloc] init];//WithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
    _imgScroll.pagingEnabled = YES;
    _imgScroll.delegate = self;
    _imgScroll.showsVerticalScrollIndicator = NO;
    _imgScroll.showsHorizontalScrollIndicator = NO;
    _imgScroll.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_imgScroll];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(319 *SIZE, 164.5 *SIZE, 30 *SIZE, 30 *SIZE)];
    _numL.backgroundColor = COLOR(255, 255, 255, 0.6);
    _numL.textColor = CLTitleLabColor;
    _numL.font = [UIFont systemFontOfSize:10 *SIZE];
    _numL.textAlignment = NSTextAlignmentCenter;
    _numL.layer.cornerRadius = 15 *SIZE;
    _numL.clipsToBounds = YES;
    _numL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_numL];
    
//    _tagArr = [@[] mutableCopy];
    self.backgroundColor = [UIColor whiteColor];
//    _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 360*SIZE, 200*SIZE)];
//    _imgV.backgroundColor = [UIColor redColor];
//    [self addSubview:_imgV];
    
    _titleL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 205*SIZE, 300*SIZE, 15*SIZE)];
//    _titleL.text = @"云算公馆";
    _titleL.textColor = CLTitleLabColor;
    _titleL.font = FONT(15);
    [self addSubview:_titleL];
    
    _stateL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 205*SIZE, 340*SIZE, 15*SIZE)];
//    _stateL.text = @"云算公馆";
    _stateL.textColor = CLBlueBtnColor;
    _stateL.textAlignment = NSTextAlignmentRight;
    _stateL.font = FONT(13);
    [self addSubview:_stateL];
    _priceL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 25*SIZE, 300*SIZE, 14*SIZE)];
//    _priceL.text = @"门店名称：大禹东路二店";
    _priceL.textColor = CLTitleLabColor;
    _priceL.font = FONT(13);
    [self addSubview:_priceL];

    _addressImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(11 *SIZE, 354.5 *SIZE, 16 *SIZE, 16 *SIZE)];
    _addressImg.image = [UIImage imageNamed:@"map"];
    [self.contentView addSubview:_addressImg];
    
    _addressL = [[UILabel alloc] init];//WithFrame:CGRectMake(31 *SIZE, 155 *SIZE + CGRectGetMaxY(_imgScroll.frame), 250 *SIZE, 11 *SIZE)];
    _addressL.textColor = CLContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_addressL];
    _addressL.userInteractionEnabled = YES;
    [_addressL addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_map)]];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(65 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 235.5 *SIZE, 225 *SIZE, 50 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
//    _storeadressL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 45*SIZE, 300*SIZE, 14*SIZE)];
//    _storeadressL.text = @"门店地址：四川省成都市郫都区大禹东路96号";
//    _storeadressL.textColor = CLTitleLabColor;
//    _storeadressL.font = FONT(13);
//    [self addSubview:_storeadressL];
//
//    _peoplenumL = [[UILabel alloc]initWithFrame:CGRectMake(10*SIZE, 65*SIZE, 300*SIZE, 14*SIZE)];
//    _peoplenumL.text = @"经纪人总数：20";
//    _peoplenumL.textColor = CLTitleLabColor;
//    _peoplenumL.font = FONT(13);
//    [self addSubview:_peoplenumL];
//

    [self masonryUI];
    
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    _imgArr = [NSMutableArray arrayWithArray:imgArr];
    _num = imgArr.count;
    if (imgArr.count) {
        
        _numL.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)imgArr.count];
    }else{
        
        _numL.text = @"0/0";
    }
    [_imgScroll setContentSize:CGSizeMake(imgArr.count *SCREEN_Width, 202.5 *SIZE)];
    for (UIView *view in _imgScroll.subviews) {
        
        [view removeFromSuperview];
    }
    
    if (imgArr.count) {
        
        for (int i = 0; i < imgArr.count; i++) {
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, 202.5 *SIZE)];
            img.contentMode = UIViewContentModeScaleAspectFill;
            img.clipsToBounds = YES;
            NSString *imgname = imgArr[i][@"img_url"];
            if (imgname.length>0) {
                [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,imgArr[i][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    if (error) {
                        
                        img.image = [UIImage imageNamed:@"banner_default_2"];
                    }
                }];
                
            }
            else{
                img.image = [UIImage imageNamed:@"banner_default_2"];
                
            }
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImgBtn)];
            [img addGestureRecognizer:tap];
            img.userInteractionEnabled = YES;
            [_imgScroll addSubview:img];
        }
    }else{
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        img.image = [UIImage imageNamed:@"banner_default_2"];
        [_imgScroll addSubview:img];
    }
}

- (void)ActionImgBtn{
    
    if (self.imgBtnBlock) {
        
        if (_imgArr.count) {
            
            self.imgBtnBlock(_nowNum, _imgArr);
            
        }
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _nowNum = scrollView.contentOffset.x / SCREEN_Width;
    _numL.text = [NSString stringWithFormat:@"%.0f/%ld",(scrollView.contentOffset.x / SCREEN_Width) + 1, (long)_num];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (_propertyArr.count){
        return 1;
    }else {
        return 0;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _propertyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 65 *SIZE, 17 *SIZE)];
    }
    
 
        if (_propertyArr.count) {
            
            [cell setStyleByType:@"0" lab:_propertyArr[indexPath.item]];

            
    }
    
    return cell;
}

- (void)masonryUI{
    
    [_imgScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(202.5 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(_imgScroll.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
    }];
    
    [_stateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(290 *SIZE);
        make.top.equalTo(_imgScroll.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(60 *SIZE);
    }];
    
//    [_attentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(326 *SIZE);
//        make.top.equalTo(_imgScroll.mas_bottom).offset(28 *SIZE);
//        make.width.height.mas_equalTo(29 *SIZE);
//    }];
//
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(9 *SIZE);
        make.width.equalTo(@(225 *SIZE));
        //        make.height.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
//    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(230 *SIZE);
//        make.top.equalTo(_imgScroll.mas_bottom).offset(35 *SIZE);
//        make.width.mas_equalTo(87 *SIZE);
//    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_propertyColl.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
//    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(10 *SIZE);
//        make.top.equalTo(_payL.mas_bottom).offset(9 *SIZE);
//        make.width.mas_equalTo(280 *SIZE);
//    }];
    
    [_addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(7.5 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(31 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = CLBackColor;
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(_addressL.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(360 *SIZE);
    }];
    
}


-(void)action_map
{    
    _latitude = [_lat floatValue];
    _longitude = [_lon floatValue];
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(_latitude, _longitude);
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    toLocation.name = _addressL.text;
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

@end
