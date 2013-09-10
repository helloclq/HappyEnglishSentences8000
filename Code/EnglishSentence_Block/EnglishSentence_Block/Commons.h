//
//  Commons.h
//  IphoneFileDemo
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//


#ifdef DEBUG

#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#endif

#ifdef	DEBUG
#define	DNSLog(...);	NSLog(__VA_ARGS__);
#define DNSLogMethod	NSLog(@"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd));
#define DNSLogPoint(p)	NSLog(@"%f,%f", p.x, p.y);
#define DNSLogSize(p)	NSLog(@"%f,%f", p.width, p.height);
#define DNSLogRect(p)	NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);

CFAbsoluteTime startTime;
#define D_START			startTime=CFAbsoluteTimeGetCurrent();
#define D_END			DNSLog(@"[%s] %@ %f seconds", class_getName([self class]), NSStringFromSelector(_cmd), CFAbsoluteTimeGetCurrent() - startTime );
#else
#define DNSLog(...);	// NSLog(__VA_ARGS__);
#define DNSLogMethod	// NSLog(@"[%s] %@", class_getName([self class]), NSStringFromSelector(_cmd) );
#define DNSLogPoint(p)	// NSLog(@"%f,%f", p.x, p.y);
#define DNSLogSize(p)	// NSLog(@"%f,%f", p.width, p.height);
#define DNSLogRect(p)	// NSLog(@"%f,%f %f,%f", p.origin.x, p.origin.y, p.size.width, p.size.height);

#define D_START			// CFAbsoluteTime startTime=CFAbsoluteTimeGetCurrent();
#define D_END			// DNSLog(@"New %f seconds", CFAbsoluteTimeGetCurrent() - startTime );
#endif

#define SAFE_FREE(p) { if(p) { free(p); (p)=NULL; } }

#define DDLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define DDLog(FORMAT, ...) 
#endif

//程礼群的log ,数据库的log
#ifdef DBLOGOPEN
    #define BLOCK_DBLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
    #define  BLOCK_DBLog(FORMAT, ...) nil
#endif

#ifdef DEBUG_CLQ
#define CCLog DDDLog
#else
#define CCLog
#endif



#define WINDOWFRAME [[UIScreen mainScreen]bounds]

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define   IphoneFrame    CGRectMake(0, 20, 320, 460)
#define   IphoneRect    CGRectMake(0, 0, 320, 460)
#define   Iphone5Frame   CGRectMake(0, 20, 320, 548)
#define   Iphone5Rect   CGRectMake(0, 0.0, 320, 548)


//重新定义几个尺寸问题 2013－02－04
#define   RectIphone4Full    CGRectMake(0, 0, 320, 480) //全屏幕
#define   RectIphone4NoStatus    CGRectMake(0, 20, 320, 460)// 不带状态栏
#define   RectIphone5Full    CGRectMake(0, 0, 320, 568)//全屏幕
#define   RectIphone5NoStatus    CGRectMake(0, 20, 320, 548)// 不带状态栏


#define IMG(name) [UIImage imageNamedFixed:name]

#define BARBUTTON(TITLE,SELECTOR)  [[UIBarButtonItem alloc]initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

#define EMPTY_STRING        @""

#define STR(key)            NSLocalizedString(key, nil)

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

// 系统的AppDelegate
#define APPDELEGATE ((AppDelegate*)[UIApplication sharedApplication].delegate)
//系统的UIApplication
#define APPD  [UIApplication sharedApplication]

#define rootNavVC (UINavigationController*)[[[[UIApplication sharedApplication] delegate] window] rootViewController]

#pragma mark - color functions

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define HEIGHT_SCALE  ([[UIScreen mainScreen]bounds].size.height/480.0)



#define APP_HEIGHT [[UIScreen mainScreen]applicationFrame].size.height
#define APP_WIDTH [[UIScreen mainScreen]applicationFrame].size.width
#define APP_SCALE  ([[UIScreen mainScreen]applicationFrame].size.height/480.0)

#define APP_SCALE_W  ([[UIScreen mainScreen]applicationFrame].size.width/320.0)

//view左上角的x ，y
#define VIEW_X(view) (view.frame.origin.x)
#define VIEW_Y(view) (view.frame.origin.y)
//view的宽高
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)
//求一个view的右下角的x,y
#define VIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define VIEW_BY(view) (view.frame.origin.y + view.frame.size.height )

#define FRAME_X(frame)  (frame.origin.x)
#define FRAME_Y(frame)  (frame.origin.y)
#define FRAME_W(frame)  (frame.size.width)
#define FRAME_H(frame)  (frame.size.height)
