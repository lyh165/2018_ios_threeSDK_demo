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


- (IBAction)share_friends:(id)sender {
    NSLog(@"分享_微信好友");
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.text                = @"简单文本分享测试";
//    req.bText               = YES;
//    // 目标场景
//    // 发送到聊天界面  WXSceneSession
//    // 发送到朋友圈    WXSceneTimeline
//    // 发送到微信收藏  WXSceneFavorite
//    req.scene               = WXSceneSession;
//    [WXApi sendReq:req];

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.scene = WXSceneSession;// 分享到会话
    WXMediaMessage *medMessage = [WXMediaMessage message];
    medMessage.title = @"分享网页的标题"; // 标题
    medMessage.description = @"这个就是描述啦";// 描述
    WXWebpageObject *webPageObj = [WXWebpageObject object];
    [medMessage setThumbImage:[UIImage imageNamed:@"share_img"]];// 缩略图
    webPageObj.webpageUrl = @"http://www.cqbdjk.com/HJYL_Web/app_shareController.do?shareCode=100011";
    medMessage.mediaObject = webPageObj;
    req.message = medMessage;
    [WXApi sendReq:req];
    
   
  
}

- (IBAction)share_CircleOfFriends:(id)sender {
    NSLog(@"分享_微信朋友圈");
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.text                = @"简单文本分享测试";
//    req.bText               = YES;
//    // 目标场景
//    // 发送到聊天界面  WXSceneSession
//    // 发送到朋友圈    WXSceneTimeline
//    // 发送到微信收藏  WXSceneFavorite
//    req.scene               = WXSceneTimeline;
//    [WXApi sendReq:req];

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.scene = WXSceneTimeline;// 分享到会话
    WXMediaMessage *medMessage = [WXMediaMessage message];
    medMessage.title = @"分享网页的标题"; // 标题
    medMessage.description = @"这个就是描述啦";// 描述
    WXWebpageObject *webPageObj = [WXWebpageObject object];
    [medMessage setThumbImage:[UIImage imageNamed:@"share_img"]];// 缩略图
    webPageObj.webpageUrl = @"http://www.cqbdjk.com/HJYL_Web/app_shareController.do?shareCode=100011";
    medMessage.mediaObject = webPageObj;
    req.message = medMessage;
    [WXApi sendReq:req];
}


@end
