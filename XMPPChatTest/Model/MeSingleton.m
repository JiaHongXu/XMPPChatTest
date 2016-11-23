//
//  MeSingleton.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "MeSingleton.h"

@implementation MeSingleton
static MeSingleton *meSingleton;
+ (void)initMeWithID:(NSString *)ID Name:(NSString *)name Logo:(NSString *)logo{
    meSingleton = [[MeSingleton alloc] initWithID:ID Name:name Logo:logo];
}

+ (MeSingleton *)sharedMe {
    if (meSingleton) {
        return meSingleton;
    }else {
        @throw [NSException exceptionWithName:@"请先初始化该单例"
                                       reason:@"应该这样调用 [MeSingleton initWithID:(NSString *)ID Name:(NSString *)name]"
                                     userInfo:nil];
        return nil;

    }
}

- (instancetype)initWithID:(NSString *)ID Name:(NSString *)name Logo:(NSString *)logo {
    if(self = [super initWithID:ID Name:name Logo:logo]){
        
    }
    return self;
}
@end
