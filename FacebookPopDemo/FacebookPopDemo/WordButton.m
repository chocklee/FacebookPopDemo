//
//  WordButton.m
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/3.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import "WordButton.h"
#import <pop/POP.h>

@implementation WordButton

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
    self.layer.cornerRadius = 8.0f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 4.0f;
    self.layer.opacity = 0;
    [self setTitleColor:[UIColor colorWithRed:94.0 / 255 green:94.0 / 255 blue:94.0 / 255 alpha:1] forState:UIControlStateNormal];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium"
                                           size:17];
    self.isRight = NO;
    self.isWrong = NO;
}

- (void)setIsRight:(BOOL)isRight {
    if (_isRight != isRight) {
        if (isRight) {
            _isRight = isRight;
            [self scaleAnimation];
            [self colorAnimation];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

- (void)setIsWrong:(BOOL)isWrong {
    if (_isWrong != isWrong) {
        if (isWrong) {
            _isWrong = isWrong;
            self.backgroundColor = [UIColor colorWithRed:234.0 / 255 green:87.0 / 255 blue:62.0 / 255 alpha:1];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

- (void)scaleAnimation {
    POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.springBounciness = 5;
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    [self.layer pop_addAnimation:scaleAnim forKey:@"scaleAnim"];
}

- (void)colorAnimation {
    POPSpringAnimation *colorAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
    colorAnim.springSpeed = 0.5;
    colorAnim.toValue = [UIColor colorWithRed:48.0 / 255 green:181.0 / 255 blue:91.0 / 255 alpha:1];
    [self pop_addAnimation:colorAnim forKey:@"colorAnim"];
}

@end
