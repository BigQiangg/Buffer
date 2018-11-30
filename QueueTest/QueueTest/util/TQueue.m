//
//  TQueue.m
//  TQueue
//
//  Created by zcc on 2018/11/19.
//  Copyright © 2018年 com.zcc.www. All rights reserved.
//

#import "TQueue.h"

@implementation TQueue{
    NSMutableArray * bufferArray;
    dispatch_queue_t queue;
    dispatch_queue_t outQueue;
    NSLock * lock;
}

- (id) init{
    if (self = [super init]) {
        bufferArray = [NSMutableArray array];
        lock = [[NSLock alloc] init];
    }
    return self;
}

- (void)inPut:(NSArray *) array{
    [[self rwLock] lock];
    [bufferArray addObjectsFromArray:array];
    [[self rwLock] unlock];
}

- (NSArray *)outPut{
    [[self rwLock] lock];
    NSArray * copyArray = [bufferArray mutableCopy];
    [bufferArray removeAllObjects];
    [[self rwLock] unlock];
    return copyArray;
}

- (NSLock *)rwLock{
    if (!lock) {
        lock = [[NSLock alloc] init];
    }
    return lock;
}

@end
