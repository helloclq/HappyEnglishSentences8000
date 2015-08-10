//
// UINavigationController (Additional).m
//  EnglishSentence_Block
//
//  Created by liqun on 12-12-28.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//
#import "UINavigationController(Additional).h"
#import "UIView(Additional).h"
#import <QuartzCore/QuartzCore.h>

#define appWindow [[[UIApplication sharedApplication]delegate]window]

static void (^_completion)(void);
static BOOL _actPoping;
static UIViewController* _appearingVC;

@implementation UINavigationController (Additional)

-(void)pushViewController:(UIViewController *)viewController withTransitionStyle:(TransitonStyle)transitionStyle completion:(void(^)(void))completion
{
    _completion = [completion copy];
    _actPoping = NO;
    _appearingVC = viewController;
    [self addAnimationsViaStyle:transitionStyle];
}

-(void)pushViewController:(UIViewController *)viewController withTransitionStyle:(TransitonStyle)transitionStyle
{
    [self pushViewController:viewController withTransitionStyle:transitionStyle completion:nil];
}

-(void)popViewControllerWithTransitionStyle:(TransitonStyle)transitionStyle completion:(void(^)(void))completion
{
    _completion = [completion copy];
    _actPoping = YES;
    NSInteger index = self.viewControllers.count - 2;
    if (index >= 0) {
        _appearingVC = [self.viewControllers objectAtIndex:index];
        [self addAnimationsViaStyle:transitionStyle];
    }
}

-(void)popViewControllerWithTransitionStyle:(TransitonStyle)transitionStyle
{
    [self popViewControllerWithTransitionStyle:transitionStyle completion:nil];
    
}

-(void)addAnimationsViaStyle:(TransitonStyle)transitionStyle
{
    if (_actPoping) {
        [self popViewControllerAnimated:NO];
    }else{
        [self pushViewController:_appearingVC animated:NO];
    }
    
    switch (transitionStyle) {
        case EnlargeFromCenter:
        {
            [appWindow animateEnlargeFromCenterWithDelegate:self andDuration:0.5f];
            break;
        }
        case CurlUp:
        {
            [appWindow animateCurlUpWithDelegate:self andDuration:0.5f];
            break;
        }
        case CurlDown:
        {
            [appWindow animateCurlDownWithDelegate:self andDuration:0.5f];
            break;
        }
        case FlipFromLeft:
        {
            [appWindow animateFlipFromLeftWithDelegate:self andDuration:0.5f];
            break;
        }
        case FlipFromRight:
        {
            [appWindow animateFlipFromRightWithDelegate:self andDuration:0.5f];
            break;
        }
        case RevealFromLeft:
        {
            [appWindow animateRevealFromLeftWithDelegate:self andDuration:0.5f];
            break;
        }
        case RevealFromRight:
        {
            [appWindow animateRevealFromRightWithDelegate:self andDuration:0.5f];
            break;
        }
        case RevealFromBottom:
        {
            [appWindow animateRevealFromBottomWithDelegate:self andDuration:0.5f];
            break;
        }
        case RevealFromTop:
        {
            [appWindow animateRevealFromTopWithDelegate:self andDuration:0.5f];
            break;
        }
        case PushFromRight:
        {
            [appWindow animatePushFromRightWithDelegate:self andDuration:0.5f];
            break;
        }
        case PushFromLeft:
        {
            [appWindow animatePushFromLeftWithDelegate:self andDuration:0.5f];
            break;
        }
        case MoveInFromTop:
        {
            [appWindow animateMoveInFromTopWithDelegate:self andDuration:0.5f];
            break;
        }
        case MoveInFromBottom:
        {
            [appWindow animateMoveInFromBottomWithDelegate:self andDuration:0.5f];
            break;
        }
        case MoveInFromLeft:
        {
            [appWindow animateMoveInFromLeftWithDelegate:self andDuration:0.5f];
            break;
        }
        case MoveInFromRight:
        {
            [appWindow animateMoveInFromRightWithDelegate:self andDuration:0.5f];
            break;
        }
        default:
            break;
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        if (_completion) {
            _completion();
        }
        
        [_completion release];
        //[_appearingVC release];
        _appearingVC = nil;
        _completion = nil;
    }else{
//        [NSException raise:@"animationError!" format:@"animationDidStop class error."];
    }
}

@end