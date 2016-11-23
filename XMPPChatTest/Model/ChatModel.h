//
//  ChatModel.h
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactModel.h"
#import "ChatContentModel.h"

@interface ChatModel : NSObject

- (instancetype)initWithContact:(ContactModel *)contact;

- (ChatContentModel *)getLatestChatContent;
- (NSString *)getContactLogo;
- (NSString *)getContactName;
@end
