//
//  TestOperationTwo.m
//  OperationQueueTT
//
//  Created by Xin Peng on 17/3/24.
//  Copyright © 2017年 EB. All rights reserved.
//

#import "TestOperationTwo.h"

@interface TestOperationTwo ()


@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@end

@implementation TestOperationTwo
@synthesize executing = _executing;
@synthesize finished = _finished;


- (void)start{//
    if (self.isCancelled) {
        self.finished = YES;
        return;
    }
    NSLog(@"TestOperationTwo executing");
    self.executing = YES;
    NSString *imgurl = @"http://img2.baozhenart.com/images/201703/source_img/54866_G_1489463826422376203.JPG";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:imgurl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15];
    request.HTTPShouldHandleCookies = YES;
    request.HTTPShouldUsePipelining = YES;
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 15;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:nil];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"TestOperationTwo finished...");
        NSLog(@"TestOperationTwo sleep 4s...");
        sleep(4);
        self.finished = YES;
        self.executing = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DOWN_RESULT1" object:data];
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
