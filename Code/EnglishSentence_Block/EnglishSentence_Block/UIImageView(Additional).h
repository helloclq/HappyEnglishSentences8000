//
// UIImageView (Additional).h
//  EnglishSentence_Block
//
//  Created by liqun on 12-12-28.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//
#import <UIKit/UIKit.h>

#define TIMER_STOP_NOTE @"timerStopNotification"

@interface UIImageView (Additional)

/*@brief 对UIImageView添加了一个动画的方法，传的是图片路径数组而非图片数组，可以极大程度上避免内存疯长、缩减动画延迟.内存管理用ARC.
 *@return 免返回值.
 *@parame imageNames:图片的名字数组;
 *@parame duration:动画总用时;
 *@parame handler:动画结束后的回调块函数.
 */
-(void)animateWithImageNames:(NSArray*)imageNames Duration:(float)duration FinishedHandler:(void (^)(UIImageView* imageView))handler;

/*@brief 波动动画:从中心淡出扩大到外面
 *@return ----
 *@parame undulateView:需要波动的视图
 *@parame interval:波动一次的用时
 *@parame scale:波动最大值时放大的倍数
 *@parame delay:延迟delay后开始波动
 */
-(void)undulateWithInterval:(float)interval AndScale:(float)scale AfterDelay:(float)delay;

@end
