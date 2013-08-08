//
//  StaringAtViewController.h
//  StaringAtYou
//
//  Created by Liping Yin on 13-7-31.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginViewController.h"


@interface StaringAtViewController : UIViewController<UITableViewDataSource,
                                                     UITableViewDelegate>
{
    NSMutableArray *_items;
    UIButton *_addButton;
}

@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) IBOutlet UILabel *sinaUserName;
@property (strong, nonatomic) IBOutlet UIImageView *headView;
@property (strong, nonatomic) IBOutlet UIImageView *myHeadImageView;
@property (strong, nonatomic) IBOutlet UIButton *settingButton;
@property (strong, nonatomic) IBOutlet UITableView *staringTableView;

@property (strong, nonatomic)  NSMutableArray *items;

-(IBAction)setting:(id)sender;
@end
