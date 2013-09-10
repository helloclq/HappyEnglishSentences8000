//
//  DataCache.h
//  BasicLib
//
//  Created by liqun on 12-12-3.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//
/**
 *运行时缓存,单例模式
 **/
#import <Foundation/Foundation.h>
#import "GoodModel.h"
#import "GoodMsgModel.h"
#import "PictureSearInfo.h"
#import "GoodGraphicsDataModel.h"

@interface DataCache : NSObject
{
    
    NSArray *fakeImgContainer;
  
    
}
+(DataCache*)getInstance;
/**
 *清理掉所有的数据
 **/
-(void)clearAll;
/**
 *获取一张随机的图片
 **/
-(NSString*)getOneFakeImgUri;
/**
 *获取假数据的条数
 **/
-(int)getMaxFakeImgCount;


#pragma mark -
#pragma mark --chapter methods



@end
