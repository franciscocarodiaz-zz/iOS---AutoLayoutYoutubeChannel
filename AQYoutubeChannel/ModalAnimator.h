//
//  ModalAnimator.h
//  Inclass_ironhackBCN
//
//  Created by Francisco Caro Diaz on 24/10/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIkit.h"

@interface ModalAnimator : NSObject <UIViewControllerAnimatedTransitioning>
// COntine que animacion y como.
@property (nonatomic,assign,getter=isPresenting) BOOL presenting;

@end
