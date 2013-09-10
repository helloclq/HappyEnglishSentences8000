//
//  FileUtils.m
//  IphoneFileDemo
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "FileUtils.h"
#import "sys/stat.h"

@implementation FileUtils

/**
 *找到给定的plist的路径
 *@fileName  给定的文件名称
 **/
+(NSString *)pathForFile:(NSString *)fileName {
    NSBundle *bundle = [NSBundle mainBundle];
    return    [bundle pathForResource:fileName ofType:@"plist"];
}
/**
 *获取应用沙盒缓存路径
 **/
+(NSString *)getCacheDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}
/**
 *获取沙盒根目录路径
 **/
+(NSString *)getDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths lastObject];
}
/**
 * 获取沙盒内放置应用资源的路径，
 * 如果不存，则创建
 * 目录文件夹命名在前面定义APP_FILE_PATH
 **/
+(NSString *)getBasicPath {
    NSString *basicDir = [[FileUtils getDocumentPath] stringByAppendingPathComponent:APP_FILE_PATH];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:basicDir]) {
        NSLog(@"文件root目录%@ 不存在", basicDir);
        NSError *err;
        BOOL ret = [manager createDirectoryAtPath:basicDir withIntermediateDirectories:YES attributes:nil error:&err];

        if (!ret) {
            NSLog(@"创建文件夹失败%@", err);
            return nil;
        }else {
            return basicDir;
        }
    }
    return basicDir;
}

/**
 *获取应用沙盒缓存图片的路径，如果不存在，则创建
 **/
+(NSString *)getImageCacheDir {
    NSString *imageCacheDir = [[FileUtils getCacheDir] stringByAppendingPathComponent:@"imageCache"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:imageCacheDir]) {
        NSLog(@"缓存文件夹%@ 不存在", imageCacheDir);
        NSError *err;
        BOOL ret = [manager createDirectoryAtPath:imageCacheDir withIntermediateDirectories:YES attributes:nil error:&err];

        if (!ret) {
            NSLog(@"创建文件夹失败%@", err);
            return nil;
        }else {
            return imageCacheDir;
        }
    }else {
        return imageCacheDir;
    }
}

/**
 *清理应用沙盒缓存
 **/
+(BOOL)clearCache{
	NSFileManager* fileManager = [NSFileManager defaultManager];
	NSError* error = nil;
	return [fileManager removeItemAtPath:[FileUtils getImageCacheDir] error:&error];
}
/**
 *根据Url，从应用沙盒中找到对应的图片返回
 **/
+(UIImage *)getImageWithUrl:(NSString *)url {
    NSString *fileName = [FileUtils getResourceNameWithURL:url];
    NSString *cachePath = [FileUtils getImageCacheDir];
    NSString *path = [cachePath stringByAppendingPathComponent:fileName];
    return [UIImage imageWithContentsOfFile:path];
}

/**
 *根据图片名字，从应用沙盒中找到对应的图片返回
 **/
+(UIImage *)getImageWithName:(NSString *)fileName {
    NSString *cachePath = [FileUtils getImageCacheDir];
    NSString *path = [cachePath stringByAppendingPathComponent:fileName];
    return [UIImage imageWithContentsOfFile:path];
}


/**
 * 从url中提取文件文字，取最后一个反斜杠之后的字符串
 *@prama  url  --要获取图片的url
 **/
+(NSString *)getResourceNameWithURL:(NSString *)url {
    NSRange rang = [url rangeOfString:@"//" options:NSBackwardsSearch];
    if (rang.length <= 0 ) {
        return @"";
    }
    
    NSString *fileName = [url substringFromIndex:rang.location+rang.length];
    return [fileName stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
}

/**
 *缓存对应url下的图片数据
 *@prama  imgaData  --- 图片NSData数据
 *@prama  url    ---图片的url
 **/
+(void)cacheImage:(NSData *)imageData ForUrl:(NSString *)url {
    NSString *fileName = [FileUtils getResourceNameWithURL:url];
    NSString *cachePath = [FileUtils getImageCacheDir];
    NSString *path = [cachePath stringByAppendingPathComponent:fileName];

    [imageData writeToFile:path atomically:YES];
}
/**
 *存储图片数据为 name的文件
 *@prama  imgaData  --- 图片NSData数据
 *@prama  name    --保存后的名字
 **/
+(void)cacheImage:(NSData *)imageData forName:(NSString *)fileName
{
    
    NSString *cachePath = [FileUtils getImageCacheDir];
    NSString *path = [cachePath stringByAppendingPathComponent:fileName];
    [imageData writeToFile:path atomically:YES];
}

/**
 *获取制定document下的文件名的文件路径
 **/
+(NSString*)dataFilePath:(NSString*)fileName
{
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docDr = [path objectAtIndex:0];
    return [docDr stringByAppendingPathComponent:fileName];
}

/**
 *遍历沙盒中所有的图片文件：个人指定的路径下
 **/
+(void)scanAllCacheImg
{
    
}

/**
 *获取某一目录下某类文件的数组
 **/
+(NSArray *) getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath
{
    
    NSArray *fileList = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil]pathsMatchingExtensions:[NSArray arrayWithObject:type]];    
    return fileList;
    
}

/**
 *获取文件大小，c方法
 **/
+(long long) fileSizeAtPath:(NSString*) filePath{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}

@end
