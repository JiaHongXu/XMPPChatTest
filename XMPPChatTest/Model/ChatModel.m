//
//  ChatModel.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "ChatModel.h"
@interface ChatModel()

@property (nonatomic, strong) ContactModel *contact;

@end
@implementation ChatModel

- (instancetype)initWithContact:(ContactModel *)contact {
    if (self = [super init]) {
        self.contact = contact;
    }
    
    return self;
}

- (ChatContentModel *)getLatestChatContent {
    return [[ChatContentModel alloc] initWithSender:nil Reciver:nil Msg:@"哈哈哈哈" Time:@"2016-10-26 20:36"];;
}

- (NSString *)getContactLogo {
    return self.contact.logo;
}

- (NSString *)getContactName {
    return self.contact.name;
}

@end
