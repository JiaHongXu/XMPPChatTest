//
//  ChatDetailViewController.h
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//
//  聊天界面

#import "BaseViewController.h"
#import "ChatModel.h"

@interface ChatDetailViewController : BaseViewController
@property (nonatomic, strong) ChatModel *chatModel;
@end
