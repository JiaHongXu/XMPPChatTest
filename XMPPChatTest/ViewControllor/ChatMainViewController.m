//
//  ChatMainViewController.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/5.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//
//  聊天主页面

#import "ChatMainViewController.h"

#import "RosterListViewController.h"
#import "ChatListViewController.h"
#import "MeSingleton.h"

@interface ChatMainViewController ()

@property (nonatomic, strong) RosterListViewController *roasterListVC;
@property (nonatomic, strong) ChatListViewController *chatListVC;

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@property (nonatomic, strong) MeSingleton *me;
@end

@implementation ChatMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

- (void)initUI {
    WS(ws);
    
    [self.roasterListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [self.chatListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [self.navigationItem.titleView layoutIfNeeded];
}

- (void)initData {
    self.me = [MeSingleton sharedMe];
    
    self.roasterListVC = [[RosterListViewController alloc] init];
    self.roasterListVC.view.backgroundColor = [UIColor blueColor];
    
    self.chatListVC = [[ChatListViewController alloc] init];
    self.chatListVC.view.backgroundColor = [UIColor greenColor];
    
    [self addChildViewController:self.roasterListVC];
    [self addChildViewController:self.chatListVC];
    
    [self.view insertSubview:self.chatListVC.view atIndex:0];
    [self.view insertSubview:self.roasterListVC.view belowSubview:self.chatListVC.view];

    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"聊天", @"联系人"]];
    [self.segmentControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self.segmentControl setSelectedSegmentIndex:0];
    self.navigationItem.titleView = self.segmentControl;
}

- (void)didClicksegmentedControlAction:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.view bringSubviewToFront:self.chatListVC.view];
            break;
        case 1:
            [self.view bringSubviewToFront:self.roasterListVC.view];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
