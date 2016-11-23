//
//  MeSingleton.h
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "ContactModel.h"

@interface MeSingleton : ContactModel
+ (MeSingleton *)sharedMe;
+ (void)initMeWithID:(NSString *)ID Name:(NSString *)name Logo:(NSString *)logo;
@end
