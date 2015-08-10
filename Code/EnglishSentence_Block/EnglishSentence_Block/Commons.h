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

//DB log
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


#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0   //NSFoundationVersionNumber
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0   //NSFoundationVersionNumber
#define IOS7OFFSET 20.0f

 

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

#pragma mark ---- AppDelegate
//AppDelegate
#define APPDELEGATE ((AppDelegate*)[UIApplication sharedApplication].delegate)

//UIApplication
#define APPD  [UIApplication sharedApplication]
#define rootNavVC (UINavigationController*)[[[[UIApplication sharedApplication] delegate] window] rootViewController]

#define isPad  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define isiPhone5 ([[UIScreen mainScreen]bounds].size.height == 568)

#pragma mark ---- String  functions
#define EMPTY_STRING        @""
#define STR(key)            NSLocalizedString(key, nil)

#pragma mark ---- UIImage  UIImageView  functions
#define IMG(name) [UIImage imageNamed:name]
#define IMGF(name) [UIImage imageNamedFixed:name]

#pragma mark ---- File  functions
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_OF_LIBRARY_SUPPORT    [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#pragma mark ---- color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define CLEARCOLOR  [UIColor clearColor]

#pragma mark ----Size ,X,Y, View ,Frame

#define WINDOWFRAME [[UIScreen mainScreen]bounds]

#define   IphoneFrame    CGRectMake(0, 20, 320, 460)
#define   IphoneRect    CGRectMake(0, 0, 320, 460)
#define   Iphone5Frame   CGRectMake(0, 20, 320, 548)
#define   Iphone5Rect   CGRectMake(0, 0.0, 320, 548)

//重新定义几个尺寸问题 2013－02－04
#define   RectIphone4Full    CGRectMake(0, 0, 320, 480) //full screen
#define   RectIphone4NoStatus    CGRectMake(0, 20, 320, 460)// without status bar

#define   RectIphone5Full    CGRectMake(0, 0, 320, 568)//ull screen
#define   RectIphone5NoStatus    CGRectMake(0, 20, 320, 548)//without status bar

#define   RectIphone5Full    CGRectMake(0, 0, 320, 568)//ull screen
#define   RectIphone5NoStatus    CGRectMake(0, 20, 320, 548)//without status bar



#define SCREEN_FRAME  [[UIScreen mainScreen]bounds]
//app frame rect without status bar
#define APP_FRAME [[UIScreen mainScreen]applicationFrame]

//get the  size of the Screen
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
 
#define APP_SCALE  ([[UIScreen mainScreen]applicationFrame].size.height/480.0)

#define APP_SCALE_W  ([[UIScreen mainScreen]applicationFrame].size.width/320.0)



//get the  size of the Application
//IOS8  has bug？
#define APP_HEIGHT [[UIScreen mainScreen]applicationFrame].size.height
#define APP_WIDTH [[UIScreen mainScreen]applicationFrame].size.width

//get the left top origin's x,y of a view
#define VIEW_TX(view) (view.frame.origin.x)
#define VIEW_TY(view) (view.frame.origin.y)

//get the width size of the view:width,height
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)

//get the right bottom origin's x,y of a view
#define VIEW_CX(view) (view.frame.origin.x + view.frame.size.width / 2.0f)
#define VIEW_CY(view) (view.frame.origin.y + view.frame.size.height / 2.0f )

//get the right bottom origin's x,y of a view
#define VIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define VIEW_BY(view) (view.frame.origin.y + view.frame.size.height )

//get the x,y of the frame
#define FRAME_TX(frame)  (frame.origin.x)
#define FRAME_TY(frame)  (frame.origin.y)
//get the size of the frame
#define FRAME_W(frame)  (frame.size.width)
#define FRAME_H(frame)  (frame.size.height)

#define DistanceFloat(PointA,PointB) sqrtf((PointA.x - PointB.x) * (PointA.x - PointB.x) + (PointA.y - PointB.y) * (PointA.y - PointB.y))
#define DAY_SEC  (3600 * 24 * 1000) //一天的毫秒
