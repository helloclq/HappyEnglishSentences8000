//  所有类的基类，提供模块模式供子类覆写和继承
//  BlockVC.h
//  EnglishSentence_Block
//
//  Created by liqun on 12-11-29.
//  Copyright (c) 2012年 blockcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockVC : UIViewController

@property (nonatomic,retain) NSString* navTitle;
@property (nonatomic,assign) CGRect mainRect ;
@property (nonatomic,retain) UIImageView* navigationView;
@property (nonatomic,retain) UILabel* titleLabel;
@property (nonatomic,retain) UIButton *leftNavBt;
@property (nonatomic,retain) UIButton* rightNavBt;
@property (nonatomic,retain) UIControl* leftControl;
/**
 *是否需要返回,也即是否显示返回按钮
 **/
@property (nonatomic,assign)BOOL canBack;
/**
 *处理标题栏左按钮的事件
 **/
-(void)handleLeft:(id)sender;
/**
 *处理标题栏右按钮的事件
 **/
-(void)handleRight:(id)sender;

-(IBAction)handleEvent:(id)sender;
-(NSString*)description;

/**
 *返回UIViewController
 **/
-(id)getThis;

/**
 *缓存数据的函数
 **/
-(void)saveData:(id)value forKey:(NSString*)key;
-(id)getData:(NSString*)key;
-(void)clearValueForKey:(NSString*)key;
/**
 * 根据key，返回页面数
 */
-(NSInteger) getPageSize:(NSString*) key;
/**
 * 保存页面数，
 *
 * @param key
 *            该页面的键
 * @param obj
 *            该页面的值
 */
-(void) savePageSize:(id)obj forKey:key;
/**
 * 页面数值加一
 *
 * @param key
 *            该页面的键
 */
-(void)addPageSize:(NSString*)key;
/**
 * 页面值重置
 *
 * @param key
 *            该页面的键
 */
-(void) resetPageSize:(NSString*) key ;

/**
 *页面返回时的回调
 **/
-(void)onResume;
/**********************************************/
#pragma mark --
#pragma mark --v 2.0
/**
 * 返回系统的导航栏背景
 **/
-(NSString*)navigationBG;
/**
 * 返回系统的导航栏左按钮背景
 **/
-(NSString*)LeftBtBG;
/**
 * 返回系统的导航栏右按钮背景
 **/
-(NSString*)RightBtBG;
/**
 *返回标题
 **/
-(NSString*)getNavTitle;
/**
 *是否用默认背景图片
 **/
-(BOOL)useDefaultBg;

@end
