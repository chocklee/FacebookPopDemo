//
//  LCHProgressView.m
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/3.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import "LCHProgressView.h"

@interface LCHProgressView ()

@property (nonatomic, strong) CALayer *progressLayer;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) NSInteger maxValue;

@end

@implementation LCHProgressView

- (instancetype)initWithFrame:(CGRect)frame andMaxValue:(NSInteger)value {
    if (self = [super initWithFrame:frame]) {
        self.maxValue = value;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 2.5f;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height / 2.0f;
        
        self.progressLayer = [CALayer layer];
        self.progressLayer.frame = CGRectZero;
        [self.layer addSublayer:self.progressLayer];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 6)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = [NSString stringWithFormat:@"1/%ld",value];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    if (_progressTintColor != progressTintColor) {
        _progressTintColor = nil;
        _progressTintColor = progressTintColor;
        self.progressLayer.backgroundColor = progressTintColor.CGColor;
    }
}

- (void)setProgress:(float)progress {
    if (_progress != progress) {
        _progress = progress;
        self.progressLayer.frame = CGRectMake(0, 0, _progress * CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
}

- (void)setCurrentValue:(NSInteger)currentValue {
    if (_currentValue != currentValue) {
        _currentValue = currentValue;
        if (_currentValue <= self.maxValue) {
            self.progress = _currentValue * 1.0 / self.maxValue;
            self.titleLabel.text = [NSString stringWithFormat:@"%ld/%ld", _currentValue, self.maxValue];
        }
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (_titleColor != titleColor) {
        _titleColor = nil;
        _titleColor = titleColor;
        self.titleLabel.textColor = titleColor;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (_titleFont != titleFont) {
        _titleFont = nil;
        _titleFont = titleFont;
        self.titleLabel.font = titleFont;
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
