

#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>
#import <RongIMLib/RongIMLib.h>
#import "ChatlistViewController.h"


@interface AppDelegate ()<RCIMUserInfoDataSource>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[RCIM sharedRCIM]initWithAppKey:@"c9kqb3rdcooaj"];
    [[RCIM sharedRCIM]connectWithToken:@"XZ5GUw6t+mwlmwyRZr+R8eP/bLeTsVctwZjwZwcK2mzpuJisKcAeDvl2U9n/Sec0Ag5wAah95goXBOwGPPOCGw==" success:^(NSString *userId) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"userid %@",userId);
            [[RCIM sharedRCIM]setUserInfoDataSource:self]; // 登录的时候 设置用户信息提供者的代理
            
            RCUserInfo *userinfo = [[RCUserInfo alloc]init];
            userinfo.userId = userId;
            userinfo.name = @"lyh165";
            //            userinfo.portraitUri = @"https://imgsa.baidu.com/forum/pic/item/d11373f082025aaf7a7c4de5f6edab64034f1a55.jpg";
            userinfo.portraitUri = @"https://imgsa.baidu.com/forum/pic/item/c9177f3e6709c93dbe94dfd9923df8dcd10054be.jpg";
            
            NSLog(@"用户名称 %@",[RCIM sharedRCIM].currentUserInfo.name);
            NSLog(@"用户userId %@",[RCIM sharedRCIM].currentUserInfo.userId);
            NSLog(@"用户portraitUri %@",[RCIM sharedRCIM].currentUserInfo.portraitUri);
            [RCIM sharedRCIM].currentUserInfo = userinfo;
            
            
            ChatlistViewController *chatListVC = [[ChatlistViewController alloc]init];
            self.nav = [[UINavigationController alloc]initWithRootViewController:chatListVC];
            self.window.rootViewController = self.nav;
        });
    } error:^(RCConnectErrorCode status) {
        
    } tokenIncorrect:^{
        
    }];
    
    return YES;
}


#pragma mark - 设置用户的头像和昵称
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion
{
    NSLog(@"userId  --- %@",userId);
    if([userId isEqualToString:@"lyh168"])
    {
        RCUserInfo *userinfo = [[RCUserInfo alloc]init];
        userinfo.userId = userId;
        userinfo.name = @"lyh168";
        userinfo.portraitUri = @"http://f2.topitme.com/2/58/7f/11231445813f57f582o.jpg";
        completion(userinfo);
    }
    else
    {
        RCUserInfo *userinfo = [[RCUserInfo alloc]init];
        userinfo.userId = userId;
        userinfo.name = @"lyh165";
        userinfo.portraitUri = @"http://imgtu.5011.net/uploads/content/20170209/4934501486627131.jpg";
        completion(userinfo);
    }
}


@end


/**
 用户1
 {"code":200,"userId":"lyh165","token":"XZ5GUw6t+mwlmwyRZr+R8eP/bLeTsVctwZjwZwcK2mzpuJisKcAeDvl2U9n/Sec0Ag5wAah95goXBOwGPPOCGw=="}
 
 信息1
 {"code":200,"userName":"lyh165","userPortrait":"http://img5.imgtn.bdimg.com/it/u=1934952861,3453579486&fm=27&gp=0.jpg","createTime":"2018-09-07 15:35:30"}
 
 
 用户2
 {"code":200,"userId":"lyh168","token":"N1oMiT9gTI5hxsJ2Tui1oBW+stva+49uDtHGscjU6QGm0XO6eY6YztImTMIqu+H2gNEEnTw+WydBMhtISHNgLA=="}
 信息2
 {"code":200,"userName":"lyh168","userPortrait":"http://a.hiphotos.baidu.com/zhidao/pic/item/21a4462309f79052782f28490ff3d7ca7bcbd591.jpg","createTime":"2018-09-07 15:10:20"}
 */
