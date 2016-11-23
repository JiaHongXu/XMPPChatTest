//
//  ChatContentModel.h
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactModel.h"

@interface ChatContentModel : NSObject
@property (nonatomic, strong) ContactModel *sender;
@property (nonatomic, strong) ContactModel *reciver;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *time;

- (instancetype)initWithSender:(ContactModel *)sender Reciver:(ContactModel *)reciver Msg:(NSString *)msg Time:(NSString *)time;

- (void)sendMsgSuccess:(void(^)(void))success Fail:(void(^)(NSString *msg, NSError *error))fail;
- (void)deleteMsg;
@end
