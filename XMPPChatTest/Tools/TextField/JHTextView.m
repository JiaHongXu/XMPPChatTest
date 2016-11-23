//
//  UITextView+PlaceHolder
//  JHKeyboardInputView
//
//  Created by 307A on 16/10/2.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "JHTextView.h"
@interface JHTextView()
@property (nonatomic) UILabel *placeTextLab;
@property (nonatomic) SizeDidChangeBlock sizeDidChangeBlock;
@end

@implementation JHTextView
- (instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].statusBarFrame.size.width, 30)];
    if (self) {
        [self initData];
        [self updateFrame];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self updateFrame];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame PlaceHolder:(NSString *)placeHolder{
    self = [self initWithFrame:frame];
    if (self) {
        [self setPlaceholder:placeHolder];
    }
    
    return self;
}

- (void)initData{
    _maxHeight = 60;
    _placeholder = @"";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    
    [self setFont:[UIFont systemFontOfSize:17]];
}

- (void)updateFrame{
    CGSize newSize = [self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)];
    
    self.scrollEnabled = newSize.height > _maxHeight;
    
    CGRect newRect = self.frame;
    newRect.size = CGSizeMake(self.frame.size.width, newSize.height>_maxHeight?_maxHeight:newSize.height);
    
    if (_sizeDidChangeBlock && newRect.size.height != self.frame.size.height) {
        _sizeDidChangeBlock(newRect.size);
    }
    
    self.frame = newRect;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    if (_placeholder.length>0) {
        if (!_placeTextLab) {
            CGRect frame = CGRectMake(0, 0, self.bounds.size.width, 0);
            _placeTextLab = [[UILabel alloc]initWithFrame:frame];
            _placeTextLab.font = self.font;
            _placeTextLab.backgroundColor = [UIColor clearColor];
            _placeTextLab.textColor = [UIColor grayColor];
            _placeTextLab.hidden = NO;
            _placeTextLab.lineBreakMode = NSLineBreakByWordWrapping;
            _placeTextLab.numberOfLines = 0;
            [self addSubview:_placeTextLab];
        }
        
        _placeTextLab.text = _placeholder;
        [_placeTextLab sizeToFit];
        [_placeTextLab setFrame:CGRectMake(8, 8, CGRectGetWidth(self.bounds)-16, CGRectGetHeight(_placeTextLab.frame))];
    }
    if (self.text.length==0 && _placeholder.length>0) {
        _placeTextLab.hidden = NO;
    }
}

- (void)textDidChange:(TextDidChangeBlock)textDidChangeBlock{
    //if textfield is empty, show placeholder, else, hide it.
    if ([self.text isEqualToString:@""]) {
        _placeTextLab.hidden = NO;
    }else{
        _placeTextLab.hidden = YES;
    }
    [self updateFrame];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sizeDidChange:(SizeDidChangeBlock)sizeDidChangeBlock{
    _sizeDidChangeBlock = sizeDidChangeBlock;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
