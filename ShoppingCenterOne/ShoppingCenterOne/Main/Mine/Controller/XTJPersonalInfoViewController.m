//
//  XTJPersonalInfoViewController.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/14.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "XTJPersonalInfoViewController.h"
#import "XTJPersonalInfoCell.h"
#import "XTJPersonalInfoMdoel.h"
#import "XTJPersonalInfoEditViewController.h"

@interface XTJPersonalInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation XTJPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}

- (void)setupUI {
    
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource  = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark -------------------------- UITableViewDelegate ----------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return self.orderModelArray.count;
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    XTJPersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        //        cell = [[XTJMyOrderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XTJPersonalInfoCell" owner:nil options:nil] lastObject];
//        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.personalInfoMdoel = self.dataSource[indexPath.row];
//    cell.orderModer = self.orderModelArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTJPersonalInfoMdoel *infoModel = self.dataSource[indexPath.row];
    infoModel.actionBlock(nil);
}
#pragma mark -------------------------- UIImagePickerControllerDelegate ----------------------------------------
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    if (image) {

        NSData *data = UIImageJPEGRepresentation(image, 0.5);

        NSDictionary *parameters = @{ @"user_id":[UsersManager sharedUsersManager].currentUser.user_id};

        [[TJNetworking manager]uploadTaskWithMultiPartApiKey:kUploadPortraitURL name:@"file" data:data fileName:@"file.png" mimeType:@"image/png" parameters: parameters progress:nil success:^(TJNetworkingSuccessResponse * _Nonnull response) {
            if ([response.responseObject[@"code"] isEqualToString:@"0"]) {
                [UsersManager sharedUsersManager].currentUser.profile_pic = response.responseObject[@"retData"];
                [[UsersManager sharedUsersManager] save];
                _dataSource = nil;
                [self.tableView reloadData];
                }
        } failed:^(TJNetworkingFailureResponse * _Nonnull response) {
            
        } finished:^{

        }];

    }
    
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
    
    
    
}
#pragma mark -------------------------- lazy load ----------------------------------------
- (NSArray *)dataSource {
    if (!_dataSource) {
        
        _dataSource = @[
                        [[XTJPersonalInfoMdoel alloc]initWithTitle:@"用户头像" content:nil rightImageViewName:[UsersManager sharedUsersManager].currentUser.profile_pic actionBlock:^(id cell) {
                            
                            [self editPortrait];
                        }],
                        [[XTJPersonalInfoMdoel alloc]initWithTitle:@"用户名" content:[UsersManager sharedUsersManager].currentUser.name rightImageViewName:nil actionBlock:^(id cell) {
                            
                            XTJPersonalInfoEditViewController *infoEditVC = [[XTJPersonalInfoEditViewController alloc]initWithEditName];
                            [self.navigationController pushViewController:infoEditVC animated:YES];
                        }],
                        [[XTJPersonalInfoMdoel alloc]initWithTitle:@"电话" content:[UsersManager sharedUsersManager].currentUser.phone_num rightImageViewName:nil actionBlock:^(id cell) {
                            
                            XTJPersonalInfoEditViewController *infoEditVC = [[XTJPersonalInfoEditViewController alloc]initWithEditPhone];
                            [self.navigationController pushViewController:infoEditVC animated:YES];
                        }],
                        [[XTJPersonalInfoMdoel alloc]initWithTitle:@"性别" content:[UsersManager sharedUsersManager].currentUser.sex rightImageViewName:nil actionBlock:^(id cell) {
                            
                            [self editSex];
                        }]
                       
                    ];
    }
    return _dataSource;
}

- (void)editSex {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"性别" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UsersManager sharedUsersManager].currentUser.sex = @"男";
        [[UsersManager sharedUsersManager] save];
        _dataSource = nil;
        [self.tableView reloadData];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UsersManager sharedUsersManager].currentUser.sex = @"女";
        [[UsersManager sharedUsersManager] save];
        _dataSource = nil;
        [self.tableView reloadData];
        
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)editPortrait{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil  message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController
                           animated:YES completion:nil];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController
                           animated:YES completion:nil];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
     [self presentViewController:alert animated:YES completion:nil];
    
}
@end
