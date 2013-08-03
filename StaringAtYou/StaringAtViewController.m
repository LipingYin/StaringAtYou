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
@synthesize loginViewController = _loginViewController;
@synthesize sinaUserName;
//@synthesize  myDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //_myDelegate = [[UIApplication sharedApplication] delegate];
    
//    NSArray *array = [[NSArray alloc] initWithObjects:@"One",@"Two",nil];
//    _mainView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
//                                          pages:array];
//    
//    [self.view addSubview:_mainView];

    
   
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
    NSDictionary *myinfo = [allUserInfo objectForKey:KEY_MY_INFO];
    NSString *myName = [myinfo objectForKey:@"username"];
    //_myDelegate.isSinaLogin = [ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo];
    if ([isLogin isEqualToString:VALUE_LOGIN]) {
        
        self.sinaUserName.text = myName;
        
    }else if([isLogin isEqualToString:VALUE_LOGOUT]||!isLogin)
    {
        self.loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.view addSubview:self.loginViewController.view];
        
        //self.loginViewController.userInfoDelegate = self;
        
        self.sinaUserName.text = DEFAULT_MY_NAME;
    }

}

- (void)viewDidAppear:(BOOL)animated;
{
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
}


#pragma mark - Quit
-(IBAction)quitSinaLogin:(id)sender
{
    NSUserDefaults  *allUserInfo =  [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [allUserInfo objectForKey:KEY_IS_LOGIN];

    if ([isLogin isEqualToString:VALUE_LOGIN]) {
        //取消授权
        //NSLog(@"取消授权");
        NSMutableDictionary *item = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"新浪微博",
                                     @"title",
                                     [NSNumber numberWithInteger:ShareTypeSinaWeibo],
                                     @"type",nil];
        
        [ShareSDK cancelAuthWithType:[[item objectForKey:@"type"] integerValue]];
        //_myDelegate.isSinaLogin = NO;
        NSUserDefaults  *allUserInfo =  [NSUserDefaults standardUserDefaults];
        [allUserInfo setObject:VALUE_LOGOUT forKey:KEY_IS_LOGIN];
        self.sinaUserName.text = DEFAULT_MY_NAME;
    }
   
}

-(IBAction)addStare:(id)sender
{
    StaringView *staringView = [[StaringView alloc]initWithFrame:CGRectMake(0, 44, 320, 480-44) style:UITableViewStylePlain];
    [self.view addSubview:staringView];
}
//#pragma mark - UserInfoDelegate
//-(void)passUserInfo:(NSMutableDictionary *)userInfo
//{
//    self.sinaUserName.text = [userInfo objectForKey:@"username"];
//}

@end
