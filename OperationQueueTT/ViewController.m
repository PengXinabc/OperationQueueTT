//
//  ViewController.m
//  OperationQueueTT
//
//  Created by Xin Peng on 17/3/21.
//  Copyright © 2017年 EB. All rights reserved.
//

#import "ViewController.h"
#import "TestOperation.h"
#import "TestOperationTwo.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *userid;
//@property (nonatomic, weak) IBOutlet UIImageView *imgview;
//@property (nonatomic, weak) IBOutlet UIImageView *imgview1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestOperation *op = [[TestOperation alloc] init];
    TestOperationTwo *op1 = [[TestOperationTwo alloc] init];
    NSOperationQueue *que = NSOperationQueue.new;
    [op addDependency:op1];
    [que addOperation:op];
    [que addOperation:op1];
    
}

//- (void)imgDown:(NSNotification *)notify {
//    NSData *data = notify.object;
//    if ([notify.name isEqualToString:@"DOWN_RESULT"]) {
//        self.imgview.image = [UIImage imageWithData:data];
//    }else{
//        self.imgview1.image = [UIImage imageWithData:data];
//    }
//    
//}

@end
