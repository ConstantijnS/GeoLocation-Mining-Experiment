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
    _ratioN = 1; //default is 1;
    _ratioE = 1;
    _ratioS = 1;
    _ratioW = 1;
  }
  return self;
}

-(id) initWithRatioN:(int)N ratioE:(int)E ratioS:(int)S ratioW:(int)W {
  if (self = [super init]) {
    _ratioN = N;
    _ratioE = E;
    _ratioS = S;
    _ratioW = W;
  }
  return self;
}



@end
