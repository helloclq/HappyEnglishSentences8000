//
//  UIDevice+Resolutions.h
//  TripPlus
//
//  Created by Jovia Inc. on 10/12/14.
//  Copyright (c) 2014 Block Cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, UIDeviceResolution) {
	// iPhone 1,3,3GS 标准分辨率(320x480px)
	UIDevice_iPhoneStandardRes      = 1,
	// iPhone 4,4S 高清分辨率(640x960px)
	UIDevice_iPhoneHiRes            = 2,
	// iPhone 5 高清分辨率(640x1136px)
	UIDevice_iPhoneTallerHiRes      = 3,
	// iPad 1,2 标准分辨率(1024x768px)
	UIDevice_iPadStandardRes        = 4,
	// iPad 3 High Resolution(2048x1536px)
	UIDevice_iPadHiRes              = 5

};

typedef NS_ENUM(NSInteger, UIIphoneDeviceType) {
	// iPhone 4,4s, 960x640,3.5inch
	UIDeviceType_iPhone_4_4s_3gs      = 1,
	// iPhone 5,5s, 1136x640,4 inch
	UIDeviceType_iPhone_5_5s            = 2,
	// iPhone 6,1134x750 ,4.7 inch
	UIDeviceType_iPhone_6      = 3,
	// iPone6+,1920x1080
	UIDeviceType_iPhone_6plus        = 4,
	// iPad 1,2 标准分辨率(1024x768px)
	UIDeviceType_iPadStandardRes        = 5,
	// iPad 3 High Resolution(2048x1536px)
	UIDeviceType_iPadHiRes              = 6

};





@interface UIDevice (Resolutions){
	
}

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 获取当前分辨率
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIDeviceResolution) currentResolution;

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 当前是否运行在iPhone5端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone5;

/******************************************************************************
 函数名称 : + (UIIphoneDeviceType) isRunningOniPhone5
 函数描述 : 获取当前设备型号
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIIphoneDeviceType)currentIphoneDeviceType;


/******************************************************************************
 函数名称 : + (BOOL)isRunningOniPhone
 函数描述 : 当前是否运行在iPhone端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone;

@end
