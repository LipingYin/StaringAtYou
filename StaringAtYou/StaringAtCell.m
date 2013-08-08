//
//  StaringAtCell.m
//  StaringAtYou
//
//  Created by Liping Yin on 13-8-8.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import "StaringAtCell.h"

@implementation StaringAtCell

@synthesize headImageView;
@synthesize nameLabel;
@synthesize lastUpdateTimeLabel;
@synthesize userStatusLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
