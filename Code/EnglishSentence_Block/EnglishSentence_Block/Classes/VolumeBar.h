//
//  VolumeBar.h
//  VolumeBar
//
//  Created by luyf on 13-2-28.
//  Copyright (c) 2013年 luyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VolumeBar : UIControl
{
@private
    NSInteger _minimumVolume;
    NSInteger _maximumVolume;
    
    NSInteger _currentVolume;
}
@property (nonatomic, assign) NSInteger currentVolume;
@property (nonatomic,retain)UIImage* contentImage;
@property (nonatomic,retain)UIImageView* contentView;

- (id)initWithFrame:(CGRect)frame minimumVolume:(NSInteger)minimumVolume maximumVolume:(NSInteger)maximumVolume;

@end
