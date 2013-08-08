//
//  StaringAtCell.h
//  StaringAtYou
//
//  Created by Liping Yin on 13-8-8.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaringAtCell : UITableViewCell
{
    IBOutlet UIImageView *_headImageView;
    IBOutlet UILabel *_nameLabel;
    IBOutlet UILabel *_userStatusLabel;
    IBOutlet UILabel *_lastUpdateTimeLabel;

}

@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *userStatusLabel;
@property (strong, nonatomic)  UILabel *lastUpdateTimeLabel;


@end
