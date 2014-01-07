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

@property (strong, nonatomic) NSNumber* gamepointN;
@property (strong, nonatomic) NSNumber*  gamepointS;
@property (strong, nonatomic) NSNumber*  gamepointE;
@property (strong, nonatomic) NSNumber*  gamepointW;

@property int gamepointNInt;
@property int gamepointEInt;
@property int gamepointSInt;
@property int gamepointWInt;

-(id) init;
-(void) deltapointConversion: (DeltaPoint *) aDeltapoint;
-(void) saveData;
@end
