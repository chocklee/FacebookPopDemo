//
//  WordChoseView.m
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/6.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import "WordChoseView.h"
#import "LetterButton.h"

#define LineSpace 10

@interface WordChoseView ()

@end

@implementation WordChoseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hasClickCount = 0;
    }
    return self;
}

- (void)setupViewWithLetters:(NSArray *)lettersArray {
    float width = (self.frame.size.width - 4 * LineSpace) / 5.0f;
    float height = (self.frame.size.height - 2 * LineSpace) / 3.0f;
    int count = 0;
    for (int j = 0; j < 3; j++) {
        for (int i = 0; i < 5; i++) {
            LetterButton *letter = [LetterButton button];
            letter.frame = CGRectMake(0 + (width + LineSpace) * i, 0 + (height + LineSpace) * j, width, height);
            if (count == 14) {
                [letter setImage:[UIImage imageNamed:@"enter"] forState:UIControlStateNormal];
                [letter addTarget:self action:@selector(didSelectedEnterBtn:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [letter setTitle:lettersArray[count] forState:UIControlStateNormal];
                [letter addTarget:self action:@selector(didSelectedLetterBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            [self addSubview:letter];
            count++;
        }
    }
}

- (void)didSelectedLetterBtn:(LetterButton *)sender {
    if (self.hasClickCount < self.canClickCount) {
        sender.isSelected = YES;
        [self.delegate didSelectedLetterButton:sender.titleLabel.text];
        self.hasClickCount++;
    }
}

- (void)didSelectedEnterBtn:(LetterButton *)sender {
    [self.delegate didSelectedEnterButton];
}

- (void)setLettersArray:(NSArray *)lettersArray {
    if (_lettersArray != lettersArray) {
        _lettersArray = nil;
        _lettersArray = lettersArray;
        [self setupViewWithLetters:_lettersArray];
    }
}

- (void)setCanClickCount:(NSInteger)canClickCount {
    if (_canClickCount != canClickCount) {
        _canClickCount = canClickCount;
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
