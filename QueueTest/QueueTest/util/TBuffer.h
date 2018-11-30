//
//  TBuffer.h
//  TBuffer
//
//  Created by zcc on 2018/11/19.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBuffer : NSObject

- (void)inBuffer:(NSArray *) array;

- (void)outBufferWithBlock:(void(^)(NSArray *array)) outBlock;

@end
