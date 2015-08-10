//
//  UIDevice+Resolutions.m
//  TripPlus
//
//  Created by Jovia Inc. on 10/12/14.
//  Copyright (c) 2014 Block Cheng. All rights reserved.
//

#import "UIDevice+Resolutions.h"


@implementation UIDevice (Resolutions)

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 获取当前分辨率
 
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIDeviceResolution) currentResolution {
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
		if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
			([UIScreen mainScreen].scale == 2.0)) {
			CGSize result = [[UIScreen mainScreen] bounds].size;
			result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
			if (result.height <= 480.0f)
				return UIDevice_iPhoneStandardRes;
			return (result.height > 960 ? UIDevice_iPhoneTallerHiRes : UIDevice_iPhoneHiRes);
		} else {
			if ( CGRectGetWidth([UIScreen mainScreen].bounds) > 375.f) {
				// 6+
				return UIDevice_iPhoneTallerHiRes;
			} else  if ( CGRectGetWidth([UIScreen mainScreen].bounds) > 320.f) {
				// 6
				return UIDevice_iPhoneTallerHiRes;
			}else  if ( CGRectGetHeight([UIScreen mainScreen].bounds) > 480.f) {
				//5
				return UIDevice_iPhoneTallerHiRes;
			} else   if ( CGRectGetWidth([UIScreen mainScreen].bounds) == 320.f) {
				// Default.png
				// Default@2x.png
				return UIDevice_iPhoneHiRes;
			}
		}
		return UIDevice_iPhoneStandardRes;
	} else

	return (([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
				 ([UIScreen mainScreen].scale == 2.0)) ? UIDevice_iPadHiRes : UIDevice_iPadStandardRes);
}

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 当前是否运行在iPhone5端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone5{
	if ([self currentResolution] == UIDevice_iPhoneTallerHiRes) {
		return YES;
	}
	return NO;
}

/******************************************************************************
 函数名称 : + (UIIphoneDeviceType) isRunningOniPhone5
 函数描述 : 获取当前设备型号
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIIphoneDeviceType)currentIphoneDeviceType
{
	NSLog(@"width:%f", CGRectGetWidth([UIScreen mainScreen].bounds));
	NSLog(@"Height:%f", CGRectGetHeight([UIScreen mainScreen].bounds));
	if ( CGRectGetWidth([UIScreen mainScreen].bounds) > 375.f) {
		// 6+
		return UIDeviceType_iPhone_6plus;
	} else  if ( CGRectGetWidth([UIScreen mainScreen].bounds) > 320.f) {
		// 6
		return UIDeviceType_iPhone_6;
	}else  if ( CGRectGetHeight([UIScreen mainScreen].bounds) > 480.f) {
		//5
		return UIDeviceType_iPhone_5_5s;
	} else {
		// Default.png
		// Default@2x.png
		return UIDeviceType_iPhone_4_4s_3gs;
	}
}

/******************************************************************************
 函数名称 : + (BOOL)isRunningOniPhone
 函数描述 : 当前是否运行在iPhone端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone{
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

@end