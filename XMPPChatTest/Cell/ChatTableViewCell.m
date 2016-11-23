//
//  ChatTableViewCell.m
//  XMPPChatTest
//
//  Created by 307A on 2016/11/15.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "Masonry/Masonry.h"

#define WS(weakself) __weak __typeof(&*self)weakself=self;
@interface ChatTableViewCell()
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *contentLbl;
@property (nonatomic, strong) UILabel *timeLbl;
@end
@implementation ChatTableViewCell

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
    self.logo = [[UIImageView alloc] init];
    self.nameLbl = [[UILabel alloc] init];
    self.contentLbl = [[UILabel alloc] init];
    self.timeLbl = [[UILabel alloc] init];
    [self addSubview:self.logo];
    [self addSubview:self.nameLbl];
    [self addSubview:self.contentLbl];
    [self addSubview:self.timeLbl];
}

- (void)initUI {
    WS(ws);
    float logoSize = 44.;
    float defaultSpace = 10;
    
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(logoSize);
        make.left.and.top.equalTo(ws).with.offset(defaultSpace);
    }];
    self.logo.layer.cornerRadius = logoSize/2;
    self.logo.layer.masksToBounds = YES;
    
    [self.timeLbl setFont:[UIFont systemFontOfSize:13]];
    [self.timeLbl setTextColor:[UIColor grayColor]];
    [self.timeLbl setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right).with.offset(-defaultSpace);
        make.top.equalTo(ws.mas_top).with.offset(defaultSpace);
    }];
    
    [self.nameLbl setFont:[UIFont systemFontOfSize:17]];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.logo.mas_right).with.offset(defaultSpace);
        make.right.equalTo(ws.timeLbl.mas_left).with.offset(-defaultSpace);
        make.top.equalTo(ws.logo.mas_top);
    }];
    
    [self.contentLbl setTextColor:[UIColor grayColor]];
    [self.contentLbl setFont:[UIFont systemFontOfSize:14]];
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.logo.mas_right).with.offset(defaultSpace);
        make.right.equalTo(ws.mas_right).with.offset(-defaultSpace);
        make.bottom.equalTo(ws.logo.mas_bottom);
    }];
}

- (void)updateWithChat:(ChatModel *)chat {
    [self.logo setImage:[UIImage imageNamed:[chat getContactLogo]]];
    [self.nameLbl setText:[chat getContactName]];
    [self.contentLbl setText:[chat getLatestChatContent].msg];
    [self.timeLbl setText:[chat getLatestChatContent].time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
