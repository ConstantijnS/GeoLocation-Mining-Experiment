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
  for (ConsumerUnit * CU in _ConsumerUnits) {
    NSLog(@"CU %i health is %i", [_ConsumerUnits indexOfObject:CU], [CU.health intValue]);
    if ([CU.health intValue] <= 0) {
      NSLog(@"CU %i died", [_ConsumerUnits indexOfObject:CU]);
      [_ConsumerUnits removeObject:CU];
      NSLog(@"%i CU's remaining", [_ConsumerUnits count]);
    }
  }
}

@end
