//
//  ContainerViewController.h
//  miniShows
//
//  Created by Pol Quintana on 25/10/14.
//  Copyright (c) 2014 Pol Quintana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerView.h"

@interface ContainerViewController : UIViewController
@property (strong, nonatomic) IBOutlet ContainerView *containerView;
@property (strong, nonatomic) NSString *overviewText;
@property (strong, nonatomic) NSString *updatedText;

@end
