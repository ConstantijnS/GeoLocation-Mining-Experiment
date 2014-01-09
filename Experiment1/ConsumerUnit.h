//
//  ConsumerUnit.h
//  Experiment1
//
//  Created by Constantijn Smit on 06-01-14.
//  Copyright (c) 2014 Constantijn Smit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumerUnit : NSObject


@property (strong, nonatomic) NSMutableArray *ratios; // a retio for each direction, N, S, E, W (resp. 0, 1, 2, 3 in the array);
@property (strong, nonatomic) NSNumber * health;

-(id) init;
-(id) initWithRatioN: (int)N ratioE:(int)E ratioS:(int)S ratioW:(int) W;
-(void) reduceHealth: (int) amount;

@end
