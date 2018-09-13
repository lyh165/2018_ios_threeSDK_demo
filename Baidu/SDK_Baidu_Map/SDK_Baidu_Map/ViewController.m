//
//  ViewController.m
//  SDK_Baidu_Map
//
//  Created by lee on 2018/9/13.
//  Copyright © 2018年 lee. All rights reserved.
//

#import "ViewController.h"

/**
 @import的说法
 https://blog.csdn.net/zcmuczx/article/details/78308631
 
 原本我们之前导入头文件都是使用#import，这个就是和include的作用差不多就是相当于把头文件的内容复制过来，然后把本身的#import的头文件那句话给替换掉。但是#import比#include进步的一点就是能减少重复引用了，比如说你在A.h文件中#import C.h，B.h中也#import C.h，然后你在D.h文件中#import A.h #import B.h，是不会有关于C.h文件重复引用的问题的。具体的方法是通过#ifndef也就是条件编译来实现。
 
 在苹果没有推出Modules的时候，我们如果写的程序比较复杂的话，我们#import了很多相同的头文件，这样会很麻烦，而且编译速度慢，所以苹果有一个pch文件可以帮助我们解决，但是放在pch的头文件，虽然提高编译速度，在整个工程中都能访问，这样终归不好。pch文件其实就是采用了预编译处理，当在Build Setting中的Precompile Prefix Header为YES，把一些公用的头文件放入预编译头文件中预先进行编译，然后在真正编译工程时再将预先编译好的产物加入到所有还没编译的文件中去，以此来加快编译速度。
 
 一个完整的编译过程如下所示
 
 1.预处理（Pre-process）：把宏替换，删除注释，展开头文件，产生 .i 文件
 2.编译（Compliling）：把之前的 .i 文件转换成汇编语言，产生 .s文件
 3.汇编（Asembly）：把汇编语言文件转换为机器码文件，产生 .o 文件
 4.链接（Link）：对.o文件中的对于其他的库的引用的地方进行引用，生成最后的可执行文件（同时也包括多个 .o 文件进行 link）
 
 所以苹果推出了Modules，Modules相当于将框架进行了封装，然后加入在实际编译之时加入了一个用来存放已编译添加过的Modules列表。如果在编译的文件中引用到某个Modules的话，将首先在这个列表内查找，找到的话说明已经被加载过则直接使用已有的，如果没有找到，则把引用的头文件编译后加入到这个表中。这样被引用到的Modules只会被编译一次，而且在开发的时候也不存在整个工程都能去访问了。又可以提高编译速度。
 */
@import CoreLocation;
@import MapKit;

@interface ViewController ()



@property (nonatomic, strong) UIButton *btnSheet;
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnSheet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.btnSheet.frame = CGRectMake(0, 0, 100, 50);
    self.btnSheet.center = self.view.center;
    [self.btnSheet setTitle:@"show sheet" forState:UIControlStateNormal];
    [self.btnSheet addTarget:self action:@selector(actionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.btnSheet];
    
    
    self.urlScheme = @"demoURI://";
    self.appName = @"demoURI";
    //目标的经纬度(由后台返给我们)
    self.coordinate = CLLocationCoordinate2DMake(0,0);

}

#define BaiDuNavUrl @"baidumap://map/direction?origin=latlng:0,0|name:我的位置&destination=latlng:%@,%@|name:%@&mode=walking"
#define BaiDuGPSUrl @"baidumap://map/marker?location=%@,%@&title=我的位置&content=%@"



- (void)actionSheet
{
    __block NSString *urlScheme = self.urlScheme;
    __block NSString *appName = self.appName;
    __block CLLocationCoordinate2D coordinate = self.coordinate;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //这个判断其实是不需要的
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"苹果地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
            toLocation.name = @"银泰·海威国际";
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
        }];
        
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        /**
         参数说明 http://lbsyun.baidu.com/index.php?title=uri/api/ios
         每个协议都可以填写的通用参数，其中src是统计必选参数，格式为：ios.companyName.appName。不传此参数，不保证服务。
         参数名称    参数说明    是否必选    备注
         protocol    产品线协议头，例如baidumap表示百度地图    必选
         product    产品线名称，例如如百度地图客户端（map）    必选    product下可直接跟方法，当然产品线也可增加一个service级别
         service    具体功能服务名称，如POI检索服务（place）    必选
         action    方法名称，如POI检索中的详情检索（detail）    必选
         parameters    方法参数，参考各个功能协议说明的定义    必选
         coord_type    坐标类型，可选参数，默认为bd09ll。    可选    允许的值为bd09ll、gcj02、wgs84。bd09ll表示百度经纬度坐标， gcj02表示经过国测局坐标，wgs84表示gps获取的坐标。
         src    表示来源，用于统计    必选    必选参数，格式为：ios.companyName.appName 不传此参数，不保证服务
         */
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=中关村&destination=五道口&mode=driving&region=北京&src=ios.lyh.demo"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"%@",urlString);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        [alert addAction:action];
    }
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"谷歌地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSLog(@"%@",urlString);
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            
        }];
        
        [alert addAction:action];
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}





@end
