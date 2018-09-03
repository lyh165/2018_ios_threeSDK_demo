//
//  AppDelegate.m
//  SDK_Tencent_QQ_AuthLogin
//
//  Created by lee on 2018/9/3.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"1106870196" andDelegate:self];
    _tencentOAuth.redirectURI = @"www.qq.com";
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    NSLog(@"%s %@",__func__,url);
    if ([url.absoluteString containsString:@"tencent"]) {
        
    }
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    NSLog(@"%s %@",__func__,url);
    return [TencentOAuth HandleOpenURL:url];
}



#pragma mark -- TencentSessionDelegate
-(void)tencentDidLogin
{
    NSLog(@"yes");
    NSLog(@"%@ -- %@",_tencentOAuth.accessToken, _tencentOAuth.openId);// 打印下accessToken和openId 代表我成功了，存储起来用的时候直接用，或者此处请求服务器接口传给服务器，获取我们项目中用到的userSession
    //获取用户个人信息
    [_tencentOAuth getUserInfo];
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
        NSLog(@"取消登录");
    }
}
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
}

/**
 获取个人信息

 @param response 返回的响应
 */
- (void)getUserInfoResponse:(APIResponse*)response
{
    NSLog(@"response -- %@", response.jsonResponse);
}


@end





/**
 1、tencent的sdk
    TencentOpenAPI.framework
 2、系统依赖库
    SystemConfiguration.framework
 3、url type设置
    
 */
