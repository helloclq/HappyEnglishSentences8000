//
// UIImage (Additional).h
//  EnglishSentence_Block
//
//  Created by liqun on 12-12-28.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIImage (Additional)

//获取图像的一部分
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

//将一个指定的图形放大或缩小为指定的尺寸
- (UIImage*)scaleToSize:(CGSize)size;

//UIColor转UIImage
+ (UIImage *)imageFromColor:(UIColor *)color;

+(UIImage *)imageNamedFixed:(NSString *)name;

@end
