//
//  WordButton.h
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/3.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordButton : UIButton

@property (nonatomic, assign) BOOL isRight;

@property (nonatomic, assign) BOOL isWrong;

+ (instancetype)button;

@end
