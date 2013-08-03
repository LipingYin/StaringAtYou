//
//  MainView.h
//  StaringAtYou
//
//  Created by yinliping on 13-8-3.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingView.h"
#import "StaringView.h"

@interface MainView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    SettingView *_settingView;
    StaringView *_stareView;
    
    NSArray *pages;
    int currentViewNum;

}

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pagesArray;

@end
