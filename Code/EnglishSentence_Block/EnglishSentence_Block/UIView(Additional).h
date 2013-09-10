//
// UIView (Additional).h
//  EnglishSentence_Block
//
//  Created by liqun on 12-12-28.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (Additional)

-(void)animateEnlargeFromCenterWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateNone;

-(void)animateCurlUpWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateCurlDownWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateFlipFromLeftWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateFlipFromRightWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateRevealFromLeftWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateRevealFromRightWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateRevealFromBottomWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateRevealFromTopWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animatePushFromRightWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animatePushFromLeftWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateMoveInFromTopWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateMoveInFromBottomWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateMoveInFromLeftWithDelegate:(id)delegate andDuration:(float)duration;
-(void)animateMoveInFromRightWithDelegate:(id)delegate andDuration:(float)duration;

@end
