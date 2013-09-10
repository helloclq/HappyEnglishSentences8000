//
//  MyUtils.m
//  Rrd_IB
//
//  Created by Xu Bohui on 7/8/12.
//  Copyright (c) 2012 blockcheng. All rights reserved.
//

#import "MyUtils.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@implementation MyUtils


+(void)setNavigationBarBackBGForTarget:(UIViewController *)target
{
    if ([target.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [target.navigationController.navigationBar setBackgroundImage:[UIImage imageNamedFixed:IMG_NAV_BG] forBarMetrics:UIBarMetricsDefault];
    }
}


#pragma mark -
#pragma mark ProgressDialog
+(void)showProgressDialog
{

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate showProgressDialog:@"数据请求中....."];
}

+(void)dismissProgressDialog
{

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate dismissProgressDialog:nil];
}

/**
 *在指定的ViewController中显示等待框框
 **/
+(void)showWaitingAlertWithContent:(NSString *)content inViewController:(UIViewController *)controller {
    NSArray *subViews = [controller.view subviews];
    BOOL isShowingAlert = NO;
    for (UIView *view  in subViews) {
        if ([view isKindOfClass:[MBProgressHUD class]]) {
            isShowingAlert = YES;
            break;
        }
    }
    if (!isShowingAlert) {
        MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
        mb.removeFromSuperViewOnHide = YES;
        mb.labelText = content;
    }
}
/**
 *隐藏的ViewController中显示等待框框
 **/
+(void)hideCurrentWaitingAlertInViewController:(UIViewController *)controller {
    [MBProgressHUD hideHUDForView:controller.view animated:YES];
}
/**
 *开发中toast显示
 **/
+(void)functionDevelopingToast {
    [MyUtils showToast:@"火热开发中..." autoHideAfterDelay:2];
}


#pragma mark  -
#pragma mark  toast对话框
/**
 *隐藏toast框框
 **/
+(void) hideToast:(id)sender {
    UIView *view = (UIView *)sender;
    [MBProgressHUD hideHUDForView:view animated:YES];
}
/**
 *显示toast框框
 **/
+(void)showToast:(NSString *)toast autoHideAfterDelay:(NSTimeInterval )interval {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate showToast:toast];
    [self performSelector:@selector(privateHideToast) withObject:nil afterDelay:interval];
}

+ (void)privateHideToast {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate hideToast];
}

/**
 *判断是否是NSNumber类型
 **/
+(BOOL)isNumberData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        return YES;
    }else {
        return NO;
    }
}

+(BOOL)isNumberStr:(NSString *)ss
{
    BOOL isNumber = NO;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    
    
    
    if ([f numberFromString:ss])
        
    {
        
        isNumber = YES;
        
    }
    [f release];
    return isNumber;
}

/**
 *打印系统所有的字体
 **/
+(void)printSytemFont
{
    //显示系统中所有的字体
    
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    
    NSArray *fontNames;
    
    NSInteger indFamily, indFont;
    
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
        
    {
        
//        CCLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        
        fontNames = [[NSArray alloc] initWithArray: [UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        
        for (indFont=0; indFont<[fontNames count]; ++indFont)
            
        {
            
//            CCLog(@" Font name: %@", [fontNames objectAtIndex:indFont]);
            
        } 
        
        [fontNames release]; 
        
    }
    [familyNames release];
}
/**
 *显示提示对话框
 **/
+(void)showNoteAlert:(NSString *)alertContent {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:alertContent delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}


+ (UIImage *)getPicZoomImage:(UIImage *)image withW :(CGFloat)PicAfterZoomWidth withH:(CGFloat)PicAfterZoomHeight {
    
    UIImage *img = image;
    
    int h = img.size.height;
    int w = img.size.width;
    if(h <= PicAfterZoomWidth && w <= PicAfterZoomHeight)
    {
        return image;
    }
    else
    {
        float b = (float)PicAfterZoomWidth/w < (float)PicAfterZoomHeight/h ? (float)PicAfterZoomWidth/w : (float)PicAfterZoomHeight/h;
        CGSize itemSize = CGSizeMake(b*w, b*h);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, b*w, b*h);
        [img drawInRect:imageRect];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
    
}
@end
