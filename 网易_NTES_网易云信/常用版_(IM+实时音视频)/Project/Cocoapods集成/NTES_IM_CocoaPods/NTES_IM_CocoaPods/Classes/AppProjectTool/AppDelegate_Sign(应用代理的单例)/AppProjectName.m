#import "AppProjectName.h"
#import "AppDelegate.h" // 用于获取appDelegate对象
//#import "LYH_H5WebAppViewController.h" // Hbuilder框架的控制器




// 类扩展
@interface AppProjectName ()
@property (strong,nonatomic) AppDelegate *appDelegate;
@end

@implementation AppProjectName
// 单例对象
+ (AppProjectName *)getInstance{
    static AppProjectName *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// 初始化的时候调用
- (id)init{
    if (self = [super init]) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.appDelegate = appDelegate;
        NSLog(@"初始化h5");
        [self lyh_initWithAdd_H5App2Window];
        [self lyh_initWithH5_PDRCore];
        NSLog(@"初始化h5,如果出现黑屏需要在AppDelegate需要设置\n [PDRCore initEngineWihtOptions:launchOptions withRunMode:PDRCoreRunModeAppClient];");
        
    }
    return self;
}

#pragma mark - 初始化 Hubuilder框架的代码 start
/**
 1.创建window并且将h5App添加到window里面
 */
- (void)lyh_initWithAdd_H5App2Window
{
    /*
    self.appDelegate.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LYH_H5WebAppViewController *vc = [[LYH_H5WebAppViewController alloc]init];
    self.appDelegate.nav = [[UINavigationController alloc]
                            initWithRootViewController:vc];
    self.appDelegate.window.rootViewController = self.appDelegate.nav;
    [self.appDelegate.window makeKeyAndVisible];
     */
    
}
- (void)lyh_initWithH5_PDRCore
{
    // 初始化插件
    /**
     需要初始化插件,否则会出现黑屏状况
     */
    /*
    PDRCore* core = [PDRCore Instance];
    NSError *error = nil;
    NSString *JSPath = [[NSBundle mainBundle] pathForResource:@"Pandora/apps/HGDQtest/www/js/AppDelegate" ofType:@"js"];
    NSLog(@"%@",JSPath);
    NSString *logPluginJS = [NSString stringWithContentsOfFile:JSPath
                                                      encoding:NSUTF8StringEncoding
                                                         error:&error];
    [core regPluginWithName:@"HGDQPlugin" impClassName:@"HGDQPlugin" type:PDRExendPluginTypeFrame javaScript:logPluginJS];
     */
    // 设置当前SDK运行模式
    // 设置当前SDK运行模式
    // 使用WebApp集成是使用的启动参数
}
#pragma mark  初始化 Hubuilder框架的代码 end

@end
