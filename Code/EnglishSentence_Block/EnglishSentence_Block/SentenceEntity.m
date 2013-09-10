//
//  SentenceEntity.m
//  EnglishSentence_Block
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "SentenceEntity.h"

@implementation SentenceEntity
- (void)dealloc
{
    self.sentenceId = nil;
    self.sentenceTitle = nil;
    self.sentenceTitleEnglish = nil;
    
    self.sentenceRes = nil;
    [super dealloc];
}

-(NSString*)description
{
   return [NSString stringWithFormat:@"[sentenceId=%@,sentenceTitle=%@,sentenceTitleEnglish=%@,sentenceTime=%f]",self.sentenceId,self.sentenceTitle,self.sentenceTitleEnglish,self.sentenceTime];
}

- (BOOL)isEqual:(id)anObject
{
    if (![anObject isMemberOfClass:[SentenceEntity class]]) {
        return NO;
    }
    SentenceEntity* tmp = (SentenceEntity*)anObject;
    
    return [self.sentenceTitle isEqualToString:tmp.sentenceTitle]  ;

}
@end
