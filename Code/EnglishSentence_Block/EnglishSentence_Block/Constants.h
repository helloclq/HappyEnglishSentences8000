//
//  Constants.h
//  IphoneFileDemo
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#define NetTimeout 30

#define DistanceFloat(PointA,PointB) sqrtf((PointA.x - PointB.x) * (PointA.x - PointB.x) + (PointA.y - PointB.y) * (PointA.y - PointB.y))
#define isiPhone5 ([[UIScreen mainScreen]bounds].size.height == 568)


#define appDele [[UIApplication sharedApplication]delegate]
