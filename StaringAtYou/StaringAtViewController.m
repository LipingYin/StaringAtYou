//
//  StaringAtViewController.m
//  StaringAtYou
//
//  Created by Liping Yin on 13-7-31.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import "StaringAtViewController.h"
#import "LoginViewController.h"

@interface StaringAtViewController ()

@end

@implementation StaringAtViewController
@synthesize loginViewController = _loginViewController;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    [self.view addSubview:self.loginViewController.view];        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
