//
//  Factory.m
//  Experiment1
//
//  Created by Constantijn Smit on 09-01-14.
//  Copyright (c) 2014 Constantijn Smit. All rights reserved.
//

#import "Factory.h"

#define kUpperbound 5

@implementation Factory

-(id)init {
  if (self = [super init]) {
    _ConsumerUnits = [[NSMutableArray alloc] init];
  }
  return self;
}

-(void)createRandomConsumerUnits:(int)amount {
  for (int i = 0; i < amount; i++) {
    ConsumerUnit * CU = [[ConsumerUnit alloc] initWithRatioN:arc4random_uniform(kUpperbound)
                                                      ratioE:arc4random_uniform(kUpperbound)
                                                      ratioS:arc4random_uniform(kUpperbound)
                                                      ratioW:arc4random_uniform(kUpperbound)];
    [_ConsumerUnits addObject:CU];
  }
  
}

// Factory checks health of CU's in array _ConsumerUnits.
-(void) checkHealthCUs {
  // initialize deathIndex array to store indexnumbers of CU's with health below 0.
  NSMutableArray *deathIndex = [[NSMutableArray alloc] init];
  
  //fast enumeration through _ConsumerUnits.
  for (ConsumerUnit * CU in _ConsumerUnits) {
    NSLog(@"CU %i health is %i", [_ConsumerUnits indexOfObject:CU], [CU.health intValue]);
    // store index of CU with health <= 0 in deathIndex.
    if ([CU.health intValue] <= 0) {
      [deathIndex addObject:[NSNumber numberWithInt:[_ConsumerUnits indexOfObject:CU]]];
    }
  }
  
  //remove CU's from _ConsumerUnits-array for each index stored in deathArray.
  for (int i = (deathIndex.count-1); i >= 0; i--) {
    [_ConsumerUnits removeObjectAtIndex:[deathIndex[i] intValue]];
    NSLog(@"CU %i died", [deathIndex[i] intValue]);
  }
  
  NSLog(@"%i CU's remaining", [_ConsumerUnits count]);
}

@end
