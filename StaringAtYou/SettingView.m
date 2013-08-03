//
//  SettingView.m
//  StaringAtYou
//
//  Created by yinliping on 13-8-3.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import "SettingView.h"

@implementation SettingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}// Default is 1 if not implemented

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    if (section==0) 
        title = @"个人信息";
    else
        title = @"其他";
    
    return title;
}// fixed font style. use custom view (UILabel) if you want something different

@end
