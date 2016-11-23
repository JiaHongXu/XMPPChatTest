//
//  ContactModel.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel
- (instancetype)initWithID:(NSString *)ID Name:(NSString *)name Logo:(NSString *)logo{
    if (self = [super init]) {
        self.ID = ID;
        self.name = name;
        self.logo = logo;
    }
    
    return self;
}
@end
