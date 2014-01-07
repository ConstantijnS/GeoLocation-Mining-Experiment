//
//  MainViewController.h
//  Experiment1
//
//  Created by Constantijn Smit on 16-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hub.h"

@interface MainViewController : UIViewController <HubDelegate>

@property (strong, nonatomic) Hub *hub;


@end
