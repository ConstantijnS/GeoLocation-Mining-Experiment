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

-(void) checkHealthCUs {
  NSMutableArray *deathIndex = [[NSMutableArray alloc] init];
  for (ConsumerUnit * CU in _ConsumerUnits) {
    NSLog(@"CU %i health is %i", [_ConsumerUnits indexOfObject:CU], [CU.health intValue]);
    if ([CU.health intValue] <= 0) {
      [deathIndex addObject:[NSNumber numberWithInt:[_ConsumerUnits indexOfObject:CU]]];
    }
  }
  
  for (int i = 0; i < deathIndex.count; i++) {
    [_ConsumerUnits removeObjectAtIndex:[deathIndex[i] intValue]];
    NSLog(@"CU %i died", [deathIndex[i] intValue]);
  }
  
  NSLog(@"%i CU's remaining", [_ConsumerUnits count]);
}

@end
