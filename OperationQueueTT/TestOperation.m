//
//  TestOperation.m
//  OperationQueueTT
//
//  Created by Xin Peng on 17/3/23.
//  Copyright © 2017年 EB. All rights reserved.
//

#import "TestOperation.h"

@interface TestOperation () <NSURLSessionTaskDelegate>

@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@end

@implementation TestOperation
@synthesize executing = _executing;
@synthesize finished = _finished;


- (void)start{//
    if (self.isCancelled) {
        self.finished = YES;
        return;
    }
    NSLog(@"TestOperation executing");
    self.executing = YES;
    NSString *imgurl = @"http://img3.baozhenart.com/images/201602/source_img/20205_P_1454380927950.jpg";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imgurl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    request.HTTPShouldHandleCookies = YES;
    request.HTTPShouldUsePipelining = YES;
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 15;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:nil];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"TestOperation finished...");
        self.finished = YES;
        self.executing = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DOWN_RESULT" object:data];
        });
    }];
    [dataTask resume];
    
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isConcurrent {
    return YES;
}
@end
