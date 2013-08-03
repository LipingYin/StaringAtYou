//
//  MainView.m
//  StaringAtYou
//
//  Created by yinliping on 13-8-3.
//  Copyright (c) 2013年 Liping Yin. All rights reserved.
//

#import "MainView.h"



@implementation MainView

- (id)initWithFrame:(CGRect)frame pages:(NSArray*)pagesArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        _settingView =  [[SettingView alloc]initWithFrame:frame style:UITableViewStylePlain];
        [self addSubview:_settingView];
        
        _stareView = [[StaringView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
        [self addSubview:_stareView];
        
        UIImageView *shaowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow.png"]];
        shaowImageView.contentMode = UIViewContentModeScaleAspectFill;
        shaowImageView.frame = CGRectMake(0, frame.size.height-300, frame.size.width, 300);
        [self addSubview:shaowImageView];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = pagesArray.count;
        [_pageControl sizeToFit];
        [_pageControl setCenter:CGPointMake(300, frame.size.height-50)];
        [self addSubview:_pageControl];
        
        pages = pagesArray;
        currentViewNum = -1;
        
               
    }
    return self;

}

- (void) initShow {
    int scrollNumber = MAX(0, MIN(pages.count-1, (int)(_scrollView.contentOffset.x / self.frame.size.width)));
    
    if(currentViewNum != currentViewNum) {
        currentViewNum = scrollNumber;
        
        //backgroundImage1.image = currentPhotoNum != 0 ? [(IntroModel*)[pages objectAtIndex:currentPhotoNum-1] image] : nil;
       // _settingView.image = [(IntroModel*)[pages objectAtIndex:currentPhotoNum] image];
       // backgroundImage2.image = currentPhotoNum+1 != [pages count] ? [(IntroModel*)[pages objectAtIndex:currentPhotoNum+1] image] : nil;
    }
    
    float offset =  _scrollView.contentOffset.x - (currentViewNum * self.frame.size.width);
    
    
    //left
    if(offset < 0) {
        _pageControl.currentPage = 0;
        
        offset = self.frame.size.width - MIN(-offset, self.frame.size.width);
//        backgroundImage2.alpha = 0;
//        backgroundImage1.alpha = (offset / self.frame.size.width);
//        
        //other
    } else if(offset != 0) {
        //last
        if(scrollNumber == pages.count-1) {
            _pageControl.currentPage = pages.count-1;
            
            //backgroundImage1.alpha = 1.0 - (offset / self.frame.size.width);
        } else {
            
            _pageControl.currentPage = (offset > self.frame.size.width/2) ? currentViewNum+1 : currentViewNum;
            
           // backgroundImage2.alpha = offset / self.frame.size.width;
            //backgroundImage1.alpha = 1.0 - backgroundImage2.alpha;
        }
        //stable
    } else {
        _pageControl.currentPage = currentViewNum;
        //backgroundImage1.alpha = 1;
        //backgroundImage2.alpha = 0;
    }
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scroll {
    [self initShow];
}

@end
