//
//  UserManager.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/23.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "UserManager.h"
@interface UserManager()
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@end
static UserManager *defaultManager;
@implementation UserManager
+ (UserManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        defaultManager = [[UserManager alloc] init];
    });
    return defaultManager;
}
@end
