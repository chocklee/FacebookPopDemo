//
//  AnalysisButton.m
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/3.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import "AnalysisButton.h"

@implementation AnalysisButton

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
    self.backgroundColor = [UIColor colorWithRed:53.0 / 255 green:76.0 / 255 blue:92.0 / 255 alpha:1];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8.0f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 4.0f;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitle:@"解析" forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium"
                                           size:24];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
