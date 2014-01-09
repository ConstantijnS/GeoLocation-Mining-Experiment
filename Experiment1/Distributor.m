//
//  Distributor.m
//  Experiment1
//
//  Created by Constantijn Smit on 20-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//

#import "Distributor.h"

static const int kScale = 1000000;

@implementation Distributor

- (id) init {
  if (self = [super init]) {
    // initialize mutable array gamepoints.
    _gamepoints = [[NSMutableArray alloc] init];
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"Gamepoints.plist"];
    
    // check if plist Gamepoints exists, if not create.
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
      NSMutableDictionary *rootObj = [NSMutableDictionary dictionaryWithCapacity:4];
      
      // set gamepoints to default 0
      for (int i = 0; i < 4; i++) {
        _gamepoints[i] = [NSNumber numberWithInt:0]; // default to 0
      }
      
      //assign gamepointN, -S, -E and -W to plist dictionary.
      rootObj = [NSMutableDictionary dictionaryWithObjects:
                 [NSArray arrayWithObjects: _gamepoints[0], _gamepoints[1], _gamepoints[2], _gamepoints[3], nil]
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
    _gamepoints[0] = [temp objectForKey:@"gamepointN"];
    _gamepoints[1] = [temp objectForKey:@"gamepointE"];
    _gamepoints[2] = [temp objectForKey:@"gamepointS"];
    _gamepoints[3] = [temp objectForKey:@"gamepointW"];
    
  }
  return self;
}

-(void) deltapointConversion:(NSMutableArray *) deltapoint {
  int gamepointsInt[4];
  double gamepoinsDelta[4];
  int gamepointsDeltaInt[4];
  
  for (int i = 0; i < 4; i++) {
    // scale deltapoint to gamepoints (* kScale)
    gamepoinsDelta[i] = kScale * [deltapoint[i] doubleValue];
    
    // convert to int and divide by 100 (trick for round int to right size)
    gamepointsDeltaInt[i] = ((int)gamepoinsDelta[i])/100;
    
    // create a temporary array of int from the _gamepoints NSNumbers.
    gamepointsInt[i] = [_gamepoints[i] intValue];
    
    // update the gamepoints
    gamepointsInt[i] += gamepointsDeltaInt[i];
    
    // assign the gamepoint to _gamepoint array.
    _gamepoints[i] = [NSNumber numberWithInt:gamepointsInt[i]];
  }

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
                                    [NSArray arrayWithObjects: _gamepoints[0], _gamepoints[1], _gamepoints[2], _gamepoints[3], nil]
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
