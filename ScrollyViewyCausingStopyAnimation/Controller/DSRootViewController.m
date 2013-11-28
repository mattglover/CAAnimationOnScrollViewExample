//
//  DSRootViewController.m
//  ScrollyViewyCausingStopyAnimation
//
//  Created by Matt Glover on 28/11/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "DSRootViewController.h"
#import "DSScoreBarView.h"

@interface DSRootViewController ()
@property (nonatomic, strong) DSScoreBarView *scoreBarView;
@end

@implementation DSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupScrollView];
}

- (void)setupScrollView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 5000)];
    
    self.scoreBarView = [[DSScoreBarView alloc] initWithFrame:CGRectMake(10, 470, CGRectGetWidth(scrollView.bounds) - 20, 70)];
    [scrollView addSubview:_scoreBarView];
    
    [self.view addSubview:scrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.scoreBarView fillBar];
}

@end
