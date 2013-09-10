//
//  StringUtils.m
//  IphoneFileDemo
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "StringUtils.h"
#import "RegexKitLite.h"
#import <CommonCrypto/CommonDigest.h> 

@implementation StringUtils

/**
 * 从url中提取文件文字，取最后一个反斜杠之后的字符串
 **/
+(NSString *)getResourceNameWithURL:(NSString *)url {
    NSRange rang = [url rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *fileName = [url substringFromIndex:rang.location+rang.length];
    return fileName;
}

/**
 *判断一个字符串是否合法
 **/
+(BOOL)isStringOk:(NSString *)str {
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }
    if (str != nil && [str length] >0 && ![str isEqualToString:@" "]) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark -
#pragma mark  String Methods
+(NSString *)md5_16WithStr:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}

+(NSString *)md5_32WithStr:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark -
#pragma mark  时间字符串格式化
/**
 *将NSNumber转为yyyy-MM-dd格式字符串
 **/
+(NSString *)DateStringFromNumber:(NSNumber *) number{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[number doubleValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	[formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *str = [formatter stringFromDate:date];
    [formatter release];
    return str;
}
/**
 *将NSNumber转为yyyy格式字符串
 **/
+(NSString *)yearStrFromDate:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	[formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *str = [formatter stringFromDate:date];
    [formatter release];
    return str;
}

/**
 *判断是否是一个字符串
 **/
+(Boolean)isEmail:(NSString*)mail
{
    if (![mail isMatchedByRegex: @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"]) {
        return NO;
    }
    return YES;
}

/**
 *获取指定日期的毫秒数
 **/
+(long long)getMilSecFromDate:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day
{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    [comp setMonth:month];
    [comp setDay:day];
    [comp setYear:year];
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *myDate1 = [myCal dateFromComponents:comp];
    [myCal release];
    [comp release];
    // NSTimeInterval返回的是double类型，输出会显示为10位整数加小数点加一些其他值
    // 如果想转成int型，必须转成long long型才够大。
    NSTimeInterval time = [myDate1 timeIntervalSince1970];
    
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
    

    return dTime;

}
@end
