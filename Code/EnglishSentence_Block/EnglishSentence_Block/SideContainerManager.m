//
//  MainMenuController.m
//  BasicLib
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "SideContainerManager.h"
#import "IndexVC.h"
#import "DBManager.h"
#import "BasicSideVC.h"
#import "SentenceEntity.h"
 

@interface SideContainerManager ()
{
    //手势层
    UIControl* gestureContrl;
    
    CGPoint moveStartPoint;
    
}
-(void)closeKeyboard;


@property (nonatomic,retain) BasicSideVC* contentVC;
@property (nonatomic,retain) UITextField* searchInput;
@end


@implementation SideContainerManager

//@synthesize titleTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _chapters = [[[DBManager getInstance]findAllChapter]retain];
        _chapter_sections = [[NSMutableDictionary alloc] initWithCapacity:8];
        NSMutableArray* sections = nil;
        SentenceEntity* se = nil;
        for (int i = 0; i < self.chapters.count; i++) {
            se = (SentenceEntity*)[self.chapters objectAtIndex:i];
            sections = [[DBManager getInstance] findSectionsByChapterId:se.sentenceId];
            NSLog(@"chapterId:%@",se.sentenceId);
            [self.chapter_sections setValue:sections forKey:se.sentenceId];
            
        }
        
    }
    return self;
}

- (void)dealloc
{
    [_chapter_sections release];
    [_chapters release];
    self.searchInput = nil;
    self.contentVC  = nil;
    
    self.selectedId = nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mainRect = [[UIScreen mainScreen]bounds];
    
    UIView *bgImgView = [[UIView alloc] init];
    bgImgView.backgroundColor = [UIColor colorWithPatternImage:IMG(IMG_MENU_BG)];
    bgImgView.frame = CGRectMake(0, 0, APP_WIDTH, self.mainRect.size.height);
    [self.view addSubview:bgImgView];
    [bgImgView release];

    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topOffset, SLIDINGMENU_WIDTH, 46)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"开心英语8000句";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0, 0.3);
    titleLabel.font = FONT_BOLD(22);
    [self.view addSubview:titleLabel];
    [titleLabel release];
    
    UIControl *searchCtr = [[UIControl alloc] initWithFrame:CGRectMake(0, self.topOffset, SLIDINGMENU_WIDTH, 46)];
    searchCtr.backgroundColor = RGBACOLOR(255, 0, 0, 0);
    searchCtr.hidden = YES;
    [self.view addSubview:searchCtr];
    
    
    UIImageView* searchBarBg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, SLIDINGMENU_WIDTH-10, 36)];
    searchBarBg.image = IMG(@"bg_search.png");
    searchBarBg.userInteractionEnabled = YES;
    [searchCtr addSubview:searchBarBg];
    [searchBarBg release];
    
    UIImageView* searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    searchIcon.image = IMG(@"searchBig.png");
    [searchCtr addSubview:searchIcon];
    [searchIcon release];
    
    
    UITextField* tmpsearchInput = [[UITextField alloc] initWithFrame:CGRectMake(30, 5, SLIDINGMENU_WIDTH-40, 30)];
    self.searchInput = tmpsearchInput;
    self.searchInput.userInteractionEnabled = YES;
    self.searchInput.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    [searchBarBg addSubview:self.searchInput];
    self.searchInput.placeholder = @"搜索\\Search";
    [tmpsearchInput release];
    
    [searchCtr release];
    
    
    UITableView* chapterTB = [[UITableView alloc] initWithFrame:CGRectMake(0, 46 + 5+ self.topOffset, SLIDINGMENU_WIDTH, APP_HEIGHT - 46 -10-74)];
    chapterTB.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    chapterTB.dataSource = self;
    chapterTB.delegate = self;
    chapterTB.tag = 10001;
    chapterTB.backgroundView = nil;
    chapterTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:chapterTB];
    [chapterTB release];
    
    
    
    
    UIButton* homeCtrl = [[UIButton alloc] initWithFrame:CGRectMake(10, APP_HEIGHT - 10-44, 44, 44)];
    [homeCtrl setBackgroundImage:IMG(@"home.png") forState:UIControlStateNormal];
    homeCtrl.tag = 1000;
    [homeCtrl addTarget:self action:@selector(handleEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeCtrl];
    [homeCtrl release];
    
    
    UIButton* favorCtrl = [[UIButton alloc] initWithFrame:CGRectMake(10+64+10, APP_HEIGHT - 10-44, 44, 44)];
    [favorCtrl setBackgroundImage:IMG(@"myfavor.png") forState:UIControlStateNormal];
    favorCtrl.hidden = YES;
    [self.view addSubview:favorCtrl];
    [favorCtrl release];
    
    UIButton* settingCtrl = [[UIButton alloc] initWithFrame:CGRectMake(10+64+10+64+10, APP_HEIGHT - 10-44, 44, 44)];
    [settingCtrl setBackgroundImage:IMG(@"about.png") forState:UIControlStateNormal];
    settingCtrl.tag = 10002;
    [settingCtrl addTarget:self action:@selector(handleEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:settingCtrl];
    [settingCtrl release];
    
    
    IndexVC * tmpcontentVC = [[IndexVC alloc] init];
    self.contentVC = tmpcontentVC;
    [tmpcontentVC release];
   
    self.contentVC.sliderDelegate = self;
    self.contentVC.view.frame = self.view.bounds;
    self.contentVC.view.layer.shadowPath =[UIBezierPath bezierPathWithRect:_contentVC.view.bounds].CGPath;
    self.contentVC.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.contentVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentVC.view.layer.shadowOpacity = 1;
    self.contentVC.view.layer.shadowRadius = 10;
    [self.view addSubview:self.contentVC.view];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(autoShowMenu) userInfo:nil repeats:NO];
    
    
    
    gestureContrl = [[UIControl alloc] initWithFrame:CGRectMake(0,NAVIGATION_HEIGHT, 60, self.view.frame.size.height- NAVIGATION_HEIGHT)];
    gestureContrl.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    [self.contentVC.view addSubview:gestureContrl];
    gestureContrl.userInteractionEnabled = YES;
    UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(handlePanGestures:)];
    //无论最大还是最小都只允许一个手指
    panGestureRecognizer.minimumNumberOfTouches = 1;
    panGestureRecognizer.maximumNumberOfTouches = 3;
    
    [gestureContrl addGestureRecognizer:panGestureRecognizer];
    //[self.view bringSubviewToFront:gestureContrl];
    
}



-(void)autoShowMenu
{
    [self.contentVC handleLeft:nil];
    
    self.selectedId = [NSIndexPath indexPathForRow:0 inSection:0];
     [(UITableView*)[self.view viewWithTag:10001] selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    

}
-(BasicSideVC *)replaceContentVCWithClassName:(NSString*)className withFrame:(CGRect)frame anim:(BOOL)anim
{
    
    if ([className isEqualToString:NSStringFromClass([self.contentVC class])]) {
        
    } else {
//        CCLog(@"replaceContentVCWithClassName");
        [self closeKeyboard];
        [self.contentVC.view removeFromSuperview];
        BasicSideVC *tmpVc = [NSClassFromString(className) new];
        self.contentVC = tmpVc;
        [tmpVc release];
        self.contentVC.sliderDelegate = self;
        self.contentVC.view.frame = frame;
        self.contentVC.view.layer.shadowPath =[UIBezierPath bezierPathWithRect:_contentVC.view.bounds].CGPath;
        self.contentVC.view.layer.shadowOffset = CGSizeMake(-10, 0);
        self.contentVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.contentVC.view.layer.shadowOpacity = 1;
        self.contentVC.view.layer.shadowRadius = 10;
        [self.view addSubview:self.contentVC.view];
        [self.contentVC.view addSubview:gestureContrl];
    
    }
    
  
    
    if (anim) {
        CGPoint nextCenter;
        nextCenter.x = APP_WIDTH/2.0;
        nextCenter.y = self.view.center.y;
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.contentVC.view setCenter:nextCenter];
        }];
    }
    
    
    
    return self.contentVC;
}

-(BasicSideVC *)replaceContentVCWithClassName:(NSString*)className withFrame:(CGRect)frame
{
    
    if ([className isEqualToString:NSStringFromClass([self.contentVC class])]) {
        return self.contentVC;
    }
    
//    CCLog(@"replaceContentVCWithClassName");
    [self closeKeyboard];
    [self.contentVC.view removeFromSuperview];
    BasicSideVC *tmpVc = [NSClassFromString(className) new];
    self.contentVC = tmpVc;
    [tmpVc release];
    self.contentVC.sliderDelegate = self;
    self.contentVC.view.frame = frame;
    self.contentVC.view.layer.shadowPath =[UIBezierPath bezierPathWithRect:_contentVC.view.bounds].CGPath;
    self.contentVC.view.layer.shadowOffset = CGSizeMake(-10, 0);
    self.contentVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentVC.view.layer.shadowOpacity = 1;
    self.contentVC.view.layer.shadowRadius = 10;
    [self.view addSubview:self.contentVC.view];
    
    
    [self.view bringSubviewToFront:gestureContrl];
    CGPoint nextCenter;
    nextCenter.x = APP_WIDTH/2.0;
    nextCenter.y = self.view.center.y;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentVC.view setCenter:nextCenter];
    }];
    
    
    return tmpVc;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];    
    self.titles = nil;
}

-(void)lightShark:(id)sender
{
   

}

-(void)lightStopShark:(id)sender
{
    

    
}

-(void)moveToRight:(BOOL)moveTORight
{
    [self closeKeyboard];


}
-(IBAction)handleEvent:(id)sender
{
    [super handleEvent:sender];
    [self closeKeyboard];
    
    UIButton* bt = (UIButton*)sender;
    switch (bt.tag) {
        case 1000:
            
            [rootNavVC popViewControllerWithTransitionStyle:CurlDown];
            
            break;
        case 10002:
            
            [self replaceContentVCWithClassName:@"AboutVC" withFrame:_contentVC.view.frame anim:YES];
            
            
            break;
        default:
            break;
    }
    
    
}

-(void)closeKeyboard
{
    [self.searchInput resignFirstResponder];
}


- (void) handlePanGestures:(UIPanGestureRecognizer*)paramSender{
    if (paramSender.state == UIGestureRecognizerStateBegan ) {
        moveStartPoint  =[paramSender locationInView:self.view];
        
    }
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed){
        //通过使用 locationInView 这个方法,来获取到手势的坐标
        CGPoint moveCurrentPoint = [paramSender locationInView:self.view];
        //if (location.x < 160) {
        NSLog(@"center.x=%f",_contentVC.view.center.x);
        _contentVC.view.center = CGPointMake(_contentVC.view.center.x + moveCurrentPoint.x - moveStartPoint.x, _contentVC.view.center.y);
       _contentVC.view.layer.masksToBounds = YES;
        moveStartPoint = moveCurrentPoint;
        //}
    }
    
    
    
    
    if (paramSender.state == UIGestureRecognizerStateEnded) {
        if (_contentVC.view.center.x > APP_WIDTH / 1.5) {
            float time  = fabs(_contentVC.view.center.x - APP_WIDTH/2.0 - SLIDINGMENU_WIDTH)/(APP_WIDTH*2.0);
            
            [UIView animateWithDuration:time animations:^{
                CGPoint nextCenterPoint;
                nextCenterPoint.x = APP_WIDTH/2.0 + SLIDINGMENU_WIDTH;
                nextCenterPoint.y = self.view.center.y;
                [_contentVC.view setCenter:nextCenterPoint];
                _contentVC.view.layer.masksToBounds = YES;
            }];
        } else {
            float time  = fabs(_contentVC.view.center.x - APP_WIDTH/2.0)/(APP_WIDTH *2.0);
            
            [UIView animateWithDuration:time animations:^{
                _contentVC.view.center = CGPointMake(APP_WIDTH/2.0, _contentVC.view.center.y);
                _contentVC.view.layer.masksToBounds = YES;
                
                
                
            }];
            
            
            
        }
    }
}

#pragma mark -
#pragma  mark --UITableView Datasource delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   SentenceEntity* se = (SentenceEntity*)[self.chapters objectAtIndex:section];
    NSMutableArray* sections = (NSMutableArray*)[self.chapter_sections objectForKey:se.sentenceId];
    
    return  sections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *mainTableViewTag = @"cn.block.sentence800.ios.chapter";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:mainTableViewTag];
    
    if (cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:mainTableViewTag] autorelease];
        UIImageView* cellBg = [[UIImageView alloc] initWithFrame:cell.frame];
        
        cellBg.image = IMG(@"bg_LeftMenu_cell_normal@2x.png");
        cell.backgroundView = cellBg;
        [cellBg release];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        [cell bringSubviewToFront:cell.textLabel];
        
    }
    

    
    SentenceEntity* seChapter = (SentenceEntity*)[self.chapters objectAtIndex:indexPath.section];
    
    NSMutableArray* sections = (NSMutableArray*)[self.chapter_sections objectForKey:seChapter.sentenceId];
    
    SentenceEntity* seSection = (SentenceEntity*)[sections objectAtIndex:indexPath.row];
    cell.textLabel.text = seSection.sentenceTitle;
    return cell;


}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return self.chapters.count;


}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return  ((SentenceEntity*)[self.chapters objectAtIndex:section]).sentenceTitle;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[[UIView alloc] init] autorelease];
    myView.backgroundColor = [UIColor colorWithPatternImage:IMG(IMG_MENU_BG)];//[UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:0.0];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SLIDINGMENU_WIDTH, 22)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.font = FONT_BOLD(16);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text=((SentenceEntity*)[self.chapters objectAtIndex:section]).sentenceTitle;
    [myView addSubview:titleLabel];
    [titleLabel release];
    return myView;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self closeKeyboard];
    
    IndexVC* indexvc = (IndexVC*)[self replaceContentVCWithClassName:@"IndexVC" withFrame:_contentVC.view.frame anim:NO];
    
    SentenceEntity* seChapter = (SentenceEntity*)[self.chapters objectAtIndex:indexPath.section];
    
    NSMutableArray* sections = (NSMutableArray*)[self.chapter_sections objectForKey:seChapter.sentenceId];
    
    SentenceEntity* seSection = (SentenceEntity*)[sections objectAtIndex:indexPath.row];
     self.selectedId = indexPath;
    indexvc.sectionId = seSection.sentenceId;
    indexvc.navTitle = seSection.sentenceTitle;
    [self.contentVC  handleLeft:nil];
    
    
    
}

#pragma mark -
#pragma  mark --UITableView delegate methods


@end
