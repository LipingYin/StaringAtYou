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
#import "StaringAtCell.h"


@interface StaringAtViewController ()

@end

@implementation StaringAtViewController
@synthesize loginViewController;
@synthesize sinaUserName;
@synthesize headView;
@synthesize myHeadImageView;
@synthesize staringTableView;
@synthesize items;

- (void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *myHeadSingleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myHeadSingleTap:)];
    myHeadSingleTap.numberOfTouchesRequired = 1; 
    myHeadSingleTap.numberOfTapsRequired = 1; 
    myHeadImageView.userInteractionEnabled = YES;
    [myHeadImageView addGestureRecognizer:myHeadSingleTap];

    UIImage *headImage = [UIImage imageNamed:@"headView.png"];
    headView.image = headImage;
    
    staringTableView.delegate = self;
    staringTableView.dataSource = self;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"What time is it?", nil];
    self.items = array;
    

    _addButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 100, 33)];
    [_addButton setTitle:@"Add" forState:UIControlStateNormal];
    _addButton.backgroundColor = [UIColor redColor];
    [_addButton addTarget:self action:@selector(addStaring:) forControlEvents:UIControlEventTouchUpInside];

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
            UIImage *defaultImage = [UIImage imageNamed:@"defaulthead.png"];
            myHeadImageView.image = defaultImage;
           
        }
      [self.view addSubview:self.loginViewController.view];
    }
    NSLog(@"clickedButtonAtIndex:%d",buttonIndex);
}

#pragma mark - BUTTON ACTION

-(IBAction)setting:(id)sender
{
    
}

-(void)addStaring:(id)sender
{
    
    [self.items insertObject:@"add staringat" atIndex:0];
    
    [self.staringTableView reloadData];
}


#pragma mark - tableView datesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.items count]+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"StaringAtCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    StaringAtCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (indexPath.row != [self.items count])
    {
        UIImage *defaultImage = [UIImage imageNamed:@"defaulthead.png"];
        myHeadImageView.image = defaultImage;
        cell.nameLabel.text = @"我是XXXX";
        cell.lastUpdateTimeLabel.text = @"最后更新时间是：6小时前";
        cell.userStatusLabel.text = @"在线";
        [_addButton removeFromSuperview];
    }else
    {
      
        [cell addSubview: _addButton];
     
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}



@end
