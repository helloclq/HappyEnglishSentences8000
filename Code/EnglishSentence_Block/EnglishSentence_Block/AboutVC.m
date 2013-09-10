//
//  AboutVC.m
//  EnglishSentence_Block
//
//  Created by liqun on 13-7-8.
//  Copyright (c) 2013年 block. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()

@end

@implementation AboutVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor greenColor]];
    
    CGRect tr = self.mainRect;
    UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0+ NAVIGATION_HEIGHT, tr.size.width, tr.size.height - 0) style:UITableViewStyleGrouped];
    
    tb.dataSource = self;
    tb.backgroundView = nil;
    tb.backgroundColor = [UIColor clearColor];
    tb.delegate = self;
    
    [self.view addSubview:tb];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark -
#pragma  mark --
#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        
    }
    
    switch (indexPath.section) {
        case 0:
        {
            UITextView *titleTxt = [[UITextView alloc]initWithFrame:CGRectMake(5, 10, 290, 30)];
            
            titleTxt.text = @"开心英语8000句 v1.0";
            titleTxt.backgroundColor = [UIColor clearColor];
            titleTxt.scrollEnabled = NO;
            titleTxt.editable = NO;
            [titleTxt setFont:FONT_BOLD(18)];
            [cell.contentView addSubview:titleTxt];
            [titleTxt release];
            
            UITextView *about = [[UITextView alloc]initWithFrame:CGRectMake(5, 60, APP_WIDTH - 30, 90)];
            
            about.text = @"本软件由辉兔狼工作室制作，所用资源全部来自于互联网,感谢您的使用。";
            about.backgroundColor = [UIColor clearColor];
            about.scrollEnabled = NO;
            about.editable = NO;
            [about setFont:FONT_DEFAULT(16)];
            [cell.contentView addSubview:about];
            [about release];
            
            UITextView *athor = [[UITextView alloc]initWithFrame:CGRectMake(5, 150, 290, 70)];
            
            athor.text = @"我的幸福是希望\
            \r辉兔狼工作室";
            athor.backgroundColor = [UIColor clearColor];
            athor.scrollEnabled = NO;
            athor.editable = NO;
            [athor setFont:FONT_BOLD(18)];
            [cell.contentView addSubview:athor];
            [athor release];
            
            
            
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"联系我们";
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  230.0f;
    }
    return 40.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  44.0f;
    }
    return 33.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 && indexPath.section == 1) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *tmpMailPicker = [[MFMailComposeViewController alloc] init];
            
            tmpMailPicker.mailComposeDelegate = self;
            
            //设置主题
            [tmpMailPicker setSubject: @"开心英语8000句意见反馈"];
            
            // 添加发送者
            NSArray *toRecipients = [NSArray arrayWithObject: @"285224065@qq.com"];
//            NSArray *ccRecipients = [NSArray arrayWithObjects:@"sunyl@naomi.cn", @"yimei@naomi.cn", nil];
            //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];
            [tmpMailPicker setToRecipients: toRecipients];
//            [tmpMailPicker setCcRecipients:ccRecipients];
            //[picker setBccRecipients:bccRecipients];
            
            
            NSString *emailBody = @"邮件正文（请紧接着写下您的意见，非常感谢）：";
            [tmpMailPicker setMessageBody:emailBody isHTML:YES];
            if (!tmpMailPicker) {
                [MyUtils showToast:@"对不起，您的手机未绑定邮箱账户，请配置后再试" autoHideAfterDelay:2];
                return;
                
            }
            
            
            [self presentModalViewController: tmpMailPicker animated:YES];
            [tmpMailPicker release];
            
            
        } else {
            [MyUtils showToast:@"您的手机邮箱账户不可用，请配置后再试" autoHideAfterDelay:2];
            
        }

        
    }
}





/**
 * 返回系统的导航栏背景
 **/
-(NSString*)navigationBG
{
    return  @"common_NavigationBG@2x.png";//@"NavigationBG2@2x.png";
    
}

/**
 *返回标题
 **/
-(NSString*)getNavTitle
{
    return @"关于我们";
    
}
/**
 *是否用默认背景图片
 **/
-(BOOL)useDefaultBg
{
    return  NO;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            
            break;
        default:
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
