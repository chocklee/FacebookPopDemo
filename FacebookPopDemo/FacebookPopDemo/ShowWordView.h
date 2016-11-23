//
//  ShowWordView.h
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/6.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowWordViewDelegate <NSObject>

- (void)didSelectedDeleteButton:(NSString *)letter;

@end

@interface ShowWordView : UIView

@property (nonatomic, assign) id<ShowWordViewDelegate> delegate;

@property (nonatomic, assign) NSInteger length;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)showLetterOnLabel:(NSString *)letter;

@end
