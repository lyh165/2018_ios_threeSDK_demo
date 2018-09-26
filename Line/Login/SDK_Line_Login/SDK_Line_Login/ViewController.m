//
//  ViewController.m
//  SDK_Line_Login
//
//  Created by lee on 2018/9/26.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"
#import <LineSDK/LineSDK.h>

@interface ViewController ()<LineSDKLoginDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tv_content;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LineSDKLogin sharedInstance].delegate = self;
}

- (IBAction)LineLogin:(UIButton *)sender {
     [[LineSDKLogin sharedInstance] startLogin];
}
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



/**
 
 NLChannelGatewayErrorDomain errors (for example, NLChannelGatewayErrorDomain Error 102) can occur if there are incorrect or missing settings in the console.
 
 If your iOS application is getting this error, confirm the following items:
 
 The iOS bundle ID is registered in the “App settings” section of the console
 The iOS URL scheme is registered in the “App settings” section of the console
 The LINE account that you are using to log in with is registered in the “Roles” section of the console
 
 102错误
 
 查看line后台绑定的报名是否正确
 
 */
@end
