//
//  StringUtils.h
//  IphoneFileDemo
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject
/**
 * 从url中提取文件文字，取最后一个反斜杠之后的字符串
 **/
+(NSString *)getResourceNameWithURL:(NSString *)url;
/**
 *判断一个字符串是否合法
 **/
+(BOOL)isStringOk:(NSString *)str;
+(NSString *)md5_16WithStr:(NSString *)str;
+(NSString *)md5_32WithStr:(NSString *)str;

#pragma mark -
#pragma mark  时间字符串格式化
/**
 *将NSNumber转为yyyy-MM-dd格式字符串
 **/
+(NSString *)DateStringFromNumber:(NSNumber *) number;
/**
 *将NSNumber转为yyyy格式字符串
 **/
+(NSString *)yearStrFromDate:(NSDate*)date ;

/**
 *判断是否是一个字符串
 **/
+(Boolean)isEmail:(NSString*)mail;
/**
 *获取指定日期的毫秒数
 **/
+(long long)getMilSecFromDate:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
@end
