//
//  TwoViewController.m
//  FacebookPopDemo
//
//  Created by 李长浩 on 16/6/6.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import "TwoViewController.h"
#import "WordChoseView.h"
#import "NSMutableArray+randomArray.h"
#import "ShowWordView.h"
#import "LetterButton.h"

@interface TwoViewController () <WordChoseViewDelegate,ShowWordViewDelegate>

@property (nonatomic, strong) WordChoseView *wcView;

@property (nonatomic, strong) ShowWordView *swView;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:122.0 / 255 green:169.0 / 255 blue:54.0 / 255 alpha:1];
    
    NSArray *letters = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"j",@"k",@"l",@"m",@"n",@"o"];
    self.wcView = [[WordChoseView alloc] initWithFrame:CGRectMake(0, 100, 320, 188)];
    self.wcView.center = CGPointMake(self.view.center.x, self.wcView.center.y);
    self.wcView.lettersArray = letters;
    self.wcView.delegate = self;
    self.wcView.canClickCount = 5;
    [self.view addSubview:self.wcView];
    
    self.swView = [[ShowWordView alloc] initWithFrame:CGRectMake(0, 300, 320, 42)];
    self.swView.delegate = self;
    self.swView.length = 9;
    self.swView.center = CGPointMake(self.view.center.x, self.swView.center.y);
    [self.view addSubview:self.swView];
}

- (void)didSelectedLetterButton:(NSString *)letter {
    [self.swView showLetterOnLabel:letter];
}

- (void)didSelectedDeleteButton:(NSString *)letter {
    for (LetterButton *btn in self.wcView.subviews) {
        if ([btn.titleLabel.text isEqualToString:letter]) {
            btn.isSelected = NO;
            self.wcView.hasClickCount--;
        }
    }
}

- (void)didSelectedEnterButton {
    NSLog(@"确认");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
