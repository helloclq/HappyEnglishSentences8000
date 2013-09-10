//
//  SideBarButtonController2.m
//  BasicLib
//
//  Created by liqun on 12-12-3.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "BasicSideVC.h"
#define kTriggerOffSet  100.0f

#define TIME_NAVI_ANIMATION 0.8f

@interface BasicSideVC ()



@end

@implementation BasicSideVC

- (void)dealloc
{
    DDLog(@"dealloc----se");
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.canBack = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)handleLeft:(id)btn
{
    if (self.view.center.x < APP_WIDTH/2.0 + 100.0) {
        
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint nextCenterPoint;
            nextCenterPoint.x = APP_WIDTH/2.0 + SLIDINGMENU_WIDTH;
            nextCenterPoint.y = self.view.center.y;
            [self.view setCenter:nextCenterPoint];
        }];
        
        if (self.sliderDelegate) {
            [self.sliderDelegate moveToRight:YES];
        }
        
    }else{
        
        if (self.sliderDelegate) {
            [self.sliderDelegate moveToRight:NO];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint nextCenterPoint;
            nextCenterPoint.x = APP_WIDTH/2.0;
            nextCenterPoint.y = self.view.center.y;
            [self.view setCenter:nextCenterPoint];
        }];
       
    }
    
}

-(void)naviButtonAnimateFirst
{    
    [self.leftNavBt animateFlipFromRightWithDelegate:self andDuration:TIME_NAVI_ANIMATION];
    

    [self.leftNavBt setBackgroundImage:[UIImage imageNamedFixed:@"Nav_menu_loading@2x.png"] forState:UIControlStateNormal];//换成黑色的图就行
    
}

-(void)naviButtonAnimateEnd
{
    [self.leftNavBt animateFlipFromLeftWithDelegate:self andDuration:TIME_NAVI_ANIMATION];
    
 
    [self.leftNavBt setBackgroundImage:[UIImage imageNamedFixed:@"Nav_menu.png"] forState:UIControlStateNormal];
}

/**
 * 返回系统的导航栏左按钮背景
 **/
-(NSString*)LeftBtBG
{
    return @"Nav_menu.png";
}
/**
 * 返回系统的导航栏右按钮背景
 **/
-(NSString*)RightBtBG
{
    return nil;
}

@end
