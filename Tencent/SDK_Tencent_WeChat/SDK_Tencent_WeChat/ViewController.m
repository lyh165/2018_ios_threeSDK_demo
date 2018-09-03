//
//  ViewController.m
//  SDK_Tencent_WeChat
//
//  Created by lee on 2018/9/3.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)login:(id)sender {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        //这里是按照官方文档的说明来的此处我要获取的是个人信息内容
        req.scope = @"snsapi_userinfo";
        req.state = @"";
        //向微信终端发起SendAuthReq消息
        [WXApi sendReq:req];
    } else {
        NSLog(@"安装微信客户端");
    }
}



@end
