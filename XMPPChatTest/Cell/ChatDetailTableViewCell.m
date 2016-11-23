//
//  ChatDetailTableViewCell.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/15.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "ChatDetailTableViewCell.h"
#import "MeSingleton.h"
#import "Masonry/Masonry.h"

#define WS(weakself) __weak __typeof(&*self)weakself=self;
@interface ChatDetailTableViewCell()
@property (nonatomic, strong) UIImageView *senderLogo;
@property (nonatomic, strong) UIImageView *reciverLogo;
@property (nonatomic, strong) UILabel *contentLbl;
@end

@implementation ChatDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initData];
        [self initUI];
    }
    
    return self;
}

- (void)initData {
    self.senderLogo = [[UIImageView alloc] init];
    self.reciverLogo = [[UIImageView alloc] init];
    self.contentLbl = [[UILabel alloc] init];
    [self addSubview:self.senderLogo];
    [self addSubview:self.reciverLogo];
    [self addSubview:self.contentLbl];
}

- (void)initUI {
    WS(ws);
    float logoSize = 44.;
    float defaultSpace = 10;
    
    [self.senderLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(logoSize);
        make.left.and.top.equalTo(ws).with.offset(defaultSpace);
    }];
    self.senderLogo.layer.cornerRadius = logoSize/2;
    self.senderLogo.layer.masksToBounds = YES;
    
    [self.reciverLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(logoSize);
        make.top.equalTo(ws).with.offset(defaultSpace);
        make.right.equalTo(ws).with.offset(-defaultSpace);
    }];
    self.reciverLogo.layer.cornerRadius = logoSize/2;
    self.reciverLogo.layer.masksToBounds = YES;
    
    [self.contentLbl setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.senderLogo.mas_right).with.offset(defaultSpace);
        make.right.equalTo(ws.reciverLogo.mas_left).with.offset(-defaultSpace);
        make.top.equalTo(ws.mas_top).with.offset(defaultSpace);
    }];
}

- (void)updateWithChatContent:(ChatContentModel *)chatContent {
    if ([chatContent.reciver isEqual:[MeSingleton sharedMe]]) {
        //接收到的消息，隐藏自己的头象
        [self.senderLogo setImage:[UIImage imageNamed:chatContent.sender.logo]];
        self.reciverLogo.hidden = YES;
        self.senderLogo.hidden = NO;
        self.contentLbl.textAlignment = NSTextAlignmentLeft;
    }else {
        //发送的消息，隐藏对方的头像
        [self.reciverLogo setImage:[UIImage imageNamed:chatContent.sender.logo]];
        self.reciverLogo.hidden = NO;
        self.senderLogo.hidden = YES;
        self.contentLbl.textAlignment = NSTextAlignmentRight;
    }
    [self.contentLbl setText:chatContent.msg];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
