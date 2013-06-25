//
//  IIAppDelegate.m
//  InteractionDemo
//
//  Created by Daniel Broad on 25/06/2013.
//  Copyright (c) 2013 Dorada Software Ltd. All rights reserved.
//

#import "IIAppDelegate.h"
#import "IIViewController.h"
#import "IIInteractiveTransition.h"

@interface IIAppDelegate () <UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
@end

@implementation IIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.viewOne = [[IIViewController alloc] init];
    self.viewOne.view.backgroundColor = [UIColor redColor];
    self.viewOne.title = @"Swipe Up";
    self.viewTwo = [[IIViewController alloc] init];
    self.viewTwo.view.backgroundColor = [UIColor yellowColor];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.viewOne];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    self.transition = [[IIInteractiveTransition alloc] initWithNavigationController:nav];
    
    self.transition.toPresent = self.viewTwo;
    self.transition.toPresent.modalPresentationStyle = UIModalPresentationCustom;
    [self.transition.toPresent setTransitioningDelegate: self];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UINavigationController *)presenting sourceController:(UIViewController *)source {
    if ([presented isKindOfClass:IIViewController.class]) {
        return self;
    }
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    if ([dismissed isKindOfClass:IIViewController.class]) {
        return self;
    }
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.transition;
    //return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
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
    
    
    [containerView addSubview:fromViewController.view];
    
    [containerView addSubview:toViewController.view];
    
    [fromViewController.view setFrame:[transitionContext finalFrameForViewController:fromViewController]];
    [toViewController.view setFrame:CGRectInset(containerView.bounds, 160, 160)];
    
    [UIView animateWithDuration:duration animations:^{
        [toViewController.view setFrame:containerView.bounds];
        fromViewController.view.alpha = 0.5f;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        
    }];
    
}
@end
