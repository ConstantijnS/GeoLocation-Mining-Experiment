//
//  DeltaPoint.h
//  Experiment1
//
//  Created by Constantijn Smit on 17-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//
//  A deltapoint-object stores the relative latitude and longitude changes per compassdirection (North, South, East, West).

#import <Foundation/Foundation.h>

@interface DeltaPoint : NSObject

@property double north;
@property double south;
@property double west;
@property double east;

@end
