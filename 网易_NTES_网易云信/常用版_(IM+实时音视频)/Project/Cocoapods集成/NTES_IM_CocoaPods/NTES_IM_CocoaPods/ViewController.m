//
//  ViewController.m
//  NTES_IM_CocoaPods
//
//  Created by lee on 2018/11/1.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 转换成表情
    NSString *s = [@"\ue418" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *S1 = [s stringByRemovingPercentEncoding];
//    NSLog(@"s1 %@",S1);
    self.lb.text = S1;
    

    
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
