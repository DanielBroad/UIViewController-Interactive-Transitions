//
//  IIInteractiveTransition.m
//  InteractionDemo
//
//  Created by Daniel Broad on 25/06/2013.
//  Copyright (c) 2013 Dorada Software Ltd. All rights reserved.
//

#import "IIInteractiveTransition.h"

@interface IIInteractiveTransition ()
@property(nonatomic,assign) UINavigationController *parent;
@property(nonatomic,assign,getter = isInteractive) BOOL interactive;

@end

@implementation IIInteractiveTransition{
    CGPoint _firstPoint;
}
- (id) initWithNavigationController:(UINavigationController *)nc {
    self = [super init];
    if (self) {
        self.parent = nc;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self.parent.view addGestureRecognizer:pan];
    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer *)gr {
    CGPoint position = [gr translationInView:self.parent.view];
    CGFloat percent = fabs(position.y/320);
    
    switch (gr.state) {
        case UIGestureRecognizerStateBegan:
            self.interactive = YES;
            _firstPoint = position;
            [self.parent presentViewController:self.toPresent animated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            [self updateInteractiveTransition: (percent <= 0.0) ? 0.0 : percent];
            break; }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if(percent < 0.50 || [gr state] == UIGestureRecognizerStateCancelled)
                [self cancelInteractiveTransition];
            else
                [self finishInteractiveTransition];
            self.interactive = NO;
        default:
        break;
    }
}



@end