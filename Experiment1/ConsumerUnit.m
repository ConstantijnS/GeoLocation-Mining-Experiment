//
//  ConsumerUnit.m
//  Experiment1
//
//  Created by Constantijn Smit on 06-01-14.
//  Copyright (c) 2014 Constantijn Smit. All rights reserved.
//
// The ConsumerUnit class describes the Consumer Unit. This object consumes gamepoints at a given ratio.

#import "ConsumerUnit.h"

@implementation ConsumerUnit

-(id) init {
  if (self= [super init]) {
    _ratios = [[NSMutableArray alloc] init];
    for ( int i = 0; i < 4; i++) {
      _ratios[i] = [NSNumber numberWithInt:1]; // default = 1.
    }
    
    _health = [NSNumber numberWithInt:20];
  }
  return self;
}

-(id) initWithRatioN:(int)N ratioE:(int)E ratioS:(int)S ratioW:(int)W {
  if (self = [super init]) {
    NSNumber * ratioN = [NSNumber numberWithInt:N];
    NSNumber * ratioE = [NSNumber numberWithInt:E];
    NSNumber * ratioS = [NSNumber numberWithInt:S];
    NSNumber * ratioW = [NSNumber numberWithInt:W];
    
    _ratios = [[NSMutableArray alloc] initWithObjects:ratioN, ratioE, ratioS, ratioW, nil];
    
    _health = [NSNumber numberWithInt:20];
  }
  return self;
}

-(void) reduceHealth: (int) amount {
  int health = [_health intValue];
  health -= amount;
  _health = [NSNumber numberWithInt:health];
  
}


@end
