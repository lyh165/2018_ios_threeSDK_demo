//
//  ViewController.m
//  SDK_Tencent_QQ_AuthLogin
//
//  Created by lee on 2018/9/3.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<TencentSessionDelegate>

@property (nonatomic,strong) AppDelegate *appDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)QQLogin:(id)sender {
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _appDelegate.tencentOAuth.authShareType = AuthShareType_QQ;//特别要注意，登录前需要授权，否则会爆出未授权错误（多看文档还是有好处的哈）
    NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo", @"add_t", nil];
    [_appDelegate.tencentOAuth authorize:permissions];
}

//-(void)tencentDidLogin
//{
//    NSLog(@"yes");
//    NSLog(@"%@ -- %@",_appDelegate.tencentOAuth.accessToken, _appDelegate.tencentOAuth.openId);// 打印下accessToken和openId 代表我成功了，存储起来用的时候直接用，或者此处请求服务器接口传给服务器，获取我们项目中用到的userSession
//    //获取用户个人信息
//    [_appDelegate.tencentOAuth getUserInfo];
//    
//}
//
//-(void)tencentDidNotLogin:(BOOL)cancelled
//{
//    if (cancelled) {
//        NSLog(@"取消登录");
//    }
//}
//-(void)tencentDidNotNetWork
//{
//    NSLog(@"tencentDidNotNetWork");
//}
//
//- (void)getUserInfoResponse:(APIResponse*)response
//{
//    NSLog(@"response啊啊啊 -- %@", response.jsonResponse);
//}

@end
