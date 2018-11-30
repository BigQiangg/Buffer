//
//  TBuffer.m
//  TBuffer
//
//  Created by zcc on 2018/11/19.
//  Copyright © 2018年 com.zcc.www. All rights reserved.
//

#import "TBuffer.h"
#import "TQueue.h"
#define TIME_DURATION 0.5

@implementation TBuffer{
    NSTimer * timer;
    void(^outBufferBlock)(NSArray *);
    TQueue * queue;
}

- (id)init{
    if (self = [super init]) {
        queue = [[TQueue alloc] init];
    }
    return self;
}

- (void)inBuffer:(NSArray *) array{
    if (array.count == 0) {
        return;
    }

    [queue inPut:array];
}

- (void)outBufferWithBlock:(void(^)(NSArray * array)) outBlock{
    outBufferBlock = outBlock;
    
    if (timer) {
        [timer invalidate];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:TIME_DURATION
                                                   target:self
                                                 selector:@selector(outBuffer)
                                                 userInfo:nil
                                                  repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
}

- (void)outBuffer{
    //没有初始化存储数组
    if (!queue) {
        return;
    }

    if (outBufferBlock) {
        outBufferBlock(queue.outPut);
    }
}

@end
