//
//  NSMutableArray+randomArray.m
//  QiMiaoBeiCi
//
//  Created by 李长浩 on 16/5/6.
//  Copyright © 2016年 北京精智科技. All rights reserved.
//

#import "NSMutableArray+randomArray.h"

@implementation NSMutableArray (randomArray)

- (NSArray *)randomArray {
    //随机数产生结果
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSInteger cnt = self.count;
    for (int i = 0; i < cnt; i++) {
        int r = arc4random() % self.count;
        resultArray[i] = self[r];
        self[r] = [self lastObject]; //为更好的乱序，故交换下位置
        [self removeLastObject];
    }
    return resultArray;
}

@end
