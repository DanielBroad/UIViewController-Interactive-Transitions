//
//  IIInteractiveTransition.h
//  InteractionDemo
//
//  Created by Daniel Broad on 25/06/2013.
//  Copyright (c) 2013 Dorada Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IIInteractiveTransition : UIPercentDrivenInteractiveTransition
- (instancetype)initWithNavigationController:(UINavigationController *)nc;
@property(nonatomic,strong) UIViewController *toPresent;
@end
