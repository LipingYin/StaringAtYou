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

@interface StaringAtViewController ()

@end

@implementation StaringAtViewController
@synthesize loginViewController = _loginViewController;
@synthesize sinaUserName;
@synthesize  myDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sinaUserName.text = @"尚未授权";
    
    
    _myDelegate = [[UIApplication sharedApplication] delegate];
    if (!_myDelegate.isSinaLogin) {
        self.loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.view addSubview:self.loginViewController.view];
        
        self.loginViewController.userInfoDelegate = self;
    }
    
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UserInfoDelegate
-(void)passUserInfo:(NSMutableDictionary *)userInfo
{
    self.sinaUserName.text = [userInfo objectForKey:@"username"];
}

@end
