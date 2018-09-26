# 2018_ios_threeSDK_demo
第三方sdk的demo

### Tencent
  Bugly(bugly检测)

1、官方文档 https://bugly.qq.com/v2/index
2、新建产品
3、获取app ID、app key
例如:2018年乐开公司产品。大龙抓娃娃
App ID f8e327ca5f
App Key 1c049a1a-2a79-443a-9416-04944a435874

4、iOS使用指南
cocoapod 
```
通过CocoaPods集成
在工程的Podfile里面添加以下代码：

pod 'Bugly'
保存并执行pod install,然后用后缀为.xcworkspace的文件打开工程。

注意:

命令行下执行pod search Bugly,如显示的Bugly版本不是最新的，则先执行pod repo update操作更新本地repo的内容

关于CocoaPods的更多信息请查看 CocoaPods官方网站。
```

手动集成
```
手动集成
下载 Bugly iOS SDK
拖拽Bugly.framework文件到Xcode工程内(请勾选Copy items if needed选项)
添加依赖库
SystemConfiguration.framework
Security.framework
libz.dylib 或 libz.tbd
libc++.dylib 或 libc++.tbd
初始化SDK
导入头文件
在工程的AppDelegate.m文件导入头文件

#import <Bugly/Bugly.h>

如果是Swift工程，请在对应bridging-header.h中导入

初始化Bugly
在工程AppDelegate.m的application:didFinishLaunchingWithOptions:方法中初始化：

Objective-C
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
[Bugly startWithAppId:@"此处替换为你的AppId"];
return YES;
}
Swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
Bugly.startWithAppId("此处替换为你的AppId")
return true
}

```
