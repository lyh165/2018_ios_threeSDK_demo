//
//  ViewController.m
//  SDK_Tencent_WeChat
//
//  Created by lee on 2018/9/3.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"




@interface ViewController ()<WXApiDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)login:(id)sender {
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"";
    if ([WXApi isWXAppInstalled]) {
        //这里是按照官方文档的说明来的此处我要获取的是个人信息内容
        
        //向微信终端发起SendAuthReq消息
        [WXApi sendReq:req];
    } else {
        NSLog(@"安装微信客户端");
        // 未安装时 使用网页授权登录
        [WXApi sendAuthReq:req viewController:self delegate:self];
        
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
    
    
  
    if ([WXApi isWXAppInstalled]) {
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
    } else {
        NSLog(@"安装微信客户端");
        // 未安装时 使用网页授权登录
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"";
        [WXApi sendAuthReq:req viewController:self delegate:self];
        
    }
    
    
    
    
    
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
    
    if ([WXApi isWXAppInstalled]) {
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
    } else {
        NSLog(@"安装微信客户端");
        // 未安装时 使用网页授权登录
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"";
        [WXApi sendAuthReq:req viewController:self delegate:self];
        
    }
    

}


#pragma mark - WXDelegate
-(void)onResp:(BaseResp*)resp{
    
    NSLog(@"回调处理");
#pragma 1、分享
    // 处理 分享请求 回调
    // iOS分享成功失败 是根据系统来返回的。可能分享失败 微信那边也会返回分享成功
    // 最好的处理是不管这个问题 不提示了
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        switch (resp.errCode) {
            case WXSuccess:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"分享成功!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
                
            default:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"分享失败!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
        }
        
    }
    else
        if ([resp isKindOfClass:[SendAuthResp class]])
        {
#pragma 1、授权登录
            SendAuthResp * res = (SendAuthResp*)resp;
            
            switch (resp.errCode) {
                case 0://用户同意
                {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        //                    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeChat_log_seuuess" object:nil userInfo:@{@"code":res.code}];
                        NSLog(@"返回结果 %@",res.code);
#warning 没有安装微信的时候 需要通过code获取微信用户信息
                        [self getWeiXinOpenId:res.code];
                        
                    });
                }
                    break;
                case -4://用户拒绝授权
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeChat_log_error" object:nil ];
                    NSLog(@"用户拒绝授权 %@",res.code);
                    
                    break;
                case -2://用户取消
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeChat_log_error" object:nil ];
                    NSLog(@"用户取消 %@",res.code);
                    
                    break;
                default:
                    break;
            }
            
        }
    
}

#pragma mark 3、微信授权第三步：通过access_token获取个人信息
#define AppId @"wxe42cbbbada2ba5a0"
#define AppSerect @"ea72c6a285545d1099993ef7e5d84df8"

-(void)getWeiXinOpenId:(NSString *)code{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",AppId,AppSerect,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"dic %@",[dic lyh_jsonLog_descriptionWithLocale:nil]);
                NSString *openID = dic[@"openid"];
                NSString *unionid = dic[@"unionid"];
                NSString *access_token = dic[@"access_token"];
                
                NSLog(@"openID %@",openID);
                NSLog(@"unionid %@",unionid);
                NSLog(@"access_token %@",access_token);
                [self getWeiXinUserInfoAccessToken:access_token Openid:openID];
            }
        });
    });
}

-(void)getWeiXinUserInfoAccessToken:(NSString *)access_token Openid:(NSString *)openId{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",access_token,openId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"dic %@",[dic lyh_jsonLog_descriptionWithLocale:nil]);

            }
        });
    });
}


@end
