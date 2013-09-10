//
//  MyUtils.h
//  Rrd_IB
//
//  Created by Xu Bohui on 7/8/12.
//  Copyright (c) 2012 blockcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface MyUtils : NSObject

//改变UIViewController的navigationbar的返回按钮的背景
+(void)setNavigationBarBackBGForTarget:(UIViewController *)target;

#pragma mark -
#pragma mark ---等待滚动条----
+(void)showProgressDialog;

+(void)dismissProgressDialog;

/**
 *在指定的ViewController中显示等待框框
 **/
+(void)showWaitingAlertWithContent:(NSString *)content inViewController:(UIViewController *)controller ;
/**
 *隐藏的ViewController中显示等待框框
 **/
+(void)hideCurrentWaitingAlertInViewController:(UIViewController *)controller ;
/**
 *开发中toast显示
 **/
+(void)functionDevelopingToast;


#pragma mark  -
#pragma mark  toast对话框
/**
 *隐藏toast框框
 **/
+(void) hideToast:(id)sender ;
/**
 *显示toast框框
 **/
+(void)showToast:(NSString *)toast autoHideAfterDelay:(NSTimeInterval )interval ;
+ (void)privateHideToast ;
/**
 *判断是否是NSNumber类型
 **/
+(BOOL)isNumberData:(id)data;

+(BOOL)isNumberStr:(NSString*)ss;

/**
 *打印系统所有的字体
 **/
+(void)printSytemFont;
/**
 *显示提示对话框
 **/
+(void)showNoteAlert:(NSString *)alertContent;

/**
 *等比例缩放图片
 **/
+ (UIImage *)getPicZoomImage:(UIImage *)image withW :(CGFloat)PicAfterZoomWidth withH:(CGFloat)PicAfterZoomHeight;
@end
