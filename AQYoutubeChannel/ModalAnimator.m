//
//  ModalAnimator.m
//  Inclass_ironhackBCN
//
//  Created by Francisco Caro Diaz on 24/10/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ModalAnimator.h"

@interface ModalAnimator()
@property (nonatomic,strong) UIDynamicAnimator *mainAnimator;

@end

@implementation ModalAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return self.presenting?0.8f:5.0;
    
    //return 0.8f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    self.mainAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:transitionContext.containerView];
    
    if (self.presenting) {
        // 1. Añadir vistas por defecto ya que el nuevo está vacio por defecto.
        [transitionContext.containerView addSubview:fromViewController.view];
        [transitionContext.containerView addSubview:toViewController.view];
        fromViewController.view.userInteractionEnabled = NO;
        toViewController.view.frame = CGRectMake(0,0,250,200);
        toViewController.view.center = CGPointMake(CGRectGetWidth(fromViewController.view.frame)+300,CGRectGetHeight(fromViewController.view.frame)/2);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:3 options:0 animations:^{
            
            fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
            fromViewController.view.transform = CGAffineTransformMakeScale(0.9,0.9);
        }completion:^(BOOL finished){
            [transitionContext completeTransition:YES];
        }];
        
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:toViewController.view snapToPoint:fromViewController.view.center];
        snap.damping = 0.1;
        [self.mainAnimator addBehavior:snap];
        
        
        /* ANIM 1
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:3 options:0 animations:^{
            toViewController.view.center = fromViewController.view.center;
            fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
            fromViewController.view.transform = CGAffineTransformMakeScale(0.9,0.9);
        }completion:^(BOOL finished){
            [transitionContext completeTransition:YES];
        }];
        */
    }else{
        
        /* ANIM 1
        [transitionContext.containerView addSubview:fromViewController.view];
        [transitionContext.containerView addSubview:toViewController.view];
        
        
        toViewController.view.userInteractionEnabled = YES;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:3 options:0 animations:^{
            toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
            // to back to the normal state
            toViewController.view.transform = CGAffineTransformIdentity;
            fromViewController.view.center = CGPointMake(500, CGRectGetHeight(toViewController.view.frame)/2);
        }completion:^(BOOL finished){
            [transitionContext completeTransition:YES];
            [[UIApplication sharedApplication].keyWindow addSubview:toViewController.view];
        }];
        */
        
        // ANIM 2
        
        [transitionContext.containerView addSubview:toViewController.view];
        [transitionContext.containerView addSubview:fromViewController.view];
        
        [UIView animateWithDuration:1.0 animations:^{
            toViewController.view.transform = CGAffineTransformIdentity;
            toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        } completion:^(BOOL finished){
            [transitionContext completeTransition:YES];
            [[UIApplication sharedApplication].keyWindow addSubview:toViewController.view];
            toViewController.view.userInteractionEnabled = YES;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *questionSelected = [defaults objectForKey:@"questionSelected"];
            NSLog(@"QuestionSelected: %@",questionSelected);
        }];
        
        
        //self.mainAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:transitionContext.containerView];
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[fromViewController.view]];
        
        gravity.magnitude = 3;
        [self.mainAnimator addBehavior:gravity];
        
        
        
        
        
    }
}

@end


/* TEMPLATE
 
 
 #import "ModalAnimator.h"
 
 @implementation ModalAnimator
 
 -(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
 return 0.8f;
 }
 
 -(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
 UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
 UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
 
 if (self.presenting) {
 // 1. Añadir vistas por defecto ya que el nuevo está vacio por defecto.
 [transitionContext.containerView addSubview:fromViewController.view];
 [transitionContext.containerView addSubview:toViewController.view];
 
 }else{
 [transitionContext.containerView addSubview:fromViewController.view];
 [transitionContext.containerView addSubview:toViewController.view];
 
 }
 }
 
 @end

 
 
 
*/