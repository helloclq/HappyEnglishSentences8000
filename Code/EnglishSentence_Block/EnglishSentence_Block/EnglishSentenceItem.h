//
//  CustomGoodMsgCell.h
//  BasicLib
//
//  Created by liqun on 13-1-8.
//  Copyright (c) 2013年 blockcheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum  {

    Chinese,
    Chinese_English,
    English,
    
}ShowStyle;

@interface EnglishSentenceItem : UITableViewCell



@property (nonatomic,copy)NSString* chinese;
@property (nonatomic,copy)NSString* english;
@property (nonatomic,assign)ShowStyle showStyle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier showStytle:(ShowStyle)showStyle;
@end
