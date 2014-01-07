//
//  Hub.m
//  Experiment1
//
//  Created by Constantijn Smit on 20-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//

#import "Hub.h"
#import "Distributor.h"
// **TEST**
#import "ConsumerUnit.h"

@interface Hub () {
  //**TEST**
  ConsumerUnit *CU1;
}

@end

@implementation Hub

- (id) init {
  if (self = [super init]) {
    
    // Check if locationManager exists, if not -> allocate and initialize it.
    if (_locationManager == nil) {
      _locationManager = [[LocationManager alloc] init];
    }
    
    // Hub is the delegate of locationManager. LocationManager informs Hub of update
    // of deltapoints. Hub passes data to Distributor.
    // LocationManager informs Hub of didStopUpdating and informs the MainViewController.
    _locationManager.delegate = self;
    
    if (_distributor == nil) {
      _distributor = [[Distributor alloc] init];
    }
  
    //**TEST**
    CU1 = [[ConsumerUnit alloc] initWithRatioN:1 ratioE:5 ratioS:3 ratioW:1];
  }
  return  self;
}

-(void) nextTurn {
  _distributor.gamepointNInt -= CU1.ratioN;
  _distributor.gamepointN = [NSNumber numberWithInt:_distributor.gamepointNInt];
  
   _distributor.gamepointEInt -= CU1.ratioE;
  _distributor.gamepointE = [NSNumber numberWithInt:_distributor.gamepointEInt];
  
   _distributor.gamepointSInt -= CU1.ratioS;
  _distributor.gamepointS = [NSNumber numberWithInt:_distributor.gamepointSInt];
  
  _distributor.gamepointWInt -= CU1.ratioW;
  _distributor.gamepointW = [NSNumber numberWithInt:_distributor.gamepointWInt];
  
  [self.delegate didUpdateGamepoints];
}


#pragma mark delegation methods
-(void) didUpdateDeltapoint {
  [_distributor deltapointConversion:_locationManager.deltaPoint];
  [self.delegate didUpdateGamepoints];
}

-(void) didStopUpdating {
  [self.delegate didStopUpdating];
}


@end
