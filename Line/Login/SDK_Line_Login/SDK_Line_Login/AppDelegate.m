//
//  AppDelegate.m
//  SDK_Line_Login
//
//  Created by lee on 2018/9/26.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "AppDelegate.h"
#import <LineSDK/LineSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}
/***
 
 App name 抓抓樂線上遊樂場

 App description 全台唯一最好玩的線上娃娃機開跑啦！ 讓你在家也能享受現場的臨場感，多人同時觀看，趕快展現夾娃娃的技術給眾人看吧！任何獎品中獎直接寄給您。你還在等什麼？快點帶著大朋友小朋友一起來玩!
 Channel ID 1606490816
 Channel secret aad23967dc6ff16d664ff9a89263071d
 App type NATIVE_APP WEB
 
 OpenID Connect Email Applied
 Email address lawolgood@hotmail.com
 
 参考
 https://developers.line.me/en/docs/ios-sdk/integrate-line-login/
    记得是line login应用
 1.配置info.plist
    ChannelID
    LSApplicationQueriesSchemes(白名单)
 2.添加系统需要依赖的库
 3.处理调用第三方应用
     - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
     {
     return [[LineSDKLogin sharedInstance] handleOpenURL:url];
     }
 
 
 
 4.在登录界面处理
    3.1 设置代理 [LineSDKLogin sharedInstance].delegate = self;
    3.3 按钮点击 触发line的登录 [[LineSDKLogin sharedInstance] startLogin];
    3.2 监听login代理
        code
 - (void)didLogin:(LineSDKLogin *)login
 credential:(LineSDKCredential *)credential
 profile:(LineSDKProfile *)profile
 error:(NSError *)error
 {
         if (error) {
         // Login failed with an error. Use the error parameter to identify the problem.
         NSLog(@"Error: %@", error.localizedDescription);
         }
         else {
 
         // Login success. Extracts the access token, user profile ID, display name, status message, and profile picture.
         NSString * accessToken = credential.accessToken.accessToken;
         NSString * userID = profile.userID;
         NSString * displayName = profile.displayName;
         NSString * statusMessage = profile.statusMessage;
         NSURL * pictureURL = profile.pictureURL;
         NSLog(@"accessToken: %@", accessToken); // 访问令牌
         NSLog(@"userID: %@", userID);           // 用户id
         NSLog(@"displayName: %@", displayName); // 用户昵称
         NSLog(@"statusMessage: %@", statusMessage);
         NSLog(@"pictureURL: %@", pictureURL); // 头像
         NSString *authMsg = [NSString stringWithFormat:@"授权返回的信息:accessToken: %@,userID: %@,displayName: %@,statusMessage: %@,pictureURL: %@",accessToken,userID,displayName,statusMessage,pictureURL];
 
         self.tv_content.text = authMsg;
 
 
         NSString * pictureUrlString;
 
         // If the user does not have a profile picture set, pictureURL will be nil
         if (pictureURL) {
            pictureUrlString = profile.pictureURL.absoluteString;
         }
 
         }
 }
 */


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
{
    return [[LineSDKLogin sharedInstance] handleOpenURL:url];
}



@end
