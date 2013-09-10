//
//  FileUtils.h
//  IphoneFileDemo
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  APP_FILE_PATH @"block"
@interface FileUtils : NSObject



/**
 *获取应用沙盒缓存路径
 **/
+(NSString *)getCacheDir;

/**
 *获取沙盒根目录路径
 **/
+(NSString *)getDocumentPath ;
/**
 * 获取沙盒内放置应用资源的路径，
 * 如果不存，则创建
 * 目录文件夹命名在前面定义APP_FILE_PATH
 **/
+(NSString *)getBasicPath;
/**
 *获取应用沙盒缓存图片的路径，如果不存在，则创建
 **/
+(NSString *)getImageCacheDir;

/**
 *清理应用沙盒缓存
 **/
+(BOOL)clearCache;

/**
 * 从url中提取文件文字，取最后一个反斜杠之后的字符串
  *@prama    ---图片的url
 **/
+(NSString *)getResourceNameWithURL:(NSString *)url;

/**
 *根据Url，从应用沙盒中找到对应的图片返回
 *@prama    ---图片的url
 **/
+(UIImage *)getImageWithUrl:(NSString *)url;

/**
 *根据图片名字，从应用沙盒中找到对应的图片返回
 *@prama    ---图片的文件名
 **/
+(UIImage *)getImageWithName:(NSString *)fileName;

/**
 *缓存对应url下的图片数据
 *@prama  imgaData  --- 图片NSData数据
 *@prama  url    ---图片的url
 **/
+(void)cacheImage:(NSData *)imageData ForUrl:(NSString *)url;
/**
 *获取制定document下的文件名的文件路径
 **/
+(NSString*)dataFilePath:(NSString*)fileName;

/**
 *存储图片数据为 name的文件
 *@prama  imgaData  --- 图片NSData数据
 *@prama  name    --保存后的名字
 **/
+(void)cacheImage:(NSData *)imageData forName:(NSString *)name;


/**
 *遍历沙盒中所有的图片文件：个人指定的路径下
 **/
+(void)scanAllCacheImg;

/**
 *获取某一目录下某类文件的数组
 **/
+(NSArray *) getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath;

/**
 *获取文件大小，c方法
 **/
+(long long) fileSizeAtPath:(NSString*) filePath;
@end
