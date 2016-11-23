//
//  ChatTableViewCell.h
//  XMPPChatTest
//
//  Created by 307A on 2016/11/15.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"

@interface ChatTableViewCell : UITableViewCell
- (void)updateWithChat:(ChatModel *)chat;
@end
