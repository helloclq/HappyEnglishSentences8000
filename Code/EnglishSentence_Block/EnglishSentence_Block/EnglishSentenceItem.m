//
//  CustomGoodMsgCell.m
//  BasicLib
//
//  Created by liqun on 13-1-8.
//  Copyright (c) 2013年 blockcheng. All rights reserved.
//

#import "EnglishSentenceItem.h"

#define SIZE_ITEM_HEIGH 80.0f

@interface EnglishSentenceItem()
{
    UIView *containerView ;

    
    UIView* chineseContainer;
    UIView* englishContainer;

}
@property (nonatomic,retain)UILabel* chineseLabel;
@property (nonatomic,retain)UILabel* englishLabel;
@end

@implementation EnglishSentenceItem


-(void)dealloc
{
    self.chinese = nil;
    self.english = nil;
    
    self.chineseLabel = nil;
    self.englishLabel = nil;
    
      [containerView release];
    [chineseContainer release];
    [englishContainer release];
    
    [super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier showStytle:(ShowStyle)showStyle
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //整体的容器view
                
        containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,SCREEN_WIDTH, SIZE_ITEM_HEIGH)];
        containerView.backgroundColor = [UIColor clearColor];
        containerView.layer.masksToBounds = YES;
        
        chineseContainer = [[UIView alloc] init];
        chineseContainer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SIZE_ITEM_HEIGH/2.0f);
        chineseContainer.backgroundColor = [UIColor clearColor];
        [containerView addSubview:chineseContainer];
                                    
        UIImageView *chineseImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, (chineseContainer.frame.size.height - 15)/2.0f, 15,15)];
        chineseImg.backgroundColor = [UIColor clearColor];
        //NSString *iconImg = [[NSString stringWithFormat:@"color_%d.png",(section % 15 + 1)] retain];
        chineseImg.image = IMG(@"color_6.png");
        //[iconImg release];
        [chineseContainer addSubview:chineseImg];
        [chineseImg release];
        
        _chineseLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0,SCREEN_WIDTH - 30 ,  chineseContainer.frame.size.height)];
        self.chineseLabel.numberOfLines = 2;
        self.chineseLabel.font = [UIFont boldSystemFontOfSize:16.5f];
        self.chineseLabel.textAlignment = NSTextAlignmentCenter;
        self.chineseLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        self.chineseLabel.text = @"开心英语8000句，中文翻译";
        self.chineseLabel.backgroundColor = [UIColor clearColor];
        self.chineseLabel.textColor = RGBACOLOR(0, 0, 0, 0.6);
        [chineseContainer addSubview:self.chineseLabel];
        
        
        englishContainer = [[UIView alloc] init];
        englishContainer.frame = CGRectMake(0, SIZE_ITEM_HEIGH/2.0f, SCREEN_WIDTH,SIZE_ITEM_HEIGH/2.0f);
         englishContainer.backgroundColor = [UIColor clearColor];
        [containerView addSubview:englishContainer];
       
        
        UIImageView *englishImg = [[UIImageView alloc] initWithFrame:CGRectMake(15,(englishContainer.frame.size.height - 15)/2.0f, 15,15)];
        englishImg.backgroundColor = [UIColor clearColor];
        //NSString *iconImg = [[NSString stringWithFormat:@"color_%d.png",(section % 15 + 1)] retain];
        englishImg.image = IMG(@"color_14.png");
        //[iconImg release];
        [englishContainer addSubview:englishImg];
        [englishImg release];
                                    
        _englishLabel = [[UILabel alloc] initWithFrame:CGRectMake(35,0, SCREEN_WIDTH - 35 - 10, englishContainer.frame.size.height)];
        self.englishLabel.numberOfLines = 2;
        self.englishLabel.font = [UIFont boldSystemFontOfSize:16.5f];
        self.englishLabel.textAlignment = NSTextAlignmentCenter;
        self.englishLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        self.englishLabel.text = @"English sentence 8000,Learning...";
        self.englishLabel.backgroundColor = [UIColor clearColor];
        self.englishLabel.textColor = RGBACOLOR(0, 0, 0, 0.6);
        [englishContainer addSubview: self.englishLabel];
        //[_englishLabel release];
        
        
        UIImageView* bottomLineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, -2.25, SCREEN_WIDTH, 4.5)];
        bottomLineImg.image = IMG(@"table_bottomline.png");
        bottomLineImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bottomLineImg];
        [bottomLineImg release];
                 
        self.showStyle = showStyle;
        [self.contentView addSubview:containerView];
        
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setChinese:(NSString *)m
{
    if (m != _chinese) {
        [_chinese release];
        _chinese = [m copy];
        
        self.chineseLabel.text = _chinese;
        
    }
}



-(void)setEnglish:(NSString *)english
{
    if (english != _english) {
        [_english release];
        _english = [[english stringByReplacingOccurrencesOfString:@"&" withString:@"'"] copy];
        self.englishLabel.text = _english;
        
    }

}

-(void)setShowStyle:(ShowStyle)ss
{
    if(self.showStyle == English) {
        englishContainer.hidden = NO;
        englishContainer.alpha = 1.0f;
        chineseContainer.hidden = YES;
        chineseContainer.alpha = 0;
        
        containerView.frame = CGRectMake(0.0f, 0.0f,SCREEN_WIDTH, SIZE_ITEM_HEIGH/2.0f);
        englishContainer.frame = CGRectMake(0, 0, SCREEN_WIDTH,SIZE_ITEM_HEIGH/2.0f);
        [self.contentView bringSubviewToFront:englishContainer];
    }else if(self.showStyle == Chinese_English) {
        englishContainer.hidden = NO;
        chineseContainer.hidden = NO;
        englishContainer.alpha = 1;
        chineseContainer.alpha = 1;
        containerView.frame = CGRectMake(0.0f, 0.0f,SCREEN_WIDTH, SIZE_ITEM_HEIGH);
        englishContainer.frame = CGRectMake(0, SIZE_ITEM_HEIGH/ 2.0f, SCREEN_WIDTH,SIZE_ITEM_HEIGH/2.0f);
        
    }else if(self.showStyle == Chinese) {
        englishContainer.hidden = YES;
        chineseContainer.hidden = NO;
        englishContainer.alpha = 0;
        chineseContainer.alpha = 1.0f;
        containerView.frame = CGRectMake(0.0f, 0.0f,SCREEN_WIDTH, SIZE_ITEM_HEIGH/2.0f);
        englishContainer.frame = CGRectMake(0, SIZE_ITEM_HEIGH/2.0f, SCREEN_WIDTH,SIZE_ITEM_HEIGH/2.0f);
        [self.contentView bringSubviewToFront:chineseContainer];
    }
    
    
    

    _showStyle = ss;
    //[self.contentView addSubview:containerView];
    [self.contentView setNeedsDisplay];
    [self.contentView setNeedsLayout];
    
    
}


@end
