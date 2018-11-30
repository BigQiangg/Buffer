//
//  main.m
//  QueueTest
//
//  Created by zwq on 2018/11/19.
//  Copyright © 2018 zwq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TBuffer.h"
int main(int argc, char * argv[]) {
    TBuffer * buffer = [[TBuffer alloc] init];
    for (int i = 0; i< 30; i++) {
        NSString * queueName = [NSString stringWithFormat:@"queue%d",i];
        dispatch_queue_t queue = dispatch_queue_create(queueName.UTF8String, NULL);
        dispatch_async(queue, ^{
            int i = 1;
            while (1) {
                [buffer inBuffer:@[[NSString stringWithFormat:@"%@:%d",queueName,i++]]];
                sleep(1);
            }
            
        });
    }
    
    [buffer outBufferWithBlock:^(NSArray *array) {
        NSLog(@"[%d]",array.count);
//        NSLog(@"[%d]%@",array.count,array);

    }];

    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

