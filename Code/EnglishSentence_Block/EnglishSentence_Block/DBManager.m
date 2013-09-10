//
//  DBManager.m
//  BasicLib
//
//  Created by liqun on 12-12-7.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "DBManager.h"
#import "SentenceEntity.h"

#define LOG_DB_ERROR \
if ([db hadError]) \
NSLog(@"genearlDb Error %d: %@", [db lastErrorCode], [db lastErrorMessage])

@interface DBManager()
/**
 *初始化准备
 **/
-(void)containerInit;
/**
 *获取数据库安装包全路径,document目录下
 **/
+ (NSString *)getDatabaseFileFullName;
/**
 *测试和拷贝数据库文件到
 */
+ (void)testAndCopyDatabaseFile;
@end

static DBManager* instance;
@implementation DBManager
@synthesize db = db;
#pragma mark -
#pragma mark -单例方法
+(DBManager*)getInstance
{
    @synchronized(self) {
        if (!instance) {
            instance = [[super allocWithZone:NULL] init];
        }
    }
    
    return instance;
   
}




- (id)init
{
    if (self = [super init]) {
        [self openDataBase];
        return self;
    }
    return self;
}
+(id)allocWithZone:(NSZone *)zone
{
    return [self getInstance];
}

-(id)copyWithZone:(NSZone *)zone
{
    return self;
}
-(id)retain
{
    return self;
}

-(NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (oneway void)release{//oneway关键字只用在返回类型为void的消息定义中， 因为oneway是异步的，其消息预计不会立即返回。
    //什么都不做
}
-(NSString*)description
{
    return @"DBManager";
    
}
#pragma mark -

- (BOOL)rollback:(FMDatabase *)dbtmp
{
    return [dbtmp rollback];
}
- (BOOL)commit:(FMDatabase *)dbtmp
{
    return [dbtmp commit];
}
- (BOOL)beginTransaction:(FMDatabase *)dbtmp
{
    return [dbtmp beginDeferredTransaction];
}
- (BOOL)beginDeferredTransaction:(FMDatabase *)dbtmp
{
    return [dbtmp beginDeferredTransaction];
}

#pragma mark -

#pragma mark --
#pragma mark --数据库操作方法
/**
 *初始化准备
 **/
-(void)containerInit
{


}

/**
 *打开数据库
 **/
-(BOOL)openDataBase
{
    BLOCK_DBLog(@"openDataBase....");
    //获取沙盒下.app文件夹下面的数据库文件
    NSString *dbPath = [[NSBundle mainBundle]pathForResource:FILE_DATABASE ofType:nil];
    //NSString *dbPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:FILE_DATABASE];
    BLOCK_DBLog(@"openDataBase....path=%@",dbPath);
    self.db = [FMDatabase databaseWithPath:dbPath];
    if (db && ![db open]) {
        
        BLOCK_DBLog(@"Database open generalDB failed!");
        return NO;
    }
    return YES;
}

/**
 *关闭数据库
 **/
-(BOOL)closeDataBase{
    if (db ) {
        [db close];
        [db release];
    }
    
    return YES;
}

-(void)dealloc
{
    [db close];
    [db release];
    [super dealloc];
}
#pragma mark -
#pragma mark 缓存方法
/**
 *清理掉所有的数据
 **/
-(void)clearAll
{
    //TODO 清理所有的缓存
    
}



-(NSMutableArray*)findAllChapter
{
    if (!self.db) {
        [self openDataBase];
    }
    if ([self.db goodConnection]) {
        BLOCK_DBLog(@"database connect status is well!");
    }

   
    SentenceEntity* se = nil;
    NSMutableArray *array = [ NSMutableArray arrayWithCapacity:10];
    NSString * sql = @"select * from SentencesChapter";
    BLOCK_DBLog(@"sql::%@",sql);
    LOG_DB_ERROR;
    FMResultSet * rs = [self.db executeQuery:sql];
    
    while ([rs next]) {
        se  = [SentenceEntity new];
        NSString *title = [rs stringForColumn:@"chapterTitle"];
        se.sentenceTitle = [[title stringByReplacingOccurrencesOfString:@"第" withString:@""]stringByReplacingOccurrencesOfString:@"章" withString:@"、" ];
        NSString *chapterid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"chapterId"]];
        se.sentenceId = chapterid;
        [array addObject:se];
        [se release];
    }
    return array;
}


-(NSMutableArray*)findSectionsByChapterId:(NSString* )chapterId
{

    if (!self.db) {
        [self openDataBase];
    }
    if ([self.db goodConnection]) {
        BLOCK_DBLog(@"database connect status is well!");
    }
    
    
    SentenceEntity* se = nil;
    NSMutableArray *array = [ NSMutableArray arrayWithCapacity:10];
    NSString * sql = [NSString stringWithFormat:@"select * from SentencesSection where chapterId ='%@'",chapterId];
    
    BLOCK_DBLog(@"sql::%@",sql);
    LOG_DB_ERROR;
    FMResultSet * rs = [self.db executeQuery:sql];
    
    while ([rs next]) {
        se  = [SentenceEntity new];
        NSString *title = [rs stringForColumn:@"sectionTitle"];
        se.sentenceTitle = title;
        NSString *chapterid = [rs stringForColumn:@"sectionId"];
        se.sentenceId = chapterid;
        //DDLog(@"---%@",title);
        [array addObject:se];
        [se release];
    }
    return array;

}



-(NSMutableArray*)findSentencesBySectionId:(NSString* )sectionId
{
    if (!self.db) {
        [self openDataBase];
    }
    if ([self.db goodConnection]) {
        BLOCK_DBLog(@"database connect status is well!");
    }
    
    
    SentenceEntity* se = nil;
    NSMutableArray *array = [ NSMutableArray arrayWithCapacity:10];
    NSString * sql = [NSString stringWithFormat:@"select * from SentenceSentence where sectionId ='%@' and (type='0' or type=3)",sectionId];
    
    BLOCK_DBLog(@"sql::%@",sql);
    LOG_DB_ERROR;
    FMResultSet * rs = [self.db executeQuery:sql];
    
    while ([rs next]) {
        se  = [SentenceEntity new];
        NSString *title = [rs stringForColumn:@"sentenceTitleChinese"];
        se.sentenceTitle = title;
        NSString *titleEnglish = [rs stringForColumn:@"sentenceTitleEnglish"];
        se.sentenceTitleEnglish = titleEnglish;
        NSString *sentenceTime = [rs stringForColumn:@"sentenceTime"];
        se.sentenceTime = [self translate:sentenceTime];
        NSString *resid = [rs stringForColumn:@"resourceId"];
        se.sentenceRes = resid;
        se.type = [rs intForColumn:@"type"];
       
        se.sentenceId = [rs stringForColumn:@"sentenceId"];
        [array addObject:se];
         BLOCK_DBLog(@"---%@",se);
        [se release];
    }
    return array;



}


-(NSMutableArray*)findSentencesBySubSectionId:(NSString* )sectionId
{
    if (!self.db) {
        [self openDataBase];
    }
    if ([self.db goodConnection]) {
        BLOCK_DBLog(@"database connect status is well!");
    }
    
    
    SentenceEntity* se = nil;
    NSMutableArray *array = [ NSMutableArray arrayWithCapacity:10];
    NSString * sql = [NSString stringWithFormat:@"select * from SentenceSentence where subsectionId ='%@' and type='0'",sectionId];
    
    BLOCK_DBLog(@"sql::%@",sql);
    LOG_DB_ERROR;
    FMResultSet * rs = [self.db executeQuery:sql];
    
    while ([rs next]) {
        se  = [SentenceEntity new];
        NSString *title = [rs stringForColumn:@"sentenceTitleChinese"];
        se.sentenceTitle = title;
        NSString *titleEnglish = [rs stringForColumn:@"sentenceTitleEnglish"];
        se.sentenceTitleEnglish = titleEnglish;
        NSString *sentenceTime = [rs stringForColumn:@"sentenceTime"];
        se.sentenceTime = [self translate:sentenceTime];
        NSString *resid = [rs stringForColumn:@"resourceId"];
        se.sentenceRes = resid;
        se.type = [rs intForColumn:@"type"];
        //DDLog(@"---%@",[title debugDescription]);
        se.sentenceId = [rs stringForColumn:@"sentenceId"];
        [array addObject:se];
        BLOCK_DBLog(@"---%@",se);
        [se release];
    }
    return array;
    
    
    
}


/**
 * 00:11.24 转为float的时间
 **/
-(float)translate:(NSString*)timeStr
{
   
    if ([timeStr hasPrefix:@"0"]) {
        [timeStr stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:@""];
    }
    NSArray *array = [timeStr componentsSeparatedByString:@":"];
    int min = [(NSString*)array[0] intValue];
    float sec = [(NSString*)array[1] floatValue];
   
    return sec + min * 60.0;
}

-(NSMutableArray*)findAllSentences
{

    if (!self.db) {
        [self openDataBase];
    }
    if ([self.db goodConnection]) {
        BLOCK_DBLog(@"database connect status is well!");
    }
    
    
    SentenceEntity* se = nil;
    NSMutableArray *array = [ NSMutableArray arrayWithCapacity:10];
    NSString * sql = @"select * from SentenceSentence";
    
    BLOCK_DBLog(@"sql::%@",sql);
    LOG_DB_ERROR;
    FMResultSet * rs = [self.db executeQuery:sql];
    
    while ([rs next]) {
        se  = [SentenceEntity new];
        NSString *title = [rs stringForColumn:@"sentenceTitleChinese"];
        se.sentenceTitle = title;
        NSString *titleEnglish = [rs stringForColumn:@"sentenceTitleEnglish"];
        se.sentenceTitleEnglish = titleEnglish;
        NSString *time = [rs stringForColumn:@"sentenceTime"];
        se.sentenceTime = [self translate:time];;
        se.sentenceId = [rs stringForColumn:@"sentenceId"];
        NSString *resid = [rs stringForColumn:@"resourceId"];
        se.sentenceRes = resid;
        se.type = [rs intForColumn:@"type"];
        [array addObject:se];
        [se release];
    }
    
    return array;


}

-(NSMutableArray*)findSubSectionsBySectionId:(NSString* )sectionId
{
    if (!self.db) {
        [self openDataBase];
    }
    if ([self.db goodConnection]) {
        BLOCK_DBLog(@"database connect status is well!");
    }
    
    
    SentenceEntity* se = nil;
    NSMutableArray *array = [ NSMutableArray arrayWithCapacity:10];
    NSString * sql = [NSString stringWithFormat:@"select * from SentenceSubSection where sectionId ='%@'",sectionId];
    
    BLOCK_DBLog(@"sql::%@",sql);
    LOG_DB_ERROR;
    FMResultSet * rs = [self.db executeQuery:sql];
    
    while ([rs next]) {
        se  = [SentenceEntity new];
        NSString *title = [rs stringForColumn:@"subsectionTitle"];
        se.sentenceTitle = title;
        NSString *subsectionid = [rs stringForColumn:@"subsectionId"];
        se.sentenceId = subsectionid;
        se.type = 3;
        [array addObject:se];
        [se release];
    }
    
    
    
    
    if ([array count] == 0) {
        NSString * sqlSection = [NSString stringWithFormat:@"select * from SentencesSection where sectionId ='%@'",sectionId];
        
        BLOCK_DBLog(@"sql::%@",sqlSection);
        LOG_DB_ERROR;
        FMResultSet * rs = [self.db executeQuery:sqlSection];
        
        while ([rs next]) {
            se  = [SentenceEntity new];
            NSString *title = [rs stringForColumn:@"sectionTitle"];
            se.sentenceTitle = title;
            NSString *sectionid = [rs stringForColumn:@"subsectionId"];
            se.sentenceId = sectionid;
            se.type = 2;
            //DDLog(@"---%@",title);
            [array addObject:se];
            [se release];
        }

    }
    return array;




}

+ (void)testAndCopyDatabaseFile {
	
	NSString *databaseFilename = [self getDatabaseFileFullName];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = [fileManager fileExistsAtPath:databaseFilename];
	if (!success) {
		// 如果数据库没有，就copy数据库
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:FILE_DATABASE];
		NSError *error = nil;
		success = [fileManager copyItemAtPath:defaultDBPath toPath:databaseFilename error:&error];
		if (!success) {
			NSLog(@"Failed to create database file with message: %@", [error localizedDescription]);
		}
	}
}


+ (NSString *)getDatabaseFileFullName {
	NSString *basicpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	return [basicpath stringByAppendingPathComponent:FILE_DATABASE];
}
@end
