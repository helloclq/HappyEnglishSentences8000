//
// UINavigationController (Additional).h
//  EnglishSentence_Block
//
//  Created by liqun on 12-12-28.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum{
    EnlargeFromCenter = 0,
    CurlUp,
    CurlDown,
    FlipFromLeft,
    FlipFromRight,
    RevealFromLeft,
    RevealFromRight,
    RevealFromBottom,
    RevealFromTop,
    PushFromRight,
    PushFromLeft,
    MoveInFromTop,
    MoveInFromBottom,
    MoveInFromLeft,
    MoveInFromRight
} TransitonStyle;

@interface UINavigationController (Additional)

-(void)pushViewController:(UIViewController *)viewController withTransitionStyle:(TransitonStyle)transitionStyle;
-(void)popViewControllerWithTransitionStyle:(TransitonStyle)transitionStyle;

-(void)pushViewController:(UIViewController *)viewController withTransitionStyle:(TransitonStyle)transitionStyle completion:(void(^)(void))completion;
-(void)popViewControllerWithTransitionStyle:(TransitonStyle)transitionStyle completion:(void(^)(void))completion;

@end
