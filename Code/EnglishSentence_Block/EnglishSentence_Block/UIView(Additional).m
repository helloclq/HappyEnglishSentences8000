//
// UIView (Additional).m
//  EnglishSentence_Block
//
//  Created by liqun on 12-12-28.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//
#import "UIView(Additional).h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Additional)

-(void)animateEnlargeFromCenterWithDelegate:(id)delegate andDuration:(float)duration
{
    self.layer.masksToBounds = YES;
    CABasicAnimation* enlargeFromCenterAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    enlargeFromCenterAnimation.delegate = delegate;
    enlargeFromCenterAnimation.fromValue = [NSNumber numberWithFloat:600];
    enlargeFromCenterAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    enlargeFromCenterAnimation.duration = duration;
    //    enlargeFromCenterAnimation.fillMode  = kCAFillModeForwards;
    //    enlargeFromCenterAnimation.removedOnCompletion= NO;
    [self.layer addAnimation:enlargeFromCenterAnimation forKey:@"enlargeFromCenterAnimation"];
}

-(void)animateNone
{
    //do nothing
}

-(void)animateCurlUpWithDelegate:(id)delegate andDuration:(float)duration
{
	[UIView beginAnimations:@"curlUp" context:nil];
	[UIView setAnimationDelegate:delegate];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:self cache:YES];
	[UIView commitAnimations];
}

-(void)animateCurlDownWithDelegate:(id)delegate andDuration:(float)duration
{
	[UIView beginAnimations:@"curlDown" context:nil];
	[UIView setAnimationDelegate:delegate];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationTransition: UIViewAnimationTransitionCurlDown forView:self cache:YES];
	[UIView commitAnimations];
}


-(void)animateFlipFromLeftWithDelegate:(id)delegate andDuration:(float)duration
{
	[UIView beginAnimations:@"flipFromLeft" context:nil];
	[UIView setAnimationDelegate:delegate];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
	[UIView commitAnimations];
}

-(void)animateFlipFromRightWithDelegate:(id)delegate andDuration:(float)duration
{
	[UIView beginAnimations:@"flipFromRight" context:nil];
	[UIView setAnimationDelegate:delegate];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
	[UIView commitAnimations];
}

-(void)animateRevealFromLeftWithDelegate:(id)delegate andDuration:(float)duration
{
	CATransition *animation = [CATransition animation];
	animation.delegate = delegate;
	animation.duration = duration;
	animation.type = kCATransitionReveal;
	animation.subtype = kCATransitionFromLeft;
	[self.layer addAnimation:animation forKey:@"revealFromLeft"];
}

-(void)animateRevealFromRightWithDelegate:(id)delegate andDuration:(float)duration
{
	CATransition *animation = [CATransition animation];
	animation.delegate = delegate;
	animation.duration = duration;
	animation.type = kCATransitionReveal;
	animation.subtype = kCATransitionFromRight;
	[self.layer addAnimation:animation forKey:@"revealFromRight"];
}

-(void)animateRevealFromBottomWithDelegate:(id)delegate andDuration:(float)duration
{
    CATransition *animation = [CATransition animation];
    animation.delegate = delegate;
    animation.duration = duration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromBottom;
	[self.layer addAnimation:animation forKey:@"revealFromBottom"];
}

-(void)animateRevealFromTopWithDelegate:(id)delegate andDuration:(float)duration
{
    CATransition *animation = [CATransition animation];
    animation.delegate = delegate;
    animation.duration = duration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromTop;
	[self.layer addAnimation:animation forKey:@"revealFromTop"];
}

-(void)animatePushFromRightWithDelegate:(id)delegate andDuration:(float)duration
{
	CATransition *animation = [CATransition animation];
	animation.delegate = delegate;
	animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
	[self.layer addAnimation:animation forKey:@"pushFromRight"];
}

-(void)animatePushFromLeftWithDelegate:(id)delegate andDuration:(float)duration
{
	CATransition *animation = [CATransition animation];
	animation.delegate = delegate;
	animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromLeft;
	[self.layer addAnimation:animation forKey:@"pushFromLeft"];
}

-(void)animateMoveInFromTopWithDelegate:(id)delegate andDuration:(float)duration
{
    CATransition *animation = [CATransition animation];
    animation.delegate = delegate;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromBottom;
	[self.layer addAnimation:animation forKey:@"moveInFromTop"];
}

-(void)animateMoveInFromBottomWithDelegate:(id)delegate andDuration:(float)duration
{
    CATransition *animation = [CATransition animation];
    animation.delegate = delegate;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromTop;
	[self.layer addAnimation:animation forKey:@"moveInFromBottom"];
}

-(void)animateMoveInFromLeftWithDelegate:(id)delegate andDuration:(float)duration
{
    CATransition *animation = [CATransition animation];
    animation.delegate = delegate;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromLeft;
	[self.layer addAnimation:animation forKey:@"moveInFromLeft"];
}

-(void)animateMoveInFromRightWithDelegate:(id)delegate andDuration:(float)duration
{
    CATransition *animation = [CATransition animation];
    animation.delegate = delegate;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
	[self.layer addAnimation:animation forKey:@"moveInFromRight"];
}

@end
