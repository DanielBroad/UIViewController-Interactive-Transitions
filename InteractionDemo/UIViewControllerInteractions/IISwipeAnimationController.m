//
//  IISwipeAnimatonController.m
//  InteractionDemo
//
//  Created by Daniel Broad on 11/07/2013.
//  Copyright (c) 2013 Dorada Software Ltd. All rights reserved.
//

#import "IISwipeAnimationController.h"

@interface IISwipeAnimationController ()
@property (weak) UIViewController* to;
@end

@implementation IISwipeAnimationController

-(id) initToVC: (UIViewController*) to {
    self = [super init];
    if (self) {
        self.to = to;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (toViewController != self.to) { // dismiss
        NSLog(@"Animation Dismiss");
        [containerView addSubview:toViewController.view];
        [containerView addSubview:fromViewController.view];
        [fromViewController.view setFrame:containerView.bounds];
        [toViewController.view setFrame:[transitionContext finalFrameForViewController:toViewController]];
        
        [UIView animateWithDuration:duration animations:^{
            [fromViewController.view setFrame:CGRectOffset(containerView.bounds, 0, containerView.bounds.size.height)];
            toViewController.view.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!self.wasCancelled];
            NSLog(@"Animation Dismiss Finished");
        }];
    } else {  // present
        NSLog(@"Animation Present");
        [containerView addSubview:fromViewController.view];
        [containerView addSubview:toViewController.view];
        [fromViewController.view setFrame:[transitionContext finalFrameForViewController:fromViewController]];
        CGRect bounds = containerView.bounds;
        [toViewController.view setFrame:CGRectOffset(bounds, 0, bounds.size.height-self.yOffset)];
        
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [toViewController.view setFrame:containerView.bounds];
            fromViewController.view.alpha = 0.5f;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!self.wasCancelled];
            NSLog(@"Animation Present Finished %d",!self.wasCancelled);
            
        }];
    }
    
    
}

@end
