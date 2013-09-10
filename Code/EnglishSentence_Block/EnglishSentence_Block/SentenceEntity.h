//
//  SentenceEntity.h
//  EnglishSentence_Block
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SentenceEntity : NSObject
@property(nonatomic,assign)int type;
@property(nonatomic,copy)NSString* sentenceId;
@property(nonatomic,copy)NSString* sentenceTitle;
@property(nonatomic,copy)NSString* sentenceTitleEnglish;
@property(nonatomic,assign)float sentenceTime;
@property(nonatomic,copy)NSString* sentenceRes;
@end
