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

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    LoginViewController *loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    [self.view addSubview:loginViewController.view];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
