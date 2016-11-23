//
//  ContactModel.h
//  XMPPChatTest
//
//  Created by 307A on 2016/11/14.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *logo;

- (instancetype)initWithID:(NSString *)ID Name:(NSString *)name Logo:(NSString *)logo;
@end
