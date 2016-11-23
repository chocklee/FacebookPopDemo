//
//  LCHProgressView.h
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/3.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCHProgressView : UIView

@property (nonatomic, strong) UIColor *progressTintColor;

@property (nonatomic, assign) float progress;

@property (nonatomic, assign) NSInteger currentValue;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *titleFont;

- (instancetype)initWithFrame:(CGRect)frame andMaxValue:(NSInteger)value;

@end
