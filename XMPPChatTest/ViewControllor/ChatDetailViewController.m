//
//  ChatDetailViewController.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//
//  聊天界面

#import "ChatDetailViewController.h"
#import "ChatDetailTableViewCell.h"
#import "ChatContentModel.h"
#import "MeSingleton.h"
#import "JHTextView.h"

@interface ChatDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UIView *bottomBarView;
@property (nonatomic, strong) UIView *bottomToolView;
@property (nonatomic, strong) UITableView *chatTableView;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) JHTextView *inputTv;
@property (nonatomic, strong) NSMutableArray *chatArray;
@property (nonatomic, strong) MeSingleton *me;

@property (nonatomic, assign) float bottomBarOffset;                //底部距离屏幕底部距离
@property (nonatomic, assign) float bottomBarHeight;                //底部输入框高度
@property (nonatomic, assign) float bottomToolViewHeight;           //底部工具栏高度
@property (nonatomic, assign) float inputViewHeight;                //输入框高度
@property (nonatomic, assign) float defaultSpace;                   //默认间距
@property (nonatomic, assign) float moreBtnSize;                    //加号按钮尺寸


@end

static NSString * const cellId = @"ChatDetailCellID";

static const float INPUTVIEW_ORIGINAL_HEIGHT = 36.;
static const float BOTTOMBAR_ORIGINAL_HEIGHT = 44.;
static const float BOTTOMTOOLVIEW_HEIGHT = 250.;
static const float MORE_BTN_SIZE = 30;

@implementation ChatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [self registerForKeyboardChanges];
}

#pragma mark - Init Methods
- (void)initData {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.bottomBarOffset = 0;
    
    self.bottomBarHeight = BOTTOMBAR_ORIGINAL_HEIGHT;
    self.inputViewHeight = INPUTVIEW_ORIGINAL_HEIGHT;
    self.moreBtnSize = MORE_BTN_SIZE;
    self.defaultSpace = 5;
    self.bottomToolViewHeight = BOTTOMTOOLVIEW_HEIGHT;
    
    self.me = [MeSingleton sharedMe];
    
    self.bottomBarView = [[UIView alloc] init];
    [self.view addSubview:self.bottomBarView];
    
    self.bottomToolView = [[UIView alloc] init];
    [self.view addSubview:self.bottomToolView];
    
    self.inputTv = [[JHTextView alloc] init];
    [self.bottomBarView addSubview:self.inputTv];
    
    self.moreBtn = [[UIButton alloc] init];
    [self.bottomBarView addSubview:self.moreBtn];
    
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    [self.view addSubview:self.chatTableView];
    
    self.chatArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 15; i++) {
        [self.chatArray addObject:[[ChatContentModel alloc] initWithSender:[[ContactModel alloc] initWithID:@"20140097" Name:@"大屁鑫" Logo:@"senderLogo"] Reciver:self.me Msg:@"哈哈哈哈是啊是啊" Time:@""]];
        [self.chatArray addObject:[[ChatContentModel alloc] initWithSender:self.me Reciver:[[ContactModel alloc] initWithID:@"20140097" Name:@"大屁鑫" Logo:@"senderLogo"] Msg:@"不不不不呵呵哈哈哈" Time:@""]];
    }
}

- (void)initUI {
    WS(ws);
    [self.navigationItem setTitle:[self.chatModel getContactName]];
    
    [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view.mas_bottom).with.offset(ws.bottomBarOffset);
    }];
    [self.bottomBarView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    [self.bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(ws.view);
        make.top.equalTo(ws.bottomBarView.mas_bottom);
        make.height.mas_equalTo(ws.bottomToolViewHeight);
    }];
    [self.bottomToolView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    [self.inputTv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bottomBarView).with.offset(ws.defaultSpace);
        make.right.equalTo(ws.bottomBarView).with.offset(-2*ws.defaultSpace - ws.moreBtnSize);
        make.bottom.equalTo(ws.bottomBarView.mas_bottom).with.offset(-ws.defaultSpace);
        make.height.mas_equalTo(@36);
    }];
    [self.inputTv sizeDidChange:^(CGSize size) {
        ws.bottomBarHeight = size.height + 2*ws.defaultSpace;
        [ws.inputTv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height);
        }];
        [ws.chatTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.view.mas_bottom).with.offset(-ws.bottomBarOffset - ws.bottomBarHeight);
        }];
        [UIView animateWithDuration:0.2 animations:^{
            [ws.view layoutIfNeeded];
        }];
    }];
    [self.inputTv setFont:[UIFont systemFontOfSize:16]];
    self.inputTv.layer.cornerRadius = 5;
    self.inputTv.maxHeight = 100;
    self.inputTv.backgroundColor = [UIColor greenColor];
    self.inputTv.layer.masksToBounds = YES;
    self.inputTv.returnKeyType = UIReturnKeySend;
    self.inputTv.enablesReturnKeyAutomatically = YES;
    self.inputTv.delegate = self;
    
    [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.inputTv.mas_top).with.offset(-ws.defaultSpace);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.equalTo(ws.bottomBarView).with.offset(-ws.defaultSpace);
        make.height.and.width.mas_equalTo(ws.moreBtnSize);
    }];
    self.moreBtn.backgroundColor = [UIColor blueColor];
    self.moreBtn.layer.masksToBounds = YES;
    self.moreBtn.layer.cornerRadius = self.moreBtnSize/2;
    
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(ws.view);
        make.height.mas_equalTo(SCREEN_HEIGHT - 64 - ws.bottomBarHeight - ws.bottomBarOffset);
        make.bottom.equalTo(ws.view.mas_bottom).with.offset(-ws.bottomBarOffset - ws.bottomBarHeight);
    }];
    
    [self.chatTableView setSeparatorColor:[UIColor clearColor]];
    [self scrollToBottomAnimated:NO];
    
    [self.view layoutIfNeeded];
    [self.inputTv updateFrame];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.chatArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

#pragma mark - TableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[ChatDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ChatContentModel *chat = [self.chatArray objectAtIndex:indexPath.row];
    [cell updateWithChatContent:chat];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

//估算的cell高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - ToolView Notification
- (void)toolViewWillChange:(NSNotification*)notification {
    
}

#pragma mark - Keyboard Notification
- (void)keyboardWillChange:(NSNotification*)notification {
    // 工具条平移的距离 == 屏幕高度 - 键盘最终的Y值
    self.bottomBarOffset = SCREEN_HEIGHT - [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    WS(ws);
    [ws.bottomBarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view.mas_bottom).with.offset(-ws.bottomBarOffset);
    }];
    [ws.chatTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view.mas_bottom).with.offset(-ws.bottomBarOffset - ws.bottomBarHeight);
        make.height.mas_equalTo(SCREEN_HEIGHT - 64 - ws.bottomBarHeight - ws.bottomBarOffset);
    }];
    [ws.bottomToolView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.bottomBarView.mas_bottom);
    }];
    
    [UIView animateWithDuration:duration animations:^{
        [ws.view layoutIfNeeded];
        [ws scrollToBottomAnimated:NO];
    }];
}

- (void)registerForKeyboardChanges {
    //获取通知中心
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //注册为被通知者
    //获取键盘出来的通知
    [notificationCenter addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)unregisterForKeyboardChanges {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - TextView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        //Send Msg
        [self.chatArray addObject:[[ChatContentModel alloc] initWithSender:self.me Reciver:[[ContactModel alloc] initWithID:@"20140097" Name:@"李钰鑫" Logo:@"senderLogo"] Msg:textView.text Time:@""]];
        textView.text = @"";
        [((JHTextView *)textView) updateFrame];
        [self.chatTableView beginUpdates];
        [self.chatTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.chatArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        [self.chatTableView endUpdates];
        [self scrollToBottomAnimated:YES];
        return NO;
    }else {
        return YES;
    }
}

- (void)dealloc {
    [self unregisterForKeyboardChanges];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
