//
//  AppDelegate.m
//  SDK_Tencent_Bugly
//
//  Created by lee on 2018/8/27.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>
@interface AppDelegate ()
<BuglyDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [Bugly startWithAppId:@"5f2369df96"];
//    BuglyConfig *config = [[BuglyConfig alloc] init];
//    config.blockMonitorEnable = YES;
//    config.blockMonitorTimeout = 2;
//    config.consolelogEnable = YES;
//    config.delegate = self;
//    [Bugly startWithAppId:@"5f2369df96" config:config];

    [Bugly startWithAppId:@"5f2369df96" config:^{
        BuglyConfig *config = [[BuglyConfig alloc] init];
        config.blockMonitorEnable = YES;
        config.blockMonitorTimeout = 2;
        config.consolelogEnable = YES;
        config.delegate = self;
        return config;
    }()];
    
 
    // 下面是故意产生崩溃日志
//    NSArray *array = @[@"l",@"y",@"h"];
//    NSLog(@"array %@",array[5]);
    
    return YES;
}
- (NSString *)attachmentForException:(NSException *)exception {
    return @"Do you want to do...";
}

@end
