//
//  ShowWordView.m
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/6.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#define LineSpace 3

#import "ShowWordView.h"

@interface ShowWordView ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation ShowWordView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.count = 0;
    }
    return self;
}

- (void)setupView {
    float width = (self.frame.size.width - self.length * LineSpace - 32) / self.length * 1.0f;
    for (int i = 0; i < self.length; i++) {
        UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 + (width + LineSpace) * i, 5, width, 32)];
        letterLabel.textColor = [UIColor whiteColor];
        letterLabel.textAlignment = NSTextAlignmentCenter;
        letterLabel.font = [UIFont boldSystemFontOfSize:30];
        letterLabel.tag = 1200 + i;
        [self addSubview:letterLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0 + (width + LineSpace) * i, 32 + 5, width, 5)];
        lineView.tag = 1300 + i;
        lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView];
    }
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(self.length * (width + LineSpace), 5, 32, 32);
    [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(didSelectedDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
}

- (void)setLength:(NSInteger)length {
    if (_length != length) {
        _length = length;
        [self setupView];
    }
}

- (void)showLetterOnLabel:(NSString *)letter {
    UILabel *letterLabel = (UILabel *)[self viewWithTag:(1200 + self.count)];
    UIView *lineView = (UIView *)[self viewWithTag:(1300 + self.count)];
    letterLabel.text = letter;
    lineView.alpha = 0;
    self.count++;
}

- (void)didSelectedDeleteBtn:(UIButton *)sender {
    if (self.count == 0) {
        return;
    }
    UILabel *letterLabel = (UILabel *)[self viewWithTag:(1200 + self.count - 1)];
    [self.delegate didSelectedDeleteButton:letterLabel.text];
    UIView *lineView = (UIView *)[self viewWithTag:(1300 + self.count - 1)];
    letterLabel.text = nil;
    lineView.alpha = 1;
    self.count--;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
