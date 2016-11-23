//
//  ChatListViewController.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/5.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//
//  聊天列表
#import "ChatListViewController.h"

#import "ChatDetailViewController.h"
#import "ChatTableViewCell.h"

#import "ChatModel.h"

@interface ChatListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *chatListTable;
@property (nonatomic, strong) NSMutableArray *chatListArray;

@end

static NSString * const cellId = @"ChatListCellID";

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

- (void)initData {
    self.chatListArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 30; i++) {
        [self.chatListArray addObject:[[ChatModel alloc] initWithContact:[[ContactModel alloc] initWithID:@"ididid" Name:[NSString stringWithFormat:@"用户%d", i] Logo:@"senderLogo"]]];
    }
    
    self.chatListTable = [[UITableView alloc] init];
    self.chatListTable.delegate = self;
    self.chatListTable.dataSource = self;
}

- (void)initUI {
    WS(ws);
    [self.view addSubview:self.chatListTable];
    [self.chatListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}

#pragma mark - TableView Delegate -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    ChatModel *chat = [self.chatListArray objectAtIndex:indexPath.row];
    
    [cell updateWithChat:chat];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatDetailViewController *chatDetailVC = [[ChatDetailViewController alloc] init];
    chatDetailVC.chatModel = [self.chatListArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:chatDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
