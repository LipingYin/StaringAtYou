//
//  StaringAtViewController.m
//  StaringAtYou
//
//  Created by Liping Yin on 13-7-31.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import "StaringAtAppDelegate.h"
#import "StaringAtViewController.h"
#import "LoginViewController.h"
#import "StaringView.h"

@interface StaringAtViewController ()

@end

@implementation StaringAtViewController
@synthesize loginViewController;
@synthesize sinaUserName;
@synthesize headView;
@synthesize myHeadImageView;


- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *myHeadSingleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myHeadSingleTap:)];
    myHeadSingleTap.numberOfTouchesRequired = 1; //手指数
    myHeadSingleTap.numberOfTapsRequired = 1; //tap次数
    myHeadImageView.userInteractionEnabled = YES;
    [myHeadImageView addGestureRecognizer:myHeadSingleTap];

    UIImage *headImage = [UIImage imageNamed:@"headView.png"];
    headView.image = headImage;    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults  *allUserInfo =  [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [allUserInfo objectForKey:KEY_IS_LOGIN];
    NSDictionary *myinfo = [allUserInfo objectForKey:KEY_MY_SINA_INFO];
    NSString *myName = [myinfo objectForKey:@"username"];
    NSString *headURL = [allUserInfo objectForKey:KEY_MY_HEADIMAGE_URL];
   
    if ([isLogin isEqualToString:VALUE_LOGIN]) {
        
        self.sinaUserName.text = myName;
        [self loadImage:headURL];
        
    }else if([isLogin isEqualToString:VALUE_LOGOUT]||!isLogin)
    {
        self.loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.view addSubview:self.loginViewController.view];
        self.sinaUserName.text = DEFAULT_MY_NAME;
    }
    
    if (!headURL) {
        
        UIImage *defaultImage = [UIImage imageNamed:@"defaulthead.png"];
        myHeadImageView.image = defaultImage;
    }

}

#pragma mark - private methds

-(void)myHeadSingleTap:(UITapGestureRecognizer *)sender

{
    UIAlertView *loginAlert = [[UIAlertView alloc]initWithTitle:@"退出账号"
                                                        message:nil delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    
    [loginAlert show];    
}

- (void)loadImage:(NSString *)url
{
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    [self performSelectorOnMainThread:@selector(showUserIcon:) withObject:image waitUntilDone:NO];
}

- (void)showUserIcon:(UIImage *)icon
{
    if (icon)
        myHeadImageView.image = icon;
    
}

#pragma mark  -- UIAlertViewDelegate --

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex==1) {
        
        NSUserDefaults  *allUserInfo =  [NSUserDefaults standardUserDefaults];
        NSString *isLogin = [allUserInfo objectForKey:KEY_IS_LOGIN];
        
        if ([isLogin isEqualToString:VALUE_LOGIN]) {
            //取消授权
            NSMutableDictionary *item = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"新浪微博",
                                         @"title",
                                         [NSNumber numberWithInteger:ShareTypeSinaWeibo],
                                         @"type",nil];
            
            [ShareSDK cancelAuthWithType:[[item objectForKey:@"type"] integerValue]];
            NSUserDefaults  *allUserInfo =  [NSUserDefaults standardUserDefaults];
            [allUserInfo setObject:VALUE_LOGOUT forKey:KEY_IS_LOGIN];
            self.sinaUserName.text = DEFAULT_MY_NAME;
           
        }
        [self.view addSubview:self.loginViewController.view];
    }
    NSLog(@"clickedButtonAtIndex:%d",buttonIndex);
}

#pragma mark - BUTTON ACTION

-(IBAction)setting:(id)sender
{
    
}
@end
