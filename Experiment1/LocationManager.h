//
//  LocationManager.h
//  Experiment1
//
//  Created by Constantijn Smit on 16-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//
//  The locationManager manages location information (GPS-coordinates). For every update in location
//  the relative change since the previous event is calculated. The direction (north, south, east, west) of change
//  is stored in a deltapoint array and stored in a property list when the app moves to the background.

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class DeltaPoint;

@protocol LocationManagerDelegate <NSObject>

-(void) didUpdateDeltapoint;
-(void) didStopUpdating;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) NSMutableArray *deltapoint; // contains directions N, E, S, W (resp. 0, 1, 2, 3)
@property (assign, nonatomic) id<LocationManagerDelegate>delegate;
@property (strong, nonatomic) CLLocation *previousLocation;

-(id)init;
-(void)startStandardUpdates;
-(void)stopStandardUpdates;
-(void) didUpdateDeltapoint;
-(void) didStopUpdating;

@end
