//
//  IndexVcViewController.m
//  EnglishSentence_Block
//
//  Created by liqun on 13-5-24.
//  Copyright (c) 2013年 blockcheng. All rights reserved.
//

#import "IndexVC.h"
#import "DBManager.h"
#import "SentenceEntity.h"
#import "EnglishSentenceItem.h"
#import "VolumeBar.h"
#import "MCSegmentedControl.h"
#import "SideContainerManager.h"

#define BOTTOM_COTROL_H 57

@interface IndexVC ()
{
    
    UITableView* sentenceTable;
    AVAudioPlayer* _audioPlayer;
    /**
     *是否用手滑动了视图，如果滑动了，5秒内，playerTimer的回调不能触发
     **/
    BOOL isScrolling;
    
    /**
     *设置弹出菜单
     **/
    SNPopupView* settingPopupView;
    UIView *settingContainer;
    
    
    UILabel* voiceLable;
    VolumeBar *bar;
    
    ShowStyle showStyle;
}

@property (nonatomic ,retain)NSMutableArray* section;
@property (nonatomic ,retain)NSMutableDictionary* sentences;
@property (nonatomic,retain)NSMutableArray* allSentence;

@property (nonatomic ,copy)NSString* audioRes;
@property (nonatomic ,retain)UIButton* playerBt;
@property (nonatomic ,retain)UIButton* nextBt;

@property (nonatomic ,retain)UIButton* preBt;
@property (nonatomic,retain)NSTimer* playerTimer;
@property (nonatomic,retain)NSTimer* stopTimer;


@property (nonatomic,assign)int sectionIndex;
@property (nonatomic,assign)int sentenceIndex;


//对SideContainerManager的引用，此处仅为一个章节播放完继续播后面的资源用
@property (nonatomic,assign)SideContainerManager* resource;

@end

@implementation IndexVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _sentences = [[NSMutableDictionary alloc] initWithCapacity:10];
        _allSentence = [[NSMutableArray arrayWithCapacity:10] retain];
        showStyle = Chinese_English;
    }
    return self;
}

//封装系统加载函数
-(void)loadMusic:(NSString*)name type:(NSString*)type
{
    if (_audioPlayer != nil) {
        
            [_audioPlayer stop];

        [_audioPlayer  release];
    }
    
    NSString* path= [[NSBundle mainBundle] pathForResource: [name stringByReplacingOccurrencesOfString:@".mp3" withString:@""] ofType:type];
    
    NSURL* url = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];;
    _audioPlayer.delegate=self;
    _audioPlayer.volume= 0.4;
    [_audioPlayer prepareToPlay];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [_audioPlayer play];
    [self.playerBt setBackgroundImage:IMG(@"pauseButton@2x.png") forState:UIControlStateNormal];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (_audioPlayer != nil) {
        if([_audioPlayer isPlaying])
        {
            [_audioPlayer stop];
        
        }
        
    }

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImageView* bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, SCREEN_WIDTH, APP_HEIGHT - NAVIGATION_HEIGHT)];
 
    bgView.backgroundColor = [UIColor clearColor];
    bgView.image = IMG(@"playerbg.png");
    bgView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bgView];
    [bgView release];
    
    
    
    
    sentenceTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, APP_WIDTH, APP_HEIGHT - NAVIGATION_HEIGHT - BOTTOM_COTROL_H ) style:UITableViewStylePlain];
    sentenceTable.layer.masksToBounds = NO;
    sentenceTable.dataSource = self;
    sentenceTable.delegate = self;
    sentenceTable.backgroundView = nil;
    sentenceTable.backgroundColor = RGBACOLOR(0, 0, 0, 0);
    sentenceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:sentenceTable];
    
  
    
    [self.view bringSubviewToFront:self.navigationView];
    
    
    
    self.playerBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playerBt.frame = CGRectMake((SCREEN_WIDTH - 33)/2.0, SCREEN_HEIGHT - BOTTOM_COTROL_H - (BOTTOM_COTROL_H - 36)/2.0, 33, 36);
    [self.playerBt setBackgroundImage:IMG(@"playButton@2x.png") forState:UIControlStateNormal];
    [self.playerBt addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playerBt];
    
    
    self.preBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.preBt.frame = CGRectMake(((SCREEN_WIDTH - 33)/2.0 - 22)/2.0, SCREEN_HEIGHT - BOTTOM_COTROL_H - (BOTTOM_COTROL_H - 44)/2.0, 22, 25);
    [self.preBt setBackgroundImage:IMG(@"PreviousButton@2x.png") forState:UIControlStateNormal];
    [self.preBt addTarget:self action:@selector(playPre:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.preBt];
    self.preBt.hidden = YES;
    
    self.nextBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBt.frame = CGRectMake(SCREEN_WIDTH/2.0 + SCREEN_WIDTH/4.0 - 11, SCREEN_HEIGHT - BOTTOM_COTROL_H - (BOTTOM_COTROL_H - 44)/2.0, 22, 25);
    [self.nextBt setBackgroundImage:IMG(@"NextButton@2x.png") forState:UIControlStateNormal];
    [self.nextBt addTarget:self action:@selector(playNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBt];
    self.nextBt.hidden = YES;
    
     [self setSectionId:@"1"];
    self.playerTimer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(playerUpdate:) userInfo:nil repeats:YES];
    
    isScrolling = NO;
    
    
    
    settingContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.7 , 250.0f)];
    settingContainer.backgroundColor = [UIColor colorWithRed:0xb4/255.0f green:0xeb/255.0f blue:0xed/255.0f alpha:0.8f];
    settingContainer.layer.cornerRadius = 3;
    settingContainer.layer.borderWidth = 0.0f;
    settingContainer.layer.borderColor = [[UIColor clearColor] CGColor];
    settingPopupView = [[SNPopupView alloc] initWithContentView:settingContainer contentSize:CGSizeMake(SCREEN_WIDTH * 0.7 , 250.0f)];
    
    
   
    bar = [[VolumeBar alloc] initWithFrame:CGRectMake(10, 10, 0, 0) minimumVolume:0 maximumVolume:10];
    bar.center = CGPointMake(settingContainer.center.x, bar.frame.size.height/2.0+10);
    [bar addTarget:self action:@selector(onVolumeBarChange:) forControlEvents:UIControlEventValueChanged];
    [settingContainer addSubview:bar];
    bar.currentVolume = 4;
    
    
    voiceLable = [[UILabel alloc] initWithFrame:CGRectMake(10, bar.frame.size.height+5, SCREEN_WIDTH * 0.5, 40)];
    voiceLable.backgroundColor = [UIColor clearColor];
    voiceLable.text = @"Volume: 4";
    voiceLable.font = FONT_BOLD(16);
    voiceLable.textAlignment = NSTextAlignmentCenter;
    voiceLable.shadowColor = [UIColor blackColor];
    voiceLable.textColor = [UIColor whiteColor];
    voiceLable.shadowOffset = CGSizeMake(0, 0.3);
    voiceLable.center = CGPointMake(settingContainer.center.x, voiceLable.center.y);
    [settingContainer addSubview:voiceLable];
   
    UILabel *staticModelTxtLable = [[UILabel alloc] initWithFrame:CGRectMake(10, bar.frame.size.height+5 + 30, SCREEN_WIDTH * 0.5, 40)];
    staticModelTxtLable.backgroundColor = [UIColor clearColor];
    staticModelTxtLable.text = @"显示风格:";
    staticModelTxtLable.font = FONT_BOLD(16);
    staticModelTxtLable.textAlignment = NSTextAlignmentLeft;
    staticModelTxtLable.shadowColor = [UIColor blackColor];
    staticModelTxtLable.textColor = [UIColor whiteColor];
    staticModelTxtLable.shadowOffset = CGSizeMake(0, 0.3);
   
    [settingContainer addSubview:staticModelTxtLable];
    
    
    NSArray *items = [NSArray arrayWithObjects:
					  @"中文",
					  @"中文+英文",
					  @"English",
					  nil];
	MCSegmentedControl *segmentedControl = [[MCSegmentedControl alloc] initWithItems:items];
	
	// set frame, add to view, set target and action for value change as usual
	segmentedControl.frame = CGRectMake(10.0f, bar.frame.size.height+5 + 65, settingContainer.frame.size.width - 20, 34.0f);
	[segmentedControl addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.font = FONT_BOLD(14);
	segmentedControl.selectedSegmentIndex = 1;
	
	// Set a tint color
	segmentedControl.tintColor = COLOR_MAIN_BG;
	
	// Customize font and items color
	segmentedControl.selectedItemColor   = [UIColor whiteColor];
	segmentedControl.unselectedItemColor = [UIColor darkGrayColor];
    
	[settingContainer addSubview:segmentedControl];
    
	[segmentedControl release];

    
    
    self.resource = (SideContainerManager*)(self.sliderDelegate);
}

#pragma mark - Event
- (void)onVolumeBarChange:(id)sender
{
    VolumeBar *tmpbar = sender;
    voiceLable.text = [NSString stringWithFormat:@"Volume: %d", tmpbar.currentVolume];
     _audioPlayer.volume= tmpbar.currentVolume * 0.1f;
    
}

- (void)segmentedControlDidChange:(id)sender
{
    MCSegmentedControl* mc = sender;
    if (mc.selectedSegmentIndex == 0) {
        showStyle = Chinese;
    }else  if (mc.selectedSegmentIndex == 1) {
        showStyle = Chinese_English;
    }else  if (mc.selectedSegmentIndex == 2) {
        showStyle = English;
    }
    
    //[self setSectionId:self.sectionId];
    [self.view setNeedsDisplay];
    
    [sentenceTable reloadData];
    
    [sentenceTable setScrollsToTop:YES];
    [sentenceTable setNeedsDisplay];
    

}


-(IBAction)play:(UIButton*)sender
{
    if (_audioPlayer != nil ) {
        if([_audioPlayer isPlaying])
        {
            [self.playerBt setBackgroundImage:IMG(@"playButton@2x.png") forState:UIControlStateNormal];
            [_audioPlayer pause];
            
        } else {
            [self.playerBt setBackgroundImage:IMG(@"pauseButton@2x.png") forState:UIControlStateNormal];
            [_audioPlayer play];
            
        }
    }


}


/**
 *
 **/
-(IBAction)playPre:(UIButton*)sender
{
    
    
}

/**
 *
 **/
-(IBAction)playNext:(UIButton*)sender
{
    
    
}


/**
 *
 **/
-(void)playerUpdate:(id)sender
{
    if (isScrolling) {
        return;
    }
    if (!(_audioPlayer!= nil && _audioPlayer.isPlaying)) {
        return;
    }
    
    int index = 0;
    int indexSection = 0;
    int indexSectionOld = 0;
    int nextIndex = 0;
    SentenceEntity* se;
    SentenceEntity* nextSe;
    
    for (index = 0,nextIndex = 1; nextIndex < self.allSentence.count; nextIndex ++,index ++) {
        nextSe = (SentenceEntity*)self.allSentence[nextIndex];
        se = (SentenceEntity*)self.allSentence[index];
        if (se.sentenceTime <= _audioPlayer.currentTime && nextSe.sentenceTime >= _audioPlayer.currentTime) {
            break;
        } else  if (se.type == 3){
            indexSection = index;
        }else  if (nextSe.type == 3){
            indexSection = nextIndex;
            if (nextSe.sentenceTime >= _audioPlayer.currentTime) {
                break;
            }
            
        } else if (se.sentenceTime > _audioPlayer.currentTime) {
            break;
        }
        indexSectionOld= indexSection;
        
    }
    
    int secitonId = -1;
    int sentenceId =  -1;
    
    if (indexSection >= index) {

        secitonId = [self.section indexOfObject:((SentenceEntity*)self.allSentence[indexSectionOld])];
        SentenceEntity* tmpSubSection = [self.section objectAtIndex:secitonId];
         NSMutableArray* tmpSentences = [self.sentences objectForKey:tmpSubSection.sentenceId];
        sentenceId = [tmpSentences indexOfObject:((SentenceEntity*)self.allSentence[index])];
    } else {

        secitonId = [self.section indexOfObject:((SentenceEntity*)self.allSentence[indexSection])];
        SentenceEntity* tmpSubSection = [self.section objectAtIndex:secitonId];
         NSMutableArray* tmpSentences = [self.sentences objectForKey:tmpSubSection.sentenceId];
        sentenceId = [tmpSentences indexOfObject:((SentenceEntity*)self.allSentence[index])];
    }
    
    if (secitonId != -1 && secitonId != NSNotFound) {
        
        self.sentenceIndex = sentenceId;
        self.sectionIndex = secitonId;
        [sentenceTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:sentenceId inSection:secitonId] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 * 返回系统的导航栏背景
 **/
-(NSString*)navigationBG
{
    return  @"common_NavigationBG@2x.png";//@"NavigationBG2@2x.png";
    
}

/**
 *返回标题
 **/
-(NSString*)getNavTitle
{
    return @"开心英语8000句";
    
}
/**
 *是否用默认背景图片
 **/
-(BOOL)useDefaultBg
{
    return  NO;
}


- (void)dealloc
{
    
    [self.playerTimer invalidate];
    self.playerTimer = nil;

    self.stopTimer = nil;
    
    if (_audioPlayer != nil) {
       
       if(_audioPlayer.playing)
       {
           
            [_audioPlayer stop];
       }
       
        [_audioPlayer  release];
   }
    [sentenceTable release];
    self.sectionId = nil;
    
    self.playerBt = nil;
    self.nextBt = nil;
    self.preBt = nil;
    
    
   
    self.sentences = nil;
    
    self.allSentence = nil;
    self.audioRes = nil;

    
    [settingPopupView release];
    [settingContainer release];
    
     [voiceLable release];
    [bar release];
    [super dealloc];
}

-(void)setSectionId:(NSString *)sid
{
    if (_sectionId != sid) {
        [_sectionId release];
        _sectionId = [sid copy];
        if (sid != nil) {
            NSLog(@"reload sectionid = %@",sid);
            self.section = [[DBManager getInstance] findSubSectionsBySectionId:_sectionId];
            [self.sentences removeAllObjects];
            [self.allSentence removeAllObjects];
            NSMutableArray* tmpsentences = nil;
            for (SentenceEntity *se in self.section) {
                tmpsentences = [[DBManager getInstance] findSentencesBySubSectionId:se.sentenceId];
                self.audioRes = ((SentenceEntity*)[tmpsentences objectAtIndex:0]).sentenceRes;
                [self.sentences setObject:tmpsentences forKey:se.sentenceId];
               
                
            }
            self.allSentence = [[DBManager getInstance] findSentencesBySectionId:_sectionId];
            
            NSComparator cmptr = ^(SentenceEntity* obj1, SentenceEntity* obj2){
                float time1= obj1.sentenceTime;
                float time2 =  obj2.sentenceTime;
                if ( time1 > time2) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                
                if (time1 < time2) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            };
            
            [self.allSentence sortUsingComparator:cmptr];
            self.audioRes  = self.audioRes;
            
            [self loadMusic:self.audioRes  type:@"mp3"];
            
            [sentenceTable reloadData];
        }
       
    }

}

-(void)handleLeft:(id)sender
{
    [settingPopupView dismiss:YES];
    [super handleLeft:sender];
    if (self.view.center.x >= 160.0 + 100.0) {
        
    }
   
    
}

-(void)handleRight:(id)sender
{
    CGPoint p = CGPointMake(((UIControl*)sender).frame.origin.x +((UIControl*)sender).frame.size.width/2.0, ((UIControl*)sender).frame.origin.y + ((UIControl*)sender).frame.size.height);
    [settingPopupView presentModalAtPoint:p inView:self.view animated:YES];
    [settingPopupView addTarget:self action:@selector(didTouchPopupView:)];
    [settingPopupView setDelegate:self];

}
-(void)didTouchPopupView:(id)sender{


}
- (void)didDismissModal:(SNPopupView*)popupview
{


}
#pragma mark -
#pragma  mark --UITableView Datasource delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sct
{
    SentenceEntity* tmpSe = [self.section objectAtIndex:sct];
    NSMutableArray* tmpSentences = [self.sentences objectForKey:tmpSe.sentenceId];
    return  tmpSentences.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EnglishSentenceItem *cell = nil;
    if(showStyle == English) {
        static NSString *sentencesTableViewTag_English = @"cn.block.sentence800.ios.sentence.english";
        cell = (EnglishSentenceItem *)[tableView dequeueReusableCellWithIdentifier:sentencesTableViewTag_English];
        if (cell == nil){
            cell = [[[EnglishSentenceItem alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sentencesTableViewTag_English showStytle:showStyle] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            
        }
        
    }else if(showStyle == Chinese_English) {
        static NSString *sentencesTableViewTag_ChineseEnglish = @"cn.block.sentence800.ios.sentence.chinese.english";
        cell = (EnglishSentenceItem *)[tableView dequeueReusableCellWithIdentifier:sentencesTableViewTag_ChineseEnglish];
        if (cell == nil){
            cell = [[[EnglishSentenceItem alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sentencesTableViewTag_ChineseEnglish showStytle:showStyle] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            
        }
        
    }else if(showStyle == Chinese) {
        static NSString *sentencesTableViewTag_Chinese = @"cn.block.sentence800.ios.sentence.chinese";
        cell = (EnglishSentenceItem *)[tableView dequeueReusableCellWithIdentifier:sentencesTableViewTag_Chinese];
        if (cell == nil){
            cell = [[[EnglishSentenceItem alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sentencesTableViewTag_Chinese showStytle:showStyle] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            
        }
    }


    
 
    SentenceEntity* tmpSe = [self.section objectAtIndex:indexPath.section];
    NSMutableArray* tmpSentences = [self.sentences objectForKey:tmpSe.sentenceId];
  
    SentenceEntity* se = (SentenceEntity*)[tmpSentences objectAtIndex:indexPath.row];
    [cell setEnglish:se.sentenceTitleEnglish];
    
    [cell setChinese:se.sentenceTitle];
    [cell setShowStyle:showStyle];
   
    return cell;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.section.count;
    
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sct
{
    
    return  ((SentenceEntity*)[self.section objectAtIndex:sct]).sentenceTitle;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 != 0) {
        cell.backgroundColor = [UIColor colorWithRed:0xb4/255.0f green:0xeb/255.0f blue:0xed/255.0f alpha:1.0f];
        
    } else {
        cell.backgroundColor = [UIColor colorWithRed:0xb4/255.0f green:0xeb/255.0f blue:0xed/255.0f alpha:0.4f];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
{
    UIControl* bg = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    bg.backgroundColor = COLOR_MAIN_BG;
    bg.layer.shadowColor = RGBACOLOR(255 ,0 ,0 ,0.8f).CGColor;
    bg.layer.shadowOffset = CGSizeMake(0, -5);
    
    UIImageView *chapterImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 14.5f, 15,15)];
    chapterImg.backgroundColor = [UIColor clearColor];

    chapterImg.image = IMG(@"color_6.png");
    
    [bg addSubview:chapterImg];
    [chapterImg release];
    
    UITextField* sectionTitle = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-40, 44)];
    sectionTitle.textAlignment = UITextAlignmentLeft;
    sectionTitle.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    sectionTitle.backgroundColor = [UIColor clearColor];
    sectionTitle.enabled = NO;
    
    
    sectionTitle.center = bg.center;
    sectionTitle.text =  ((SentenceEntity*)[self.section objectAtIndex:section]).sentenceTitle;
    sectionTitle.font = [UIFont systemFontOfSize:18.0f];
    [bg addSubview:sectionTitle];
    [sectionTitle release];
    
    
    
    return [bg autorelease];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 37.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return showStyle == Chinese_English? 88.0f:44.0f;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ( scrollView.isDragging) {
        return;
    }
    isScrolling = YES;
    self.stopTimer = [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(reSetAutoMoving:) userInfo:nil repeats:NO];
    
}

-(void)reSetAutoMoving:(id)sender
{
    isScrolling = NO;
    [self.stopTimer invalidate];
    
}

/* audioPlayerDidFinishPlaying:successfully: is called when a sound has finished playing. This method is NOT called if the player is stopped due to an interruption. */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{

    
    //继续播放下一章节
    NSIndexPath* indexPath = self.resource.selectedId;
    NSIndexPath* nextIndexPath;
    //所有章节数
    int lengthOfChapters = self.resource.chapters.count;
   
    SentenceEntity* seChapter = (SentenceEntity*)[self.resource.chapters objectAtIndex:indexPath.section];
    
    NSMutableArray* tmpSections = (NSMutableArray*)[self.resource.chapter_sections objectForKey:seChapter.sentenceId];
    int lengthOfSection = tmpSections.count;
    
    if (indexPath.section == lengthOfChapters -1 && indexPath.row == lengthOfSection - 1) {
        nextIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    } else {
        if (indexPath.row == lengthOfSection - 1) {
            nextIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section + 1];
        }else {     
            
            nextIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        }
    
    }
    
    
    [self reLoadResBy:nextIndexPath];
    

}

-(void)reLoadResBy:(NSIndexPath*) indexPath
{
    SentenceEntity* seChapter = (SentenceEntity*)[self.resource.chapters objectAtIndex:indexPath.section];
    
    NSMutableArray* sections = (NSMutableArray*)[self.resource.chapter_sections objectForKey:seChapter.sentenceId];
    
    SentenceEntity* seSection = (SentenceEntity*)[sections objectAtIndex:indexPath.row];
    self.resource.selectedId = indexPath;
    self.sectionId = seSection.sentenceId;
    self.navTitle = seSection.sentenceTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SentenceEntity* tmpSe = [self.section objectAtIndex:indexPath.section];
    NSMutableArray* tmpSentences = [self.sentences objectForKey:tmpSe.sentenceId];
    
    SentenceEntity* se = (SentenceEntity*)[tmpSentences objectAtIndex:indexPath.row];
    if (self.sectionIndex == indexPath.section && self.sentenceIndex == indexPath.row) {
        return;
    }
    NSString* resMp3 = se.sentenceRes;
    
    if (![self.audioRes isEqualToString:resMp3]) {
        self.audioRes = resMp3;
        [self loadMusic:self.audioRes type:@"mp3"];
    }
    

    if(_audioPlayer.playing)
    {
        
        _audioPlayer.currentTime = se.sentenceTime;
        [_audioPlayer playAtTime:_audioPlayer.currentTime];
    } else {
        [_audioPlayer play];
        _audioPlayer.currentTime = se.sentenceTime;
        [_audioPlayer playAtTime:_audioPlayer.currentTime];
    
    }
    
    
    [self.playerBt setBackgroundImage:IMG(@"pauseButton@2x.png") forState:UIControlStateNormal];

}


/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{

}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{

}

/**
 * 返回系统的导航栏右按钮背景
 **/
-(NSString*)RightBtBG
{
    return @"NavSetting.png";
}
@end
