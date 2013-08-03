//
//  StaringAtViewController.h
//  StaringAtYou
//
//  Created by Liping Yin on 13-7-31.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginViewController.h"
#import "MainView.h"

@interface StaringAtViewController : UIViewController
{
    //StaringAtAppDelegate *_myDelegate;
    MainView *_mainView;
}

@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) IBOutlet UILabel *sinaUserName;
@property (strong, nonatomic) IBOutlet UIButton *quitSinaButton;
@property (strong, nonatomic) IBOutlet UIButton *addStareButton;
//@property (strong, nonatomic) StaringAtAppDelegate *myDelegate;


-(IBAction)quitSinaLogin:(id)sender;
-(IBAction)addStare:(id)sender;
@end
