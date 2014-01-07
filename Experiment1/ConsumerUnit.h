//
//  ConsumerUnit.h
//  Experiment1
//
//  Created by Constantijn Smit on 06-01-14.
//  Copyright (c) 2014 Constantijn Smit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConsumerUnit : NSObject

@property int ratioN;
@property int ratioE;
@property int ratioS;
@property int ratioW;


-(id) init;
-(id) initWithRatioN: (int)N ratioE:(int)E ratioS:(int)S ratioW:(int) W;

@end
