//
//  ChatDetailTableViewCell.h
//  XMPPChatTest
//
//  Created by 307A on 2016/11/15.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatContentModel.h"

@interface ChatDetailTableViewCell : UITableViewCell
- (void)updateWithChatContent:(ChatContentModel *)chatContent;
@end
