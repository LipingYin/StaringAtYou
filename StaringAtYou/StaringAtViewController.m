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
    
    _myDelegate = [[UIApplication sharedApplication] delegate];
    
   _myDelegate.isSinaLogin = [ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo];
    if (_myDelegate.isSinaLogin) {
        
         self.sinaUserName.text = @"已经授权";
        
    }else
    {
        self.loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.view addSubview:self.loginViewController.view];
        
        self.loginViewController.userInfoDelegate = self;
        //self.sinaUserName.text = @"尚未授权";
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Quit
-(IBAction)quitSinaLogin:(id)sender
{
    //取消授权
    NSLog(@"取消授权");
    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"新浪微博",
     @"title",
     [NSNumber numberWithInteger:ShareTypeSinaWeibo],
                                  @"type",nil];
    
    [ShareSDK cancelAuthWithType:[[item objectForKey:@"type"] integerValue]];
    _myDelegate.isSinaLogin = NO;
    self.sinaUserName.text = @"尚未授权";


}

#pragma mark - UserInfoDelegate
-(void)passUserInfo:(NSMutableDictionary *)userInfo
{
    self.sinaUserName.text = [userInfo objectForKey:@"username"];
}

@end
