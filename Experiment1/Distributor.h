//
//  Distributor.h
//  Experiment1
//
//  Created by Constantijn Smit on 20-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//
//  The Distributorclass manages the conversion of deltapoints to gamepoints.
//  And the 'gamepoint'-increase received by the deltapoints of the locations manager.
//  And the 'gamepoint'-decrease due to... TO DO.
//  Gamepoints are saved in a plist-file.

#import <Foundation/Foundation.h>

@class DeltaPoint;

@interface Distributor : NSObject

@property (strong, nonatomic) NSMutableArray * gamepoints; // ordered by N, E, S, W (resp. 0, 1, 2, 3)

-(id) init;
-(void) deltapointConversion: (NSMutableArray *) deltapoint;
-(void) saveData;
@end
