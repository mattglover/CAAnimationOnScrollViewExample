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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation DSRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureScrollView];
}

- (void)configureScrollView {
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 5000)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_scrollView.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        if ([subview isKindOfClass:[DSScoreBarView class]]) {
            CFTimeInterval delay = idx * 0.4;
            [(DSScoreBarView *)subview fillBarWithDelay:delay];
        }
    }];
}

@end
