//
//  LoginViewController.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/23.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "LoginViewController.h"
#import "ChatMainViewController.h"
#import "XMPPManager.h"

#import "MeSingleton.h"

@interface LoginViewController ()
@property (nonatomic, strong) UITextField *userNameTf;
@property (nonatomic, strong) UITextField *userPwdTf;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

#pragma mark - Init Methods

- (void)initData {
    self.userNameTf = [[UITextField alloc] init];
    self.userNameTf.placeholder = @"用户名";
    self.userPwdTf = [[UITextField alloc] init];
    self.userPwdTf.placeholder = @"密码";
    self.loginBtn = [[UIButton alloc] init];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.userNameTf];
    [self.view addSubview:self.userPwdTf];
    [self.view addSubview:self.loginBtn];
}

- (void)initUI {
    WS(ws);
    float width = 300;
    float height = 44;
    float defaultSpace = 10;
    [self.userNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
    }];
    [self.userNameTf setBorderStyle:UITextBorderStyleRoundedRect];
    
    [self.userPwdTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.userNameTf.mas_bottom).with.offset(defaultSpace);
        make.height.and.width.equalTo(ws.userNameTf);
        make.centerX.equalTo(ws.userNameTf);
    }];
    [self.userPwdTf setBorderStyle:UITextBorderStyleRoundedRect];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.userPwdTf.mas_bottom).with.offset(defaultSpace);
        make.height.and.width.equalTo(ws.userNameTf);
        make.centerX.equalTo(ws.userNameTf);
    }];
    self.loginBtn.backgroundColor = [UIColor greenColor];
    self.loginBtn.layer.cornerRadius = 5;
}

#pragma mark - Login Methods
- (void)login {
    [self startWaitingIndicator];
    [self doLoginSuccess:^{
        [self showAlertMsg:@"登录成功"];
        [self stopWaitingIndicator];
        
        [MeSingleton initMeWithID:@"20144786" Name:@"臭屁宏" Logo:@"reciverLogo"];
        [[XMPPManager defaultManager] sendOnlineMessage];
        ChatMainViewController *chatMainVC = [[ChatMainViewController alloc] init];
        [self.navigationController pushViewController:chatMainVC animated:YES];
    } Failure:^(NSString *msg, NSError *error) {
        [self showAlertMsg:msg];
        [self stopWaitingIndicator];
    }];
}

- (void)doLoginSuccess:(void(^)(void))success Failure:(void(^)(NSString *msg, NSError *error))failure {
    XMPPManager *xmppManager = [XMPPManager defaultManager];
    [xmppManager loginWithUser:self.userNameTf.text Password:self.userPwdTf.text CompleteHandler:^(NSString *msg, NSError *error) {
        if (!error) {
            success();
        }else {
            failure(msg, error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
