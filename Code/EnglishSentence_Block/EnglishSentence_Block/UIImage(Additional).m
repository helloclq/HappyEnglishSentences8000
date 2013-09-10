//
// UIImage (Additional).m
//  EnglishSentence_Block
//
//  Created by liqun on 12-12-28.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//
#import "UIImage(Additional).h"

@implementation UIImage (Additional)

+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

- (UIImage*)scaleToSize:(CGSize)size
{
    // 创建image绘图板的大小
    UIGraphicsBeginImageContext(size);
    
    //drawInRect是在当前绘图上下文里缩放绘制image到一个rect里
    //self指方法的调用者。
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中获取改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)imageNamedFixed:(NSString *)name
{
    NSString* imagePath = [[NSBundle mainBundle]pathForResource:name ofType:nil];
    UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
