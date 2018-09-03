//
//  AppDelegate.h
//  SDK_Tencent_QQ_AuthLogin
//
//  Created by lee on 2018/9/3.
//  Copyright © 2018年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,TencentSessionDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) TencentOAuth *tencentOAuth;

@end

