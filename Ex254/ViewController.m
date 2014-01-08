//
//  ViewController.m
//  Ex254
//
//  Created by SDT-1 on 2014. 1. 8..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#define IMAGE_NUM 4

@interface ViewController ()

@end

@implementation ViewController {
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    int _loadedPageCount;
}

- (void)loadContentsPage:(int)pageNo {
    if (pageNo < 0 || pageNo < _loadedPageCount || pageNo >= IMAGE_NUM) {
        return;
    }
    float width = _scrollView.frame.size.width;
    float height = _scrollView.frame.size.height;
    
    NSString *fileName = [NSString stringWithFormat:@"i%d", pageNo];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"jpeg"];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(width * pageNo, 0, width, height);
    [_scrollView addSubview:imageView];
    _loadedPageCount++;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float width = scrollView.frame.size.width;
    float offsetX = scrollView.contentOffset.x;
    int pageNo = floor(offsetX / width);
    
    _pageControl.currentPage = pageNo;
    
    [self loadContentsPage:pageNo-1];
    [self loadContentsPage:pageNo];
    [self loadContentsPage:pageNo+1];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    float width = _scrollView.bounds.size.width;
    float height = _scrollView.bounds.size.height;
    
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(width * IMAGE_NUM, height);
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(130, 400, 60, 40)];
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages = IMAGE_NUM;
    
    _loadedPageCount = 0;
    [self loadContentsPage:0];
    [self loadContentsPage:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end