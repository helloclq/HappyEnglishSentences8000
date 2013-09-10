//
//  MainMenuController.h
//  BasicLib
//
//  Created by liqun on 12-12-1.
//  Copyright (c) 2012年 liqun. All rights reserved.
//

#import "BlockVC.h"
#import "IndexVC.h"

@interface SideContainerManager : BlockVC<UITableViewDataSource,UITableViewDelegate,SideMenuLifeDelegate>

@property (nonatomic,copy) NSArray *titles;
@property (nonatomic ,retain)NSTimer* myTimer;
@property (nonatomic ,retain)NSMutableArray* chapters;
@property (nonatomic ,retain)NSMutableDictionary*chapter_sections ;
@property (nonatomic ,retain)NSIndexPath* selectedId;
@end