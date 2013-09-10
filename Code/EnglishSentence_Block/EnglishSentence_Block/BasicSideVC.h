//
//  SideBarButtonController2.h
//  BasicLib
//
//  Created by liqun on 12-12-3.
//  Copyright (c) 2012年 liqun. All rights reserved.
//

#import "BlockVC.h"

@protocol SideMenuLifeDelegate <NSObject>
@required
-(void)moveToRight:(BOOL)moveTORight;
@end

@interface BasicSideVC : BlockVC

@property (nonatomic,assign)id<SideMenuLifeDelegate> sliderDelegate;

@end
