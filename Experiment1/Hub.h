//
//  Hub.h
//  Experiment1
//
//  Created by Constantijn Smit on 20-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//
//  To avoid overloading the viewController all model-objects are managed via the hub.
//  The hub is the only object with which the MainViewController communicates.

#import <Foundation/Foundation.h>
#import "LocationManager.h"

@class Distributor;
@class Factory;

@protocol HubDelegate <NSObject>

-(void) didStopUpdating;
-(void) didUpdateGamepoints;

@end

@interface Hub : NSObject <LocationManagerDelegate> {
  Factory * factory;
}


@property (strong, nonatomic)LocationManager *locationManager;
@property (strong, nonatomic)Distributor *distributor;
@property (assign, nonatomic) id<HubDelegate>delegate;

-(id)init;
-(void)didUpdateDeltapoint;
-(void)didStopUpdating;
-(void)nextTurn;

@end
