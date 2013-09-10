//  数据库管理类
//  DBManager.h
//  BasicLib
//
//  Created by liqun on 12-12-7.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"



@interface DBManager : NSObject
{
    FMDatabase * db;
}
@property (nonatomic,retain)FMDatabase * db;
+(DBManager*)getInstance;
-(BOOL)openDataBase;
-(BOOL)closeDataBase;
// transaction methods
- (BOOL)rollback:(FMDatabase *)db;
- (BOOL)commit:(FMDatabase *)db;
- (BOOL)beginTransaction:(FMDatabase *)db;
- (BOOL)beginDeferredTransaction:(FMDatabase *)db;

#pragma mark --
#pragma mark --章节相关的操作
-(NSMutableArray*)findAllChapter;
-(NSMutableArray*)findSectionsByChapterId:(NSString* )chapterId;
-(NSMutableArray*)findSentencesBySectionId:(NSString* )sectionId;
-(NSMutableArray*)findAllSentences;

-(NSMutableArray*)findSubSectionsBySectionId:(NSString* )sectionId;
-(NSMutableArray*)findSentencesBySubSectionId:(NSString* )sectionId;
@end
