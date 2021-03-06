//
//  LoginViewController.m
//  StaringAtYou
//
//  Created by Liping Yin on 13-7-31.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import "LoginViewController.h"
#import "StaringAtAppDelegate.h"

#define BASE_TAG 100
#define TAG_BUTTON_SINA 100


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize sinaButton = _sinaButton;
@synthesize qqButton = _qqButton;
@synthesize renrenButton = _renrenButton;
@synthesize doubanButton = _doubanButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //_myDelegate = [[UIApplication sharedApplication] delegate];
        
        //监听用户信息变更
        [ShareSDK addNotificationWithName:SSN_USER_INFO_UPDATE
                                   target:self
                                   action:@selector(userInfoUpdateHandler:)];
        
        _shareTypeArray = [[NSMutableArray alloc] initWithObjects:
                           [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"新浪微博",
                            @"title",
                            [NSNumber numberWithInteger:ShareTypeSinaWeibo],
                            @"type",
                            nil],
                           [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"豆瓣社区",
                            @"title",
                            [NSNumber numberWithInteger:ShareTypeDouBan],
                            @"type",
                            nil],
                           [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"QQ空间",
                            @"title",
                            [NSNumber numberWithInteger:ShareTypeQQSpace],
                            @"type",
                            nil],
                           [NSMutableDictionary dictionaryWithObjectsAndKeys:
                            @"人人网",
                            @"title",
                            [NSNumber numberWithInteger:ShareTypeRenren],
                            @"type",
                            nil],
                           nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sinaLogin)
                                                     name:UserLoginNotification
                                                   object:nil];

    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UserLoginNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidAppear:(BOOL)animated;
{
    NSUserDefaults *allUserInfo = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [allUserInfo objectForKey:KEY_IS_LOGIN];
    if ([isLogin isEqualToString:VALUE_LOGIN]) {
        [self.view removeFromSuperview];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{

}

- (void)viewDidDisappear:(BOOL)animated
{

}


#pragma mark- buttonPress functions


-(IBAction)sinaBtnPress:(UIButton *)sender
{
    sender.tag = TAG_BUTTON_SINA;
    [self sinaLogin];
}

-(IBAction)qqBtnPress:(id)sender
{
    

}

-(IBAction)renrenBtnPress:(id)sender
{
    NSLog(@"renren");
}

-(IBAction)doubanBtnPress:(id)sender
{
    NSLog(@"douban");
}


#pragma mark - private methods

-(void)sinaLogin
{
    //StaringAtAppDelegate *appDelegate = (StaringAtAppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSInteger index = TAG_BUTTON_SINA - BASE_TAG;
    
    NSMutableDictionary *item = [_shareTypeArray objectAtIndex:index];
    NSUserDefaults *allUserInfo = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [allUserInfo objectForKey:KEY_IS_LOGIN];
    
    if ([isLogin isEqualToString:VALUE_LOGOUT]|!isLogin) {
        if (index < [_shareTypeArray count])
        {
            //用户用户信息
            ShareType type = [[item objectForKey:@"type"] integerValue];
            
            id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                                 allowCallback:YES
                                                                 authViewStyle:SSAuthViewStyleFullScreenPopup
                                                                  viewDelegate:nil
                                                       authManagerViewDelegate:nil];
            
            //在授权页面中添加关注官方微博
            [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                            SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                            [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                            SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                            nil]];
            
            NSUserDefaults *alluserInfo = [NSUserDefaults standardUserDefaults];
            [alluserInfo setObject:VALUE_LOGIN forKey:KEY_IS_LOGIN];
            [ShareSDK getUserInfoWithType:type
                              authOptions:authOptions
                                   result:^(BOOL result, id<ISSUserInfo> userInfo, id<ICMErrorInfo> error) {
           
                                       
                                       if (result)
                                       {
                                           if ([userInfo icon]) {
                                               [NSThread detachNewThreadSelector:@selector(loadImage:)
                                                                        toTarget:self
                                                                      withObject:[userInfo icon]];
                                           }
                                           [item setObject:[userInfo nickname] forKey:@"username"];
                                           [_shareTypeArray writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
                                           
                                          // [self.userInfoDelegate passUserInfo:item];
                                           
                                            [alluserInfo setObject:item forKey:KEY_MY_SINA_INFO];
                              
                                           
                                       }
                                       NSLog(@"%d:%@",[error errorCode], [error errorDescription]);
//                                       
//                                       if (0==[error errorCode]) {
//                                           NSUserDefaults *alluserInfo = [NSUserDefaults standardUserDefaults];
//                                           [alluserInfo setObject:VALUE_LOGIN forKey:KEY_IS_LOGIN];
//                                           [self.view removeFromSuperview];
//                                           
//                                       }
                                       
                                   }];
            
        }
        
    }
    else
    {
    }
    
}

- (void)userInfoUpdateHandler:(NSNotification *)notif
{
    NSMutableArray *authList = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()]];
    if (authList == nil)
    {
        authList = [NSMutableArray array];
    }
    
    NSString *platName = nil;
    NSInteger plat = [[[notif userInfo] objectForKey:SSK_PLAT] integerValue];
    switch (plat)
    {
        case ShareTypeSinaWeibo:
            platName = @"新浪微博";
            break;
        case ShareTypeDouBan:
            platName = @"豆瓣";
            break;
        case ShareTypeQQSpace:
            platName = @"QQ空间";
            break;
        case ShareTypeRenren:
            platName = @"人人网";
            break;
        default:
            platName = @"未知";
    }
    id<ISSUserInfo> userInfo = [[notif userInfo] objectForKey:SSK_USER_INFO];
    
    BOOL hasExists = NO;
    for (int i = 0; i < [authList count]; i++)
    {
        NSMutableDictionary *item = [authList objectAtIndex:i];
        ShareType type = [[item objectForKey:@"type"] integerValue];
        if (type == plat)
        {
            [item setObject:[userInfo nickname] forKey:@"username"];
            hasExists = YES;
            break;
        }
    }
    
    if (!hasExists)
    {
        NSDictionary *newItem = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 platName,
                                 @"title",
                                 [NSNumber numberWithInteger:plat],
                                 @"type",
                                 [userInfo nickname],
                                 @"username",
                                 nil];
        [authList addObject:newItem];
    }
    
    [authList writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
}

- (void)loadImage:(NSString *)url
{

    NSUserDefaults *alluserInfo = [NSUserDefaults standardUserDefaults];
    [alluserInfo setObject:url forKey:KEY_MY_HEADIMAGE_URL];

}

- (void)showUserIcon:(UIImage *)icon
{
    if (icon)
    {
//        UIImageView *imageView = [[[UIImageView alloc] initWithImage:icon] autorelease];
//        imageView.frame = CGRectMake(0.0, 0.0, _tableView.width, imageView.height * _tableView.width / imageView.width);
//        _tableView.tableHeaderView = imageView;

    
    }
}
@end
