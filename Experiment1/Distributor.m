//
//  Distributor.m
//  Experiment1
//
//  Created by Constantijn Smit on 20-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//

#import "Distributor.h"
#import "DeltaPoint.h"


static const int kScale = 1000000;

@implementation Distributor

- (id) init {
  if (self = [super init]) {
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"Gamepoints.plist"];
    
    // check if plist Gamepoints exists, if not create.
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
      NSMutableDictionary *rootObj = [NSMutableDictionary dictionaryWithCapacity:4];
      
      _gamepointN = [NSNumber numberWithInt:0]; // default to 0
      _gamepointE = [NSNumber numberWithInt:0];
      _gamepointS = [NSNumber numberWithInt:0];
      _gamepointW = [NSNumber numberWithInt:0];
      
      //assign gamepointN, -S, -E and -W to plist dictionary.
      rootObj = [NSMutableDictionary dictionaryWithObjects:
                 [NSArray arrayWithObjects: _gamepointN, _gamepointE, _gamepointS, _gamepointW, nil]
                                                   forKeys:[NSArray arrayWithObjects:@"gamepointN", @"gamepointE", @"gamepointS", @"gamepointW", nil]];
      // create plist xml file.
      id plist = [NSPropertyListSerialization dataFromPropertyList:(id)rootObj
                                                            format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorDesc];
      
      // save Gamepoinst.plist.
      if(plist) {
        [plist writeToFile:plistPath atomically:YES];
      }
      
    }
    
    // read in gamepoints.plist
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
      NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    // assign saved values in plist of gamepointsN,-S,-E and -W.
    _gamepointN = [temp objectForKey:@"gamepointN"];
    _gamepointE = [temp objectForKey:@"gamepointE"];
    _gamepointS = [temp objectForKey:@"gamepointS"];
    _gamepointW = [temp objectForKey:@"gamepointW"];
    
    // assign saved values to temp int gamepoint.
    _gamepointNInt = [_gamepointN intValue];
    _gamepointEInt = [_gamepointE intValue];
    _gamepointSInt = [_gamepointS intValue];
    _gamepointWInt = [_gamepointW intValue];
  }
  return self;
}

-(void) deltapointConversion:(DeltaPoint *)aDeltapoint {
  // scale deltapoints to gamepoints (* kScale)
  double gamepointNDelta = kScale * aDeltapoint.north;
  double gamepointSDelta = kScale * aDeltapoint.south;
  double gamepointEDelta = kScale * aDeltapoint.east;
  double gamepointWDelta = kScale * aDeltapoint.west;
  
  // convert to int and divide with 100, add delta to existing gamepoints.
  _gamepointNInt += ((int)gamepointNDelta)/100;
  _gamepointEInt += ((int)gamepointEDelta)/100;
  _gamepointSInt += ((int)gamepointSDelta)/100;
  _gamepointWInt += ((int)gamepointWDelta)/100;
  
  NSLog(@"gamepointEInt = %i", _gamepointEInt);
  
  // assign to NSNumber gamepoint properties.
  _gamepointN = [NSNumber numberWithInt:_gamepointNInt];
  _gamepointS = [NSNumber numberWithInt:_gamepointSInt];
  _gamepointE = [NSNumber numberWithInt:_gamepointEInt];
  _gamepointW = [NSNumber numberWithInt:_gamepointWInt];
  
  NSLog(@"gamepointN: %@", _gamepointN);
  NSLog(@"gamepointS: %@", _gamepointS);
  NSLog(@"gamepointE: %@", _gamepointE);
  NSLog(@"gamepointW: %@", _gamepointW);
  
}

// This method is run by the AppDelegate when the app moves to the background.
-(void) saveData
{
  
  NSString *error;
  // create strings for paths
  NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Gamepoints.plist"];
  
  // create dictionary
  NSMutableDictionary *plistDict = [NSMutableDictionary dictionaryWithObjects:
                                    [NSArray arrayWithObjects: _gamepointN, _gamepointE, _gamepointS, _gamepointW, nil]
                                                                      forKeys:[NSArray arrayWithObjects: @"gamepointN", @"gamepointE", @"gamepointS", @"gamepointW", nil]];
  
  // create XML file based on plistDict
  id plist = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                        format:NSPropertyListXMLFormat_v1_0
                                              errorDescription:&error];
  // write XML file
  if(plist) {
    [plist writeToFile:plistPath atomically:YES];
  }
  
}
@end
