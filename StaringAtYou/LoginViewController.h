//
//  LoginViewController.h
//  StaringAtYou
//
//  Created by Liping Yin on 13-7-31.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
{
    @private
    NSMutableArray *_shareTypeArray;
}
@property (strong, nonatomic) IBOutlet UIButton *sinaButton;
@property (strong, nonatomic) IBOutlet UIButton *qqButton;
@property (strong, nonatomic) IBOutlet UIButton *renrenButton;
@property (strong, nonatomic) IBOutlet UIButton *doubanButton;

-(IBAction)sinaBtnPress:(id)sender;
-(IBAction)qqBtnPress:(id)sender;
-(IBAction)renrenBtnPress:(id)sender;
-(IBAction)doubanBtnPress:(id)sender;


@end
