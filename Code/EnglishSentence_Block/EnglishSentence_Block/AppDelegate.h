//
//  BlockAppDelegate.h
//  EnglishSentence_Block
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDevice+Resolutions.h"

extern CGFloat    AppDisplayPxValue ;//one point value depend on hardware condition.

@class MBProgressHUD;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) MBProgressHUD* progressDialog;

//Screen solution
@property (assign, nonatomic) UIDeviceResolution deviceResolution;

@property (assign, nonatomic)UIIphoneDeviceType deviceType;


/**
 *显示等待菊花对话框
 **/
-(void)showProgressDialog:(NSString*)msg;

/**
 *取消菊花等待对话框
 **/
-(void)dismissProgressDialog:(id)sender;

#pragma mark -
#pragma mark toast显示方法
/**
 *这对方法用来在window上显示Toast,隐藏toast,这两个方法在MyUtils工具类中用
 *@toast 要显示的内容
 **/
- (void)showToast:(NSString *)toast;
/**
 *隐藏toast框框
 **/
- (void)hideToast;

/**
 *缓存数据的函数
 **/
-(void)saveData:(id)value forKey:(NSString*)key;
-(id)getData:(NSString*)key;
-(void)clearValueForKey:(NSString*)key;

@end
