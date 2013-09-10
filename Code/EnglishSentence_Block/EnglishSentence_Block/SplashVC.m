//
//  SplashVC.m
//  EnglishSentence_Block
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "SplashVC.h"
#import "DBManager.h"
#import "SideContainerManager.h"
@interface SplashVC ()
@property (nonatomic,retain) UILabel* tfAppNameEnglish;
@property (nonatomic,retain) UILabel* tfAppNameChinese;
@end

@implementation SplashVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //b4ebed
    
    UIControl* bottomBear = [[UIControl alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 293* APP_SCALE_W  ,SCREEN_WIDTH, 293* APP_SCALE_W)];
    bottomBear.backgroundColor = [UIColor clearColor];
    [bottomBear addTarget:self action:@selector(handleEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBear];
    [bottomBear release];
    
    
    UIImageView *bearImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, 293* APP_SCALE_W)];
    bearImg.image = IMG(@"bear_splash.png");
    bearImg.backgroundColor = [UIColor clearColor];
    [bottomBear addSubview:bearImg];
    [bearImg release];
    
    
    UIControl* titleCtr = [[UIControl alloc] initWithFrame:CGRectMake(0,VIEW_Y(bottomBear) -103 * APP_SCALE_W,SCREEN_WIDTH, 103 * APP_SCALE_W)];
    [titleCtr addTarget:self action:@selector(handleEvent:) forControlEvents:UIControlEventTouchUpInside];
    titleCtr.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleCtr];
    [titleCtr release];
    
    UIImageView *titleImg = [[UIImageView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH * 0.1,0,SCREEN_WIDTH, 103 * APP_SCALE_W)];
    titleImg.image = IMG(@"title_splash.png");
    titleImg.backgroundColor = [UIColor clearColor];
    [titleCtr addSubview:titleImg];
    [titleImg release];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleEvent:(id)sender {
    UIControl* bt = (UIControl*)sender;
    switch (bt.tag) {
    
        default:{
            SideContainerManager* sbm = [[SideContainerManager alloc] init];
            [self.navigationController pushViewController:sbm withTransitionStyle:CurlUp];
            [sbm release];
        }
            break;
    }
    
    
}

-(NSString*)navigationBG
{
    return  nil;//@"common_NavigationBG.png";
    
}

- (void)dealloc
{
    self.tfAppNameEnglish = nil;
    self.tfAppNameChinese = nil;
    [super dealloc];
}
@end
