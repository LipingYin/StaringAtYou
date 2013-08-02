//
//  StaringAtAppDelegate.h
//  StaringAtYou
//
//  Created by Liping Yin on 13-7-31.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApi.h>

@class StaringAtViewController;

@interface StaringAtAppDelegate : UIResponder <UIApplicationDelegate>
{
//    BOOL _isSinaLogin;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) StaringAtViewController *viewController;

//@property (assign, nonatomic) BOOL isSinaLogin;

@end
