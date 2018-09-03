#import "AppDelegate.h"

#define AppId @"wxe42cbbbada2ba5a0"
#define AppSerect @"ea72c6a285545d1099993ef7e5d84df8"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WXApi registerApp:AppId];
    return YES;
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark 1、微信授权第一步：获取code
- (void)onResp:(BaseResp *)resp
{
    switch (resp.errCode)
    {
        case 0:
        {
            // 用户同意 获取code
            SendAuthResp *yuResp = (SendAuthResp *)resp;
            NSLog(@"code == %@",yuResp.code);
            [self getWeiXinOpenId:yuResp.code];
        }
            break;
        case -4://用户拒绝授权
        {
            NSLog(@"您拒绝授权微信登录");
        }
            break;
        case -2://用户取消
        {
            NSLog(@"您取消了授权微信登录");
        }
            break;
    }
    
}
#pragma mark 3、微信授权第三步：通过access_token获取个人信息

-(void)getWeiXinOpenId:(NSString *)code{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",AppId,AppSerect,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"dic %@",dic);
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
                NSLog(@"dic %@",dic);

            }
        });
    });
}

    

@end



