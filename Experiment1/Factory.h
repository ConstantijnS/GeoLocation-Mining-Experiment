//
//  Factory.h
//  Experiment1
//
//  Created by Constantijn Smit on 09-01-14.
//  Copyright (c) 2014 Constantijn Smit. All rights reserved.
//
//  The Factory creates game units like the consumer unit.

#import <Foundation/Foundation.h>
#import "ConsumerUnit.h"

@interface Factory : NSObject

@property (strong,nonatomic) NSMutableArray * ConsumerUnits;

-(id) init;
-(void) createRandomConsumerUnits: (int) amount;
-(void) checkHealthCUs;

@end
