//
//  BlockAppDelegate.m
//  EnglishSentence_Block
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "AppDelegate.h"

#import "SplashVC.h"
#import "DBManager.h"

#import "MBProgressHUD.h"


@interface AppDelegate()

//应用数据缓存，用于小数据存储
@property (retain, nonatomic)NSMutableDictionary* appCache;

@end

@implementation AppDelegate



- (void)dealloc
{
    [_window release];
    [_appCache release];
    self.progressDialog = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
   
    SplashVC *splashVC = [[SplashVC alloc]init];
    
    UINavigationController* navRoot = [[UINavigationController alloc] initWithRootViewController:splashVC];
    [splashVC release];
    self.window.rootViewController = navRoot;
    [navRoot release];
    [self.window makeKeyAndVisible];
    
    
    [[DBManager getInstance]openDataBase];

    NSMutableDictionary* tmpMD = [[NSMutableDictionary alloc] initWithCapacity:10];
    self.appCache = tmpMD;
    [tmpMD release];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[DBManager getInstance]closeDataBase];
}

#pragma mark -
#pragma mark   ProgressDialog
/**
 *显示等待菊花对话框
 **/
-(void)showProgressDialog:(NSString*)msg
{
    @synchronized(self.progressDialog){
        
        if (_progressDialog == nil) {
            _progressDialog = [[MBProgressHUD alloc] initWithWindow:self.window];
            _progressDialog.labelText = msg;
            _progressDialog.removeFromSuperViewOnHide = YES;
        }
        _progressDialog.labelText = msg;
        [self.window addSubview:_progressDialog];
        [_progressDialog show:YES];
    }
    
}
/**
 *取消等待菊花对话框
 **/
-(void)dismissProgressDialog:(id)sender
{
    @synchronized(self.progressDialog){
        
        [self.progressDialog hide:YES];
    }
    
}
#pragma mark -
#pragma mark toast显示方法
/**
 *这对方法用来在window上显示Toast,隐藏toast,这两个方法在MyUtils工具类中用
 *@toast 要显示的内容
 **/
- (void)showToast:(NSString *)toast
{
    MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    mb.removeFromSuperViewOnHide = YES;
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    lb.lineBreakMode = UILineBreakModeWordWrap;
    lb.numberOfLines = 0;
    lb.text = toast;
    lb.font = [UIFont systemFontOfSize:13];
    lb.textAlignment = UITextAlignmentCenter;
    lb.textColor = [UIColor whiteColor];
    lb.backgroundColor = [UIColor clearColor];
    mb.customView = lb;
    mb.animationType = MBProgressHUDAnimationFade;//MBProgressHUDAnimationZoom;
    [lb release];
    mb.mode = MBProgressHUDModeCustomView;
}
/**
 *隐藏toast框框
 **/
- (void)hideToast {
    [MBProgressHUD hideHUDForView:self.window animated:YES];
    
}
/**
 *缓存数据的函数
 **/
-(void)saveData:(id)value forKey:(NSString*)key
{
    [_appCache setValue:value forKey:key];
}
-(id)getData:(NSString*)key
{
    
    return [_appCache objectForKey:key];
}

-(void)clearValueForKey:(NSString*)key{
    [_appCache removeObjectForKey:key];
}

@end
