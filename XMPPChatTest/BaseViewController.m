//
//  ViewController.m
//  mquanr
//
//  Created by Vincent on 16/3/7.
//  Copyright © 2016年 MeiQiNuo. All rights reserved.
// 

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <Masonry/Masonry.h>
@interface BaseViewController ()

@property (nonatomic) MBProgressHUD *waitingHud;
@property (nonatomic) UIView *waitingView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    _tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:_tapGestureRecognizer];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
//    for (UIView *view in [self.view subviews]) {
//        [view resignFirstResponder];
//    }
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self needUpdateFont];
}

-(void)showAlertMsg:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
        MBProgressHUD *alertHud = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        alertHud.mode = MBProgressHUDModeText;
        alertHud.labelText = msg;
        [alertHud hide:YES afterDelay:1];
    });
    
}

-(void)showAlertMsgNeedsResponse:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    });
}

- (void)startWaitingIndicator
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更UI
        if(!_waitingView)
        {
            _waitingView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
            _waitingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            [self.view addSubview:_waitingView];
            _waitingView.hidden = YES;
        }
        _waitingView.hidden = NO;

        _waitingHud = [MBProgressHUD showHUDAddedTo:_waitingView animated:YES];
    });

}

- (void)stopWaitingIndicator
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更UI
        [_waitingHud hide:YES];
        [_waitingView setHidden:YES];
    });
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(BOOL)needUpdateFont{
    return YES;
}

@end
