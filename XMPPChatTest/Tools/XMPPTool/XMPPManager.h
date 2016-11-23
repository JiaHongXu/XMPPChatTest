//
//  XMPPManager.h
//  XMPPChatTest
//
//  Created by 307A on 2016/11/23.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPP.h"

typedef void(^LoginHandlerBlock)(NSString *msg, NSError *error);
typedef void(^RegisterHandlerBlock)(NSString *msg, NSError *error);

@interface XMPPManager : NSObject
@property (nonatomic, copy) LoginHandlerBlock loginHandler;
@property (nonatomic, copy) RegisterHandlerBlock registerHandler;

+ (XMPPManager *)defaultManager;
- (void)loginWithUser:(NSString *)username Password:(NSString *)password CompleteHandler:(LoginHandlerBlock)loginHander;
- (void)sendOnlineMessage;
- (void)sendOfflineMessage;
@end
