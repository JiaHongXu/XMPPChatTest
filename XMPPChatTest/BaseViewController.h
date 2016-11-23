//
//  ViewController.h
//  mquanr
//
//  Created by Vincent on 16/3/7.
//  Copyright © 2016年 MeiQiNuo. All rights reserved.
//
//  所有VC的父类，包含了一些常用的方法和textField的代理（键盘事件）
//
// 

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

//获取屏幕大小
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height

#define WS(weakself) __weak __typeof(&*self)weakself = self;
@interface BaseViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
//显示提示信息
-(void)showAlertMsg:(NSString *)msg;//注意，对于present上去的view，在disMiss的时候不能使用，否则会崩溃
-(void)showAlertMsgNeedsResponse:(NSString *)msg;

//显示等待动画框
- (void)startWaitingIndicator;
//停止等待动画框
- (void)stopWaitingIndicator;
//tableview隐藏行线
-(void)setExtraCellLineHidden: (UITableView *)tableView;
//需要更新字号UI的时候调用
-(BOOL)needUpdateFont;

@property(nonatomic)UITapGestureRecognizer *tapGestureRecognizer;
@end

