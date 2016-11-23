//
//  ChatContentModel.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "ChatContentModel.h"

@implementation ChatContentModel
- (instancetype)initWithSender:(ContactModel *)sender Reciver:(ContactModel *)reciver Msg:(NSString *)msg Time:(NSString *)time {
    if (self = [super init]) {
        self.sender = sender;
        self.reciver = reciver;
        self.msg = msg;
        self.time = time;
    }
    
    return self;
}

- (void)sendMsgSuccess:(void (^)(void))success Fail:(void (^)(NSString *, NSError *))fail {
    success();
}

- (void)deleteMsg {
    
}
@end
