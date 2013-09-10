//
//  DataCache.m
//  BasicLib
//
//  Created by liqun on 12-12-3.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import "DataCache.h"
@interface DataCache()
-(void)containerInit;

@end

static DataCache* instance;
@implementation DataCache


#pragma mark -
#pragma mark -单例方法
+(DataCache*)getInstance
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
        [self containerInit];
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

- (void)dealloc {
    
    [mReminderTrackingHistory release];
    [super dealloc];
}


#pragma mark -
#pragma mark 缓存方法
/**
 *清理掉所有的数据
 **/
-(void)clearAll
{
    
    [mReminderTrackingHistory removeAllObjects];
}


-(void)containerInit
{
    //    fakeImgContainer = [[NSArray arrayWithObjects:
    //                        @"http://img.naomi.cn/pic/3/2012/12/3/2012_12_3_228397833.jpg",
    //                        @"http://img.naomi.cn/pic/4/2012/11/29/2012_11_29_1334227318.jpg",
    //                        @"http://img.naomi.cn/pic/3/2012/6/27/2012_6_27_1271372509.jpg",
    //
    //
    //                         @"http://img.naomi.cn/pic/3/2012/11/23/2012_11_23_2101418124.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/10/11/2012_10_11_965037921.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/10/10/2012_10_10_146265948.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/9/29/2012_9_29_1063175709.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/10/13/2012_10_13_1536631729.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/10/10/2012_10_10_1968543859.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/10/13/2012_10_13_943173653.jpg",
    //                         @"http://img.naomi.cn/pic/4/2012/9/9/2012_9_9_931032493.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/13/2012_9_13_2055972908.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/9/13/2012_9_13_1944850748.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/13/2012_9_13_1919703593.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/12/2012_9_12_1601739926.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/9/12/2012_9_12_1710124651.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/12/2012_9_12_1549231523.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/10/9/2012_10_9_1772338390.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/11/21/2012_11_21_453794681.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/11/17/2012_11_17_1771254426.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/11/16/2012_11_16_1826624378.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/11/17/2012_11_17_1692776378.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/12/2012_9_12_55505988.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/11/16/2012_11_16_1862026415.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/11/23/2012_11_23_1760220282.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/11/23/2012_11_23_495030787.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/12/2012_9_12_992616833.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/9/13/2012_9_13_1642256199.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/12/2012_9_12_992616833.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/10/2012_9_10_1016863160.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/10/26/2012_10_26_1947774626.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/10/25/2012_10_25_625057758.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/10/10/2012_10_10_1799411121.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/12/3/2012_12_3_1702917717.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/12/3/2012_12_3_70363411.jpg",
    //                        @"http://img.naomi.cn/pic/3/2012/12/3/2012_12_3_1925292168.jpg",
    //
    //                         @"http://img.naomi.cn/pic//4/2012/12/7/2012_12_7_1530957781.jpg",
    //                         @"http://img.naomi.cn/pic//4/2012/9/8/2012_9_8_1234361313.jpg",
    //                         @"http://img.naomi.cn/pic//4/2012/9/9/2012_9_9_1434659963.jpg",
    //
    //                         @"http://img.naomi.cn/pic//4/2012/9/1/2012_9_1_1796622252.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/8/30/2012_8_30_392315049.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/1/2012_9_1_1536223524.jpg",
    //
    //                         @"http://img.naomi.cn/pic/3/2012/9/1/2012_9_1_1676079810.jpg",
    //                         @"http://img.naomi.cn/pic/3/2012/9/1/2012_9_1_590208315.jpg",
    //                         @"http://img.naomi.cn/pic/4/2012/9/1/2012_9_1_712937885.jpg",
    //
    //
    //
    //
    //
    //
    //                         nil]
    //                        retain];
    
    
}


/**
 *获取一张随机的图片
 **/
-(NSString*)getOneFakeImgUri
{
    static int  index = -1;
    index ++;
    if (index == [fakeImgContainer count]) {
        index = 0;
    }
    
    return [fakeImgContainer objectAtIndex:index];
}
/**
 *获取假数据的条数
 **/
-(int)getMaxFakeImgCount
{
    return [fakeImgContainer count];
}

@end
