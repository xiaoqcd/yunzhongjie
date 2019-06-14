//
//  MineVC.m
//  yunzhongjie
//
//  Created by xiaoq on 2019/5/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MineVC.h"
#import "PersonalVC.h"
#import "FeedbackVC.h"
#import "ChangePassWordVC.h"
#import "PushSettingVC.h"
#import "MineHeader.h"
#import "MineCell.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray *_imgArr;
    NSArray *_titleArr;
    UIImagePickerController *_imagePickerController; /**< 相册拾取器 */
}

@property (nonatomic, strong) UITableView *table;


@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
//    if (![UserInfoModel defaultModel].account.length) {
//
//        [self RequestMethod];
//    }
}

- (void)RequestMethod{
    
//    [BaseRequest GET:UserPersonalGetAgentInfo_URL parameters:nil success:^(id resposeObject) {
//
//        if ([resposeObject[@"code"] integerValue] == 200) {
//
//            if ([resposeObject[@"data"] isKindOfClass:[NSDictionary class]]) {
//
//                [self SetData:resposeObject[@"data"]];
//            }else{
//
//                [self showContent:resposeObject[@"msg"]];
//            }
//        }else{
//
//            [self showContent:resposeObject[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//
//        [self showContent:@"网络错误"];
//    }];
}

- (void)SetData:(NSDictionary *)data{
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:data];
    [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSNull class]]) {
            
            [tempDic setObject:@"" forKey:key];
        }
    }];
    [UserInfoModel defaultModel].absolute_address = tempDic[@"absolute_address"];
    [UserInfoModel defaultModel].account = tempDic[@"account"];
    [UserInfoModel defaultModel].birth = tempDic[@"birth"];
    [UserInfoModel defaultModel].city = tempDic[@"city"];
    [UserInfoModel defaultModel].district = tempDic[@"district"];
    [UserInfoModel defaultModel].head_img = tempDic[@"head_img"];
    [UserInfoModel defaultModel].name = tempDic[@"name"];
    [UserInfoModel defaultModel].province = tempDic[@"province"];
    [UserInfoModel defaultModel].sex = [NSString stringWithFormat:@"%@",tempDic[@"sex"]];
    [UserInfoModel defaultModel].tel = tempDic[@"tel"];
//    [UserInfoModel defaultModel].slef_desc = tempDic[@"self_desc"];
    [UserModelArchiver infoArchive];
    [_table reloadData];
}

- (void)initDataSource{
    
    _imgArr = @[@[@"Modifythe",@"Modifythe",@"work",@"Setupthe",@"version",@"about"]];
    _titleArr = @[@[@"个人资料",@"修改密码",@"意见反馈",@"推送设置",@"版本信息",@"安全退出"]];
}

#pragma mark -- 选择头像

- (void)selectPhotoAlbumPhotos {
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        // 1、设置图片拾取器上的sourceType
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 2、设置支持的媒体格式
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        // 3、其他设置
        _imagePickerController.allowsEditing = YES; // 如果设置为NO，当用户选择了图片之后不会进入图像编辑界面。
        // 4、推送图片拾取器控制器
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

// 拍照
- (void)takingPictures {
    // 获取支持的媒体格式
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 1、设置图片拾取器上的sourceType
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 2、设置支持的媒体格式
        _imagePickerController.mediaTypes = @[mediaTypes[0]];
        // 3、其他设置
        // 设置相机模式
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        // 设置摄像头：前置/后置
        _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        // 设置闪光模式
        _imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        
        
        // 4、推送图片拾取器控制器
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    } else {
        //        NSLog(@"当前设备不支持拍照");
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                  message:@"当前设备不支持拍照"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //                                                              _uploadButton.hidden = NO;
                                                          }]];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"%@",info);
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if ([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
            UIImage *originalImage = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
            [self updateheadimgbyimg:originalImage];
        }
    }else if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        UIImage *originalImage = [self fixOrientation:info[UIImagePickerControllerEditedImage]];
        [self updateheadimgbyimg:originalImage];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateheadimgbyimg:(UIImage *)img
{
    NSData *data = [self resetSizeOfImageData:img maxSize:150];
    
        [BaseRequest UpdateFile:^(id<AFMultipartFormData>  _Nonnull formData) {
    
            [formData appendPartWithFileData:data name:@"headimg" fileName:@"headimg.jpg" mimeType:@"image/jpg"];
        } url:UploadFile_URL parameters:@{
                                          @"file_name":@"headimg"
                                          } success:^(id  _Nonnull resposeObject) {
    
            if ([resposeObject[@"code"] integerValue] == 200) {
    
                NSDictionary *dic = @{@"head_img":resposeObject[@"data"]};
                [BaseRequest POST:FixPersonInfo_URL parameters:dic success:^(id resposeObject) {
    
                    if ([resposeObject[@"code"] integerValue] == 200) {
    
                        [UserInfoModel defaultModel].head_img = dic[@"head_img"];
                        [UserModelArchiver infoArchive];
                        [self->_table reloadData];
                    }else{
    
                        [self showContent:resposeObject[@"msg"]];
                    }
                } failure:^(NSError *error) {
    
                    //                NSLog(@"%@",error);
                    [self showContent:@"网络错误"];
                }];
            }else{
    
                [self showContent:resposeObject[@"msg"]];
            }
                                          } failure:^(NSError * _Nonnull error) {
    
                                              [self showContent:@"网络错误"];
                                          }];
}

// 用户点击了取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return UITableViewAutomaticDimension;
    }else{
        
        return 5 *SIZE;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        MineHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MineHeader"];
        if (!header) {
            
            header = [[MineHeader alloc] initWithReuseIdentifier:@"MineHeader"];
        }
        
        header.nameL.text = [UserModelArchiver unarchive].name;
        header.codeL.text = [UserModelArchiver unarchive].tel;
//        header.dataDic = [[UserInfoModel defaultModel] modeltodic];
        [header.headerImg sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",TestBase_Net,[UserModelArchiver unarchive].head_img] ]completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    
            if (error) {
                header.headerImg.image = [UIImage imageNamed:@"def_head"];
            }
        }];
    
        
        header.mineHeaderImgBlock = ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传头像"
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self selectPhotoAlbumPhotos];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self takingPictures];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }]];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
           
        };
        
        return header;
    }else{
        
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if (!cell) {
        
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = _titleArr[indexPath.section][indexPath.row];
    cell.titleImg.image = IMAGE_WITH_NAME(_imgArr[indexPath.section][indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            PersonalVC *nextVC = [[PersonalVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
       
        
        else if (indexPath.row == 1) {
            
            ChangePassWordVC *nextVC = [[ChangePassWordVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
           
        }else if (indexPath.row == 2){
            FeedbackVC *nextVC = [[FeedbackVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];

            
        }else if (indexPath.row == 3) {
            
            PushSettingVC *nextVC = [[PushSettingVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
        }
        else if (indexPath.row == 3){
            

            
        }else if (indexPath.row == 5){
            
            [self alertControllerWithNsstring:@"退出" And:@"你确认要退出登录吗？" WithCancelBlack:^{
                
            } WithDefaultBlack:^{
                
                [BaseRequest GET:LoginOut_URL parameters:nil success:^(id  _Nonnull resposeObject) {
//
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
//                    [UserModelArchiver ClearModel];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"goLoginVC" object:nil];
                } failure:^(NSError * _Nonnull error) {

                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LOGINENTIFIER];
//                    [UserModelArchiver ClearModel];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"goLoginVC" object:nil];
                }];
            }];
        }
    }
    
}

- (void)initUI{
    
    self.line.hidden = YES;
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.bounces = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 100 *SIZE;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    if (@available(iOS 11.0,*)) {
        
        _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
