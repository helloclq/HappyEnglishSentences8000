//
//  IndexVcViewController.h
//  EnglishSentence_Block
//
//  Created by liqun on 13-5-24.
//  Copyright (c) 2013年 block. All rights reserved.
//

#import "BasicSideVC.h"
#import<AVFoundation/AVFoundation.h>
#import "SNPopupView.h"
#import "SNPopupView+UsingPrivateMethod.h"


@interface IndexVC : BasicSideVC<UITableViewDataSource,UITableViewDelegate,AVAudioPlayerDelegate,UIScrollViewDelegate,SNPopupViewModalDelegate>
@property (nonatomic,copy)NSString* sectionId;



@end
