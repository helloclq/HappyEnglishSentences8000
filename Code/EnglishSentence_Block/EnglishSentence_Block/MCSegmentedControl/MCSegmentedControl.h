//
//  MCSegmentedControl.h
//
//  Created by Matteo Caldari on 21/05/2010.
//  Copyright 2010 Matteo Caldari. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MCSegmentedControl : UISegmentedControl {

	NSMutableArray *_items;
	
	UIFont  *_font;
	UIColor *_selectedItemColor;
	UIColor *_unselectedItemColor;

	UIColor *_selectedItemShadowColor;
	UIColor *_unselectedItemShadowColor;
	
	CGFloat _cornerRadius;
	
	NSArray *_unSelectedItemBackgroundGradientColors;
}

/**
 * Font for the segments with title
 * Default is sysyem bold 18points
 */
@property (nonatomic, retain) UIFont  *font;

/**
 * Color of the item in the selected segment
 * Applied to text and images
 */
@property (nonatomic, retain) UIColor *selectedItemColor;

/**
 * Color of the items not in the selected segment
 * Applied to text and images
 */
@property (nonatomic, retain) UIColor *unselectedItemColor;

/**
 * Default is black with .2 alpha
 */
@property (nonatomic, retain) UIColor *selectedItemShadowColor;


/**
 * Default is white
 */
@property (nonatomic, retain) UIColor *unselectedItemShadowColor;


@property (nonatomic, assign) CGFloat cornerRadius;

/**
 * Contains the 2 gradient components for the non-selected items
 * Default is white and gray 200/255.0
 */
@property (nonatomic, retain) NSArray *unSelectedItemBackgroundGradientColors;





@end
