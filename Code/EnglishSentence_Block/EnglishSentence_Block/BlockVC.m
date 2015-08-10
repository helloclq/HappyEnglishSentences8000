//
//  BlockVC.m
//  EnglishSentence_Block
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "BlockVC.h"
#import "UIImage+DefaultImage.h"

@interface BlockVC ()

@end

@implementation BlockVC
//@synthesize navTitle = mTitle;
@synthesize mainRect;
@synthesize navigationView;
@synthesize titleLabel;

@synthesize leftNavBt;
@synthesize rightNavBt;
@synthesize leftControl;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        if (IOS7) {
            _topOffset = 20.0f;
        }else {
            _topOffset = 0.0f;
        }
        
        if (IOS7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)rc
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.view.frame = rc;
       
    }
    return self;
}


/**
 *处理标题栏左按钮的事件
 **/
-(void)handleLeft:(id)sender
{
    if ([self canBack] && self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [rootNavVC popViewControllerAnimated:YES];
      
    }
}

/**
 *处理标题栏右按钮的事件
 **/
-(void)handleRight:(id)sender
{
    
}


-(IBAction)handleEvent:(id)sender
{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    
    self.mainRect =  WINDOWFRAME;
    self.title = [self getNavTitle];
    if ([self useDefaultBg]) {
        UIImageView* bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, APP_HEIGHT)];
        bgView.image = [[UIImage defaultImage] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
        bgView.contentMode = UIViewContentModeScaleToFill;
        //bgView.center = self.view.center;
        [self.view addSubview:bgView];
        [bgView release];
    }
    
    [self.view setBackgroundColor:RGBCOLOR(88, 191, 193)];
    
    self.navigationController.navigationBarHidden = YES;
    
    //为通用导航栏的方法
    /**
     * v2.0版本，隐藏系统navigation导航栏，
     **/
    if ([self navigationBG]) {
        UIImageView* navigatonBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.topOffset, self.mainRect.size.width,NAVIGATION_HEIGHT)];
        navigatonBg.image = [UIImage imageFromColor:RGBCOLOR(88, 191, 193)];//IMG([self navigationBG]);
        navigatonBg.userInteractionEnabled = YES;
        self.navigationView = navigatonBg;
        [self.view addSubview:self.navigationView];
        [navigatonBg release];
        
        
        //标题栏下的绿线
        UILabel* titlebarLine = [[UILabel alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT - AppDisplayPxValue  , self.view.frame.size.width, AppDisplayPxValue)];
        titlebarLine.backgroundColor = RGBCOLOR(0xff, 0xff, 0xff);
        titlebarLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.navigationView addSubview:titlebarLine];
        [titlebarLine release];
    }
    
    if ([self LeftBtBG]) {
        
        
        UIControl* leftControlTmp = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 90, NAVIGATION_HEIGHT)];
        leftControlTmp.backgroundColor = [UIColor clearColor];
        self.leftControl = leftControlTmp;
        [leftControlTmp addTarget:self action:@selector(handleLeft:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationView addSubview:leftControlTmp];
        [leftControlTmp release];
        
        
        UIButton* backBt = [UIButton buttonWithType:UIButtonTypeCustom];
        backBt.frame = CGRectMake(10, (NAVIGATION_HEIGHT -48.5)/2.0f  , 60, 48.5);
        self.leftNavBt = backBt;
        //backBt.showsTouchWhenHighlighted = YES;
        
        [backBt setBackgroundImage:IMG([self LeftBtBG]) forState:UIControlStateNormal];
        [backBt addTarget:self action:@selector(handleLeft:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationView addSubview:backBt];
    }
    
    if ([self RightBtBG]) {
        UIButton* choseBt = [UIButton buttonWithType:UIButtonTypeCustom];
        choseBt.frame = CGRectMake(SCREEN_WIDTH - 60 -10, (NAVIGATION_HEIGHT -48.5)/2.0f  , 60, 48.5);
        self.rightNavBt = choseBt;
        choseBt.showsTouchWhenHighlighted = YES;
        [choseBt setBackgroundImage:IMG([self RightBtBG]) forState:UIControlStateNormal];
        [choseBt addTarget:self action:@selector(handleRight:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationView addSubview:choseBt];
        
        
    }
    
    if ([self getNavTitle]) {
        UILabel* titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, self.topOffset, 180, NAVIGATION_HEIGHT)];
        titleLb.font = FONT_BOLD(20);
        titleLb.textColor = [UIColor whiteColor];
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.text = [self getNavTitle];
        //[titleLb sizeToFit];
        titleLb.shadowColor = [UIColor blackColor];
        titleLb.shadowOffset = CGSizeMake(0, 0.3);
        titleLb.center = CGPointMake(self.navigationView.bounds.size.width/2.0f, self.navigationView.bounds.size.height/2.0f);
        self.titleLabel = titleLb;
        [titleLb release];
        
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self.navigationView addSubview:titleLabel];
    }
    
    
}



-(void)viewDidAppear:(BOOL)animated
{
    
    [self.view bringSubviewToFront:self.leftNavBt];
    [self.view bringSubviewToFront:self.rightNavBt];
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    
    self.rightNavBt = nil;
    self.leftNavBt = nil;
    
    self.titleLabel = nil;
    self.navigationView = nil;
    self.navTitle = nil;
    
    
    self.leftControl = nil;
     
    [super dealloc];
    
}
/**
 *返回标题
 **/
-(NSString*)getNavTitle
{
    return nil;
    
}

-(void)setNavTitle:(NSString *)navTitle
{
    if (_navTitle != navTitle) {
        [_navTitle release];
        _navTitle = [navTitle copy];
        self.titleLabel.text = _navTitle;
    }

}
-(NSString*)description;
{
    return @"BasicController";
}
/**
 *是否需要返回
 **/
-(BOOL)canBack
{
    return YES;
}
/**
 *获取代理
 **/
-(AppDelegate*)getApp
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 侧移菜单方法

- (void)setVisible:(BOOL)visible {
    self.view.hidden = !visible;
}


/**
 *返回UIViewController
 **/
-(id)getThis
{
    return self;
}

/**
 *缓存数据的函数
 **/
-(void)saveData:(id)value forKey:(NSString*)key
{
    [[self getApp] saveData:value forKey:key];
}
-(id)getData:(NSString*)key
{
    return [[self getApp] getData:key];
}

-(void)clearValueForKey:(NSString*)key{
    [[self getApp] clearValueForKey:key];
}

/********************** 分页逻辑 ************************************/
/**
 * 根据key，返回页面数
 */
-(NSInteger) getPageSize:(NSString*) key {
    if (![self getData:key]) {
        [self savePageSize:[NSNumber numberWithInt:1] forKey:key];
        return 1;
    }
    return [(NSNumber*)[self getData:key] intValue];
}

/**
 * 保存页面数，
 *
 * @param key
 *            该页面的键
 * @param obj
 *            该页面的值
 */
-(void) savePageSize:(id)obj forKey:key {
    [self saveData:obj forKey:key];
}

/**
 * 页面数值加一
 *
 * @param key
 *            该页面的键
 */
-(void)addPageSize:(NSString*)key {
    
    
    NSInteger old = [ self getPageSize:key];
    
    [[self getApp] saveData:[NSNumber numberWithInteger:(old + 1) ] forKey:key];
}

/**
 * 页面值重置
 *
 * @param key
 *            该页面的键
 */
-(void) resetPageSize:(NSString*) key {
    [self savePageSize:[NSNumber numberWithInt:1] forKey:key];
}

/**
 *页面1 进入 页面2
 *页面2 是 1的后代子页面，pop2是，默认加载页面1,该方法就是为页面2返回页面1时，页面1做准备的
 **/
-(void)backActionInit
{
    
}


/**
 *页面返回时的回调
 **/
-(void)onResume
{
    
}
/**
 *页面被压入后方的回调
 **/
-(void)onPause
{
    
}

#pragma mark -- ios6旋转


#pragma mark --
#pragma mark --v 2.0
/**
 * 返回系统的导航栏背景
 **/
-(NSString*)navigationBG
{
    return  nil;
    
}

/**
 * 返回系统的导航栏左按钮背景
 **/
-(NSString*)LeftBtBG
{
    return nil;
}
/**
 * 返回系统的导航栏右按钮背景
 **/
-(NSString*)RightBtBG
{
    return nil;
}

/**
 *是否用默认背景图片
 **/
-(BOOL)useDefaultBg
{
    return  NO;
}
@end
