//
// UIImageView (Additional).m
//  EnglishSentence_Block
//
//  Created by liqun on 12-12-28.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//
#import "UIImageView(Additional).h"

#define KEY_IMAGE_PATHS @"imagePaths"
#define KEY_HANDLER @"handler"

static NSTimer* timer;

@implementation UIImageView (Additional)

-(void)animateWithImageNames:(NSArray*)imageNames Duration:(float)duration FinishedHandler:(void (^)(UIImageView* imageView))handler
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(timerStopNoteAction:) name:TIMER_STOP_NOTE object:nil];
    int n = imageNames.count - 1;
    if (n > 0)
    {
        NSMutableArray* imagePaths = [NSMutableArray arrayWithCapacity:2];
        for (NSString* aImageName in imageNames) {
            NSString* aImagePath = [[NSBundle mainBundle]pathForResource:aImageName ofType:nil];
            [imagePaths addObject:aImagePath];
        }
        NSDictionary* userInfo = [[NSDictionary alloc]initWithObjectsAndKeys:imagePaths,KEY_IMAGE_PATHS,handler,KEY_HANDLER, nil];
        timer = [[NSTimer scheduledTimerWithTimeInterval:duration/n target:self selector:@selector(updateImage:) userInfo:userInfo repeats:YES]retain];
        [userInfo release];
    }
}

-(void)updateImage:(NSTimer*)timer
{
    NSArray* imagePaths = [[timer userInfo]objectForKey:KEY_IMAGE_PATHS];
    void (^handler)(UIImageView*) = [[timer userInfo]objectForKey:KEY_HANDLER];
    static int i = 0;
    if (i >= imagePaths.count)
    {
        i = 0;
        self.image = nil;
        handler(self);
        return;
    }
    self.image = [UIImage imageWithContentsOfFile:[imagePaths objectAtIndex:i++]];
}

-(void)timerStopNoteAction:(NSNotification*)note
{
    if ([timer isValid]) {
        [timer invalidate];
    }
    [timer release];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:TIMER_STOP_NOTE object:nil];
}

/////////////
-(void)undulateWithInterval:(float)interval AndScale:(float)scale AfterDelay:(float)delay;
{
    [UIView animateWithDuration:interval
                          delay:delay
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.transform = CGAffineTransformMakeScale(scale, scale);
                         self.alpha = 0.0f;
                     } completion:^(BOOL finished) {
                         if (finished) {
                             self.transform = CGAffineTransformIdentity;
                             self.alpha = 1.0f;
                         }
                         
                         else
                         {
                             //                [NSException raise:@"how to do?" format:@"animation error"];
                         }
                     }];
}

@end
