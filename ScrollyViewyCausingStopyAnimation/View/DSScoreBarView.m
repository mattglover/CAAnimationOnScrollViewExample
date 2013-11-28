//
//  DSScoreBarView.m
//  ScrollyViewyCausingStopyAnimation
//
//  Created by Matt Glover on 28/11/2013.
//  Copyright (c) 2013 Duchy Software Ltd. All rights reserved.
//

#import "DSScoreBarView.h"
#import <QuartzCore/QuartzCore.h>

@interface DSScoreBarView ()
@property (nonatomic, weak) CADisplayLink *displayLink;
@property (nonatomic, strong) CATextLayer *scoreTextLayer;
@property (nonatomic, strong) CALayer *scoreBarLayer;
@end

@implementation DSScoreBarView

#pragma mark - Initialisers
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit {
    
    [self setBackgroundColor:[UIColor colorWithWhite:0.98 alpha:1.0]];
    [self setupScoreTextLayer];
    [self setupScoreBarLayer];
}

#pragma mark - Setup
- (void)setupScoreTextLayer {
    self.scoreTextLayer = [CATextLayer layer];
    [_scoreTextLayer setBounds:CGRectMake(0, 0, CGRectGetHeight(self.bounds), 17)];
    [_scoreTextLayer setAnchorPoint:CGPointMake(0.0f, 0.5f)];
    [_scoreTextLayer setPosition:CGPointMake(0.0f, floorf(CGRectGetHeight(self.bounds)/2))];
    [_scoreTextLayer setAlignmentMode:kCAAlignmentCenter];
    [_scoreTextLayer setForegroundColor:[UIColor greenColor].CGColor];
    [_scoreTextLayer setContentsScale:[[UIScreen mainScreen] scale]];
    [_scoreTextLayer setFontSize:15.0];
    
    [self updateScoreText];
    
    [self.layer addSublayer:_scoreTextLayer];
}

- (void)setupScoreBarLayer {
    
    self.scoreBarLayer = [CALayer layer];
    [_scoreBarLayer setBounds:CGRectMake(0, 0, 0, CGRectGetHeight(self.bounds))];
    [_scoreBarLayer setAnchorPoint:CGPointMake(0.0f, 0.5f)];
    [_scoreBarLayer setPosition:CGPointMake(CGRectGetMaxX(_scoreTextLayer.frame), floorf(CGRectGetHeight(self.bounds)/2))];
    [_scoreBarLayer setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
 
    [self.layer addSublayer:_scoreBarLayer];
}

#pragma mark - Animate
- (void)fillBarWithDelay:(CFTimeInterval)delay {
    
    CABasicAnimation *animation = [self animationToExtendBoundsOfLayer:_scoreBarLayer];
    [animation setBeginTime:CACurrentMediaTime() + delay];
    [_scoreBarLayer addAnimation:animation forKey:@"fillBarAnimation"];
    
    self.displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(checkScore)];
    [_displayLink setFrameInterval:1];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - CADisplayLink Listener
- (void)checkScore {
    [self updateScoreText];
}

#pragma mark - Text Update
- (void)updateScoreText {
    CALayer *currentPresentationLayer = _scoreBarLayer.presentationLayer;
    CGFloat currentWidth = CGRectGetWidth(currentPresentationLayer.bounds);
    
    float percentComplete = ceilf((100 / [self widthForFullFill]) * currentWidth);
    [_scoreTextLayer setString:[NSString stringWithFormat:@"%.0f", percentComplete]];
    [_scoreTextLayer setForegroundColor:[self colorForPercentComplete:percentComplete]];
}

#pragma mark - Animation Helper
- (CABasicAnimation *)animationToExtendBoundsOfLayer:(CALayer *)layer {
    
    CGFloat fromValue = CGRectGetWidth(layer.bounds);
    CGFloat toValue   = [self widthForFullFill];
    
    CABasicAnimation *changeBoundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    [changeBoundsAnimation setFromValue:[NSNumber numberWithFloat:fromValue]];
    [changeBoundsAnimation setToValue:  [NSNumber numberWithFloat:toValue]];
    [changeBoundsAnimation setDuration:20.0];
    [changeBoundsAnimation setFillMode:kCAFillModeForwards];
    [changeBoundsAnimation setRemovedOnCompletion:NO];
    
    return changeBoundsAnimation;
}

#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
   
    [_scoreBarLayer removeAnimationForKey:@"fillBarAnimation"];
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark - CGSize Helper
- (CGFloat)widthForFullFill {
    return CGRectGetWidth(self.bounds) - CGRectGetWidth(_scoreTextLayer.bounds);
}

#pragma mark - Color Helper
- (CGColorRef)colorForPercentComplete:(float)percentComplete {
    if (percentComplete < 33) {
        return [UIColor greenColor].CGColor;
    } else if (percentComplete < 90) {
        return [UIColor orangeColor].CGColor;
    } else {
        return [UIColor redColor].CGColor;
    }
}

@end
