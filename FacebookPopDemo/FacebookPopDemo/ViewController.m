//
//  ViewController.m
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/2.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

/*
View Properties

Alpha - kPOPViewAlpha
Color - kPOPViewBackgroundColor
Size - kPOPViewBounds
Center - kPOPViewCenter
Location & Size - kPOPViewFrame
Size - kPOPViewScaleXY
Size(Scale) - kPOPViewSize

 
Layer Properties
 
Color - kPOPLayerBackgroundColor
Size - kPOPLayerBounds
Size - kPOPLayerScaleXY
Size - kPOPLayerSize
Opacity - kPOPLayerOpacity
Position - kPOPLayerPosition
X Position - kPOPLayerPositionX
Y Position - kPOPLayerPositionY
Rotation - kPOPLayerRotation
Color - kPOPLayerBackgroundColor
*/
 
#import "ViewController.h"
#import <pop/POP.h>
#import "LCHProgressView.h"
#import "WordButton.h"
#import "AnalysisButton.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *wordLabel;

@property (nonatomic, strong) UILabel *phoneticLabel;

@property (nonatomic, strong) UIButton *voiceButton;

@property (nonatomic, strong) WordButton *wordButtonA;

@property (nonatomic, strong) WordButton *wordButtonB;

@property (nonatomic, strong) WordButton *wordButtonC;

@property (nonatomic, strong) WordButton *wordButtonD;

@property (nonatomic, strong) AnalysisButton *analysisButton;

@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) LCHProgressView *progressView;

@property (nonatomic, strong) UIButton *heartButton;

@property (nonatomic, strong) NSArray *buttonArray;

@property (nonatomic, strong) NSArray *paraphraseArray;

@property (nonatomic, assign) BOOL isSelect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:122.0 / 255 green:169.0 / 255 blue:54.0 / 255 alpha:1];
    
    // 设置单词显示及发音按钮
    [self setWordAndVoice];
    // 设置选项按钮
    [self setOptionButton];
    // 设置解析和下一个按钮
    [self setAnalysisAndNextButton];
    // 设置进度条及收藏按钮
    [self setProgressAndHeartButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.wordLabel removeObserver:self forKeyPath:@"text"];
}

#pragma mark - 按钮点击事件
- (void)didSelectedButton:(WordButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"n.允许进入；承认"]) {
        sender.isRight = YES;
        // 切换下一题
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showNextWord];
        });
    } else {
        sender.isWrong = YES;
        [self alphaToOneAnimation:self.analysisButton];
        [self alphaToOneAnimation:self.nextButton];
    }
    
    for (WordButton *btn in self.buttonArray) {
        btn.enabled = NO;
        if (!btn.isRight && !btn.isWrong) {
            if ([btn.titleLabel.text isEqualToString:@"n.允许进入；承认"]) {
                btn.isRight = YES;
            } else {
                [self flyoutScreenAnimation:btn];
            }
        }
    }
}

- (void)didSelectedNextButton:(UIButton *)sender {
    // 切换下一题
    [self showNextWord];
}

- (void)didSelectedHeartButton:(UIButton *)sender {
    if (!self.isSelect) {
        [self scaleAnimation:sender];
        [self.heartButton setImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
        self.isSelect = YES;
        NSLog(@"收藏");
    } else {
        [self.heartButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
        self.isSelect = NO;
        NSLog(@"取消收藏");
    }
}

- (void)didSelectedVoiceButton:(UIButton *)sender {
    NSLog(@"发音");
}

#pragma mark - 动画
- (void)showScreenAnimation:(WordButton *)button {
    POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.beginTime = CACurrentMediaTime() + 0.2;
    scaleAnim.springBounciness = 20;
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    POPSpringAnimation *opacityAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnim.beginTime = CACurrentMediaTime() + 0.2;
    opacityAnim.toValue = @(1.0);
    
    [button.layer pop_addAnimation:scaleAnim forKey:@"scaleAnim"];
    [button.layer pop_addAnimation:opacityAnim forKey:@"opacityAnim"];
}

- (void)flyoutScreenAnimation:(WordButton *)button {
    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation easeInEaseOutAnimation];
    offscreenAnimation.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionX];
    offscreenAnimation.toValue = @(self.view.center.x + CGRectGetMaxX(self.view.frame));
    offscreenAnimation.duration = 0.3f;
    [button.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnim"];
}

- (void)alphaToZeroAnimation:(id)sender {
    POPSpringAnimation *alphaAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alphaAnim.toValue = @(0.0);
    [sender pop_addAnimation:alphaAnim forKey:@"alphaToZeroAnim"];
}

- (void)alphaToOneAnimation:(id)sender {
    POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alphaAnim.toValue = @(1.0);
    [sender pop_addAnimation:alphaAnim forKey:@"alphaToOneAnim"];
}

- (void)scaleAnimation:(id)sender {
    POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    scaleAnim.beginTime = CACurrentMediaTime() + 0.2;
    scaleAnim.springBounciness = 20;
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.4, 1.4)];
    [sender pop_addAnimation:scaleAnim forKey:@"scaleAnim"];
}

- (void)showWordAnimation {
    POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alphaAnim.beginTime = CACurrentMediaTime() + 0.3;
    alphaAnim.toValue = @(1.0);
    [self.wordLabel pop_addAnimation:alphaAnim forKey:@"alphaToOneAnim"];
    [self.phoneticLabel pop_addAnimation:alphaAnim forKey:@"alphaToOneAnim"];
    [self.voiceButton pop_addAnimation:alphaAnim forKey:@"alphaToOneAnim"];
}

#pragma mark - 显示下一题
- (void)showNextWord {
    [self alphaToZeroAnimation:self.analysisButton];
    [self alphaToZeroAnimation:self.nextButton];
    self.progressView.currentValue += 1;
    
    self.wordLabel.text = @"adjust";
    self.wordLabel.alpha = 0;
    self.phoneticLabel.text = @"ə'dʒʌst";
    self.phoneticLabel.alpha = 0;
    self.voiceButton.alpha = 0;
    
    self.buttonArray = nil;
    self.paraphraseArray = nil;
    for (UIButton *button in self.view.subviews) {
        if ([button isKindOfClass:[WordButton class]]) {
            [button removeFromSuperview];
        }
    }
    [self setOptionButton];
}

#pragma mark - 设置选项按钮
- (void)setOptionButton {
    // 释义数组
    self.paraphraseArray = @[@"n.允许进入；承认",@"v.（使）中止，（使）夭折；（使）流产，堕胎",@"v.承认，确认；感谢；对......打招呼",@"adj.精确的，精密的，正确无误的"];
    
    // 设置单词按钮
    self.wordButtonA = [WordButton button];
    self.wordButtonA.frame = CGRectMake(0, 221, 330, 62);
    self.wordButtonA.center = CGPointMake(self.view.center.x, self.wordButtonA.center.y);
    [self.wordButtonA setTitle:self.paraphraseArray[0] forState:UIControlStateNormal];
    [self.wordButtonA addTarget:self action:@selector(didSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wordButtonA];
    
    self.wordButtonB = [WordButton button];
    self.wordButtonB.frame = CGRectMake(0, 297, 330, 62);
    self.wordButtonB.center = CGPointMake(self.view.center.x, self.wordButtonB.center.y);
    [self.wordButtonB setTitle:self.paraphraseArray[1] forState:UIControlStateNormal];
    [self.wordButtonB addTarget:self action:@selector(didSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wordButtonB];
    
    self.wordButtonC = [WordButton button];
    self.wordButtonC.frame = CGRectMake(0, 373, 330, 62);
    self.wordButtonC.center = CGPointMake(self.view.center.x, self.wordButtonC.center.y);
    [self.wordButtonC setTitle:self.paraphraseArray[2] forState:UIControlStateNormal];
    [self.wordButtonC addTarget:self action:@selector(didSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wordButtonC];
    
    self.wordButtonD = [WordButton button];
    self.wordButtonD.frame = CGRectMake(0, 449, 330, 62);
    self.wordButtonD.center = CGPointMake(self.view.center.x, self.wordButtonD.center.y);
    [self.wordButtonD setTitle:self.paraphraseArray[3] forState:UIControlStateNormal];
    [self.wordButtonD addTarget:self action:@selector(didSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wordButtonD];
    
    // 添加动画
    [self showScreenAnimation:self.wordButtonA];
    [self showScreenAnimation:self.wordButtonB];
    [self showScreenAnimation:self.wordButtonC];
    [self showScreenAnimation:self.wordButtonD];
    self.buttonArray = @[self.wordButtonA,self.wordButtonB,self.wordButtonC,self.wordButtonD];
}

#pragma mark - 设置单词显示及发音按钮
- (void)setWordAndVoice {
    // 单词
    self.wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 84, 330, 48)];
    self.wordLabel.center = CGPointMake(self.view.center.x, self.wordLabel.center.y);
    self.wordLabel.numberOfLines = 0;
    self.wordLabel.textAlignment = NSTextAlignmentCenter;
    self.wordLabel.font = [UIFont boldSystemFontOfSize:32];
    self.wordLabel.textColor = [UIColor whiteColor];
    self.wordLabel.text = @"admission";
    self.wordLabel.alpha = 0;
    [self.wordLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.wordLabel];
    
    // 音标
    self.phoneticLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, 330, 20)];
    self.phoneticLabel.center = CGPointMake(self.view.center.x, self.phoneticLabel.center.y);
    self.phoneticLabel.textAlignment = NSTextAlignmentCenter;
    self.phoneticLabel.textColor = [UIColor whiteColor];
    self.phoneticLabel.text = @"əd'mɪʃən";
    self.phoneticLabel.alpha = 0;
    [self.view addSubview:self.phoneticLabel];
    
    // 发音按钮
    self.voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.voiceButton.frame = CGRectMake(0, 168, 32, 32);
    self.voiceButton.center = CGPointMake(self.view.center.x, self.voiceButton.center.y);
    [self.voiceButton setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [self.voiceButton addTarget:self action:@selector(didSelectedVoiceButton:) forControlEvents:UIControlEventTouchUpInside];
    self.voiceButton.alpha = 0;
    [self.view addSubview:self.voiceButton];
    
    // 添加动画
    [self showWordAnimation];
}

#pragma mark - 设置解析和下一个按钮
- (void)setAnalysisAndNextButton {
    // 解析按钮
    self.analysisButton = [AnalysisButton button];
    self.analysisButton.frame = CGRectMake(23, 525, 152, 61);
    self.analysisButton.alpha = 0;
    [self.view addSubview:self.analysisButton];
    
    // 下一题按钮
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.frame = CGRectMake(203, 525, 152, 61);
    self.nextButton.alpha = 0;
    self.nextButton.backgroundColor = [UIColor whiteColor];
    [self.nextButton setTitleColor:[UIColor colorWithRed:94.0 / 255 green:94.0 / 255 blue:94.0 / 255 alpha:1] forState:UIControlStateNormal];
    [self.nextButton setTitle:@"下一题" forState:UIControlStateNormal];
    self.nextButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.nextButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium"
                                                      size:24];
    self.nextButton.layer.masksToBounds = YES;
    self.nextButton.layer.cornerRadius = 8.0f;
    [self.nextButton addTarget:self action:@selector(didSelectedNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
}

#pragma mark - 设置进度条及收藏按钮
- (void)setProgressAndHeartButton {
    // 进度条
    self.progressView = [[LCHProgressView alloc] initWithFrame:CGRectMake(0, 613, 176, 26) andMaxValue:40];
    self.progressView.center = CGPointMake(self.view.center.x, self.progressView.center.y);
    self.progressView.progressTintColor = [UIColor colorWithRed:82.0 / 255 green:191.0 / 255    blue:201.0 / 255 alpha:1];
    self.progressView.titleColor = [UIColor colorWithRed:94.0 / 255 green:94.0 / 255 blue:94.0 / 255 alpha:1];
    self.progressView.currentValue = 1;
    [self.view addSubview:self.progressView];
    
    // 收藏按钮
    self.heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.heartButton.frame = CGRectMake((CGRectGetWidth(self.view.frame) + CGRectGetWidth(self.progressView.frame)) / 2 + 20, 610, 32, 32);
    [self.heartButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    [self.heartButton addTarget:self action:@selector(didSelectedHeartButton:) forControlEvents:UIControlEventTouchUpInside];
    self.isSelect = NO;
    [self.view addSubview:self.heartButton];
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"]) {
        [self showWordAnimation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
