//
//  Hub.m
//  Experiment1
//
//  Created by Constantijn Smit on 20-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//

#import "Hub.h"
#import "Distributor.h"
#import "Factory.h"
#import "ConsumerUnit.h"

@implementation Hub

- (id) init {
  if (self = [super init]) {
    
    // Check if locationManager exists, if not -> allocate and initialize it.
    if (_locationManager == nil) {
      _locationManager = [[LocationManager alloc] init];
    }
    
    // Hub is the delegate of locationManager. LocationManager informs Hub of update
    // of deltapoints. Hub passes data to Distributor.
    // LocationManager informs Hub of didStopUpdating and Hub informs the MainViewController.
    _locationManager.delegate = self;
    
    if (_distributor == nil) {
      _distributor = [[Distributor alloc] init];
    }
    
    factory = [[Factory alloc] init];
    
    [factory createRandomConsumerUnits:3];
    for (int i = 0; i < 3; i++) {
      ConsumerUnit * CU = factory.ConsumerUnits[i];
      for (int n = 0; n <4; n++) {
        NSLog(@"CU %i ratio %i: %@", i ,i , CU.ratios[n]);
      }
    }
  }
  return  self;
}

//**TEST**
-(void) nextTurn {
  for (ConsumerUnit * CU in factory.ConsumerUnits) {
    for (int n = 0; n < 4; n++) {
      int gamepoint =[_distributor.gamepoints[n] intValue];
      // check if gamepoint is high enough for deduction of consumer ratio.
      if (gamepoint >= [CU.ratios[n] intValue]) {
        gamepoint -= [CU.ratios[n] intValue];
        _distributor.gamepoints[n] = [NSNumber numberWithInt:gamepoint];
      } else {
        NSLog(@"Not enough gamepoint %i", n);
        [CU reduceHealth:[CU.ratios[n] intValue]];
      }
    }    
  }
  
  [factory checkHealthCUs];
  [self.delegate didUpdateGamepoints];
}
//**END TEST**

#pragma mark delegation methods
-(void) didUpdateDeltapoint {
  [_distributor deltapointConversion:_locationManager.deltapoint];
  [self.delegate didUpdateGamepoints];
}

-(void) didStopUpdating {
  [self.delegate didStopUpdating];
}


@end
