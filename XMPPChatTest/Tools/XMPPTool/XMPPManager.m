//
//  XMPPTool.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/23.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "XMPPManager.h"
@interface XMPPManager()<XMPPStreamDelegate>
@property (nonatomic, strong) XMPPStream *stream;
@property (nonatomic, strong) NSString *tempPwd;
@end

static XMPPManager *defaultManager;
static NSString * const kHostName = @"121.42.29.124";
static UInt16 const kHostPort = 5222;

@implementation XMPPManager
+ (XMPPManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        defaultManager = [[XMPPManager alloc] init];
    });
    return defaultManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.loginHandler = nil;
        self.registerHandler = nil;
    }
    return self;
}

- (void)connect {
    if (!self.stream) {
        // 创建XMPPStream,只需要初始化一次,所以加判断
        self.stream = [[XMPPStream alloc] init];
        // 设置stream的域名和端口号
        self.stream.hostName = kHostName;
        self.stream.hostPort = kHostPort;
        
        // 添加代理 连接成功后调用传密码的方法
        [self.stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
}

// 连接服务器
- (void)connectToServer{
    // 判断是否连接成功过
    if (![self.stream isConnected]) {
        // 连接到服务器
        NSError *error;
        [self.stream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
        if (error) {
            NSLog(@"Error : %@",error);
        } else {
            NSLog(@"connect success");
        }
    }
}

- (void)loginWithUser:(NSString *)username Password:(NSString *)password CompleteHandler:(LoginHandlerBlock)loginHander {
    self.loginHandler = loginHander;
    
    //disconnect first
    [self.stream disconnect];
    
    //setup the connection
    [self connect];
    
    //set JID for the connection
    self.stream.myJID = [XMPPJID jidWithUser:username domain:kHostName resource:@"iPhone"];
    self.tempPwd = password;
    
    //do connect
    [self connectToServer];
}

- (void)sendOnlineMessage {
    XMPPPresence *pre = [XMPPPresence presenceWithType:@"available"];
    [self.stream sendElement:pre];
}

- (void)sendOfflineMessage {
    XMPPPresence *pre = [XMPPPresence presenceWithType:@"unavailable"];
    [self.stream sendElement:pre];
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error {
    //unable to connect to the server, handle error
    if (self.loginHandler) {
        self.loginHandler(@"network unavailable", error);
    }
    
    if (self.registerHandler) {
        self.registerHandler(@"network unavailable", error);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectStateNotification" object:nil userInfo:@{@"state":@"disconnect"}];
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    //connect to the server successfully, then do login or register bellow
    NSError *error = nil;
    if (self.loginHandler) {
        [self.stream authenticateWithPassword:self.tempPwd error:&error];
    }else if (self.registerHandler) {
        [self.stream registerWithPassword:self.tempPwd error:&error];
    }
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    NSLog(@"login success");
    if (self.loginHandler) {
        self.loginHandler(@"login success", nil);
    }
    self.loginHandler = nil;
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error {
    NSLog(@"login fail");
    if (self.loginHandler) {
        self.loginHandler(@"login fail", [NSError errorWithDomain:NSURLErrorDomain code:0 userInfo:@{}]);
    }
    self.loginHandler = nil;
}

- (void)xmppStreamDidRegister:(XMPPStream *)sender {
    NSLog(@"register success");
    if (self.registerHandler) {
        self.registerHandler(@"register success", nil);
    }
    self.registerHandler = nil;
}

- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error {
    NSLog(@"register fail");
    if (self.registerHandler) {
        self.registerHandler(@"register fail", [[NSError alloc] init]);
    }
    self.registerHandler = nil;
}
@end
