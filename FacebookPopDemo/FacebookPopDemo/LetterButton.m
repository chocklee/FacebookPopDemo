//
//  LetterButton.m
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/6.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import "LetterButton.h"

@implementation LetterButton

+ (instancetype)button {
    return [self buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    [self setTitleColor:[UIColor colorWithRed:94.0 / 255 green:94.0 / 255 blue:94.0 / 255 alpha:1] forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium"
                                           size:23];
    self.isSelected = NO;
}

- (void)setIsSelected:(BOOL)isSelected {
    if (_isSelected != isSelected) {
        _isSelected = isSelected;
        if (_isSelected) {
            self.enabled = NO;
            self.alpha = 0.6f;
        } else {
            self.enabled = YES;
            self.alpha = 1.0f;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
