//
//  WordChoseView.h
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/6.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WordChoseViewDelegate <NSObject>

- (void)didSelectedLetterButton:(NSString *)letter;

- (void)didSelectedEnterButton;

@end

@interface WordChoseView : UIView

@property (nonatomic, assign) NSInteger canClickCount;

@property (nonatomic, assign) NSInteger hasClickCount;

@property (nonatomic, strong) NSArray *lettersArray;

@property (nonatomic, assign) id<WordChoseViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end
