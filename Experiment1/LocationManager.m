//
//  LocationManager.m
//  Experiment1
//
//  Created by Constantijn Smit on 16-12-13.
//  Copyright (c) 2013 Constantijn Smit. All rights reserved.
//


#import "LocationManager.h"

// Define the maximum amount of time that is allowed to pass between now and the most recent location update.
#define kMaxRecentEventSeconds 5.0

// maxSpeed is the maximum allowed speed of the user in meters/second.
static const double maxSpeed = 4.72223; // approx. 17 km/h

@interface LocationManager ()
{
  CLLocationManager *locationManager;
  NSNumber *north, *south, *east, *west;

}
@end

@implementation LocationManager

- (id) init {
  if (self = [super init]) {
    
    // check if deltaPoint exists -> create.
    if (_deltapoint == nil) {
      _deltapoint = [[NSMutableArray alloc] init];
    }
  }
  return self;
}

// Start retrieving location Updates
- (void)startStandardUpdates
{
  // Create the location manager if this object does not already have one.
  if (nil == locationManager)
  {
    locationManager = [[CLLocationManager alloc] init];
  }
  
  locationManager.delegate = self;
  locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
  
  // Set a movement threshold for new events.
  locationManager.distanceFilter = 50;
  
  if ([CLLocationManager locationServicesEnabled])
  {
    [locationManager startUpdatingLocation];
  } else
  {
    // Starting the location manager if it is not enabled will prompt the user to activate location services. TO BE REFINED!!!!
    [locationManager startUpdatingLocation];
  }

}

-(void) stopStandardUpdates
{
  [locationManager stopUpdatingLocation];
  [self didStopUpdating];
}

#pragma mark - delegate methods for location manager

// What will happen when new location data arrives is specified here.
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  // If it's a relatively recent event, turn off updates to save power (&to avoid fetching cached events).
  CLLocation* location = [locations lastObject];
  NSDate* eventDate = location.timestamp;
  NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
  if (abs(howRecent) < kMaxRecentEventSeconds)
  {
    // If the event is recent, check if it is accurate (GPS location has been found)
    if (([location horizontalAccuracy] > 0) && ([location horizontalAccuracy] < 20)) {
      
     // create location
      CLLocation *location = [locationManager location];
      
      if (!location)
      {
        return;
      }
      
      // create a coordinate for the received location.
      CLLocationCoordinate2D coordinate = [location coordinate];
      
      // Create a location-object for the coordinate if it doesn't exist already.
      if (_previousLocation == nil) {
        _previousLocation = location;
      } else {
        // calculate the speed of movement by comparing the current location vs _previousLocation
        // with time interval.
        // if the speed is too fast for walking, abort -> alert.
        CLLocationDistance distance = [location distanceFromLocation:_previousLocation];
        NSTimeInterval moveDuration = [eventDate timeIntervalSinceDate:_previousLocation.timestamp];
        double speed = distance / moveDuration;
        
        if (speed > maxSpeed) {
          NSLog(@"You're going too fast! Location update discarded.");
          //TO DO: send alert to UIAlertView managed by MainViewController.
          UIAlertView *tooFastAlert = [[UIAlertView alloc] initWithTitle:@"This app is made for walking." message:@"You're travelling to fast. Please slow down. Current data will be discarded and tracking disabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
          [tooFastAlert show];
          
          // stop updating for location
          [self stopStandardUpdates];
          
          
          // remove data from _previousLocation. When updating is restarted first coordinate is then refreshed.
          _previousLocation = nil;
          
          return;
        }
        
        // calculate difference (delta) between current coordinate and coordinate of previousLocation
        CLLocationCoordinate2D previousCoordinate = [_previousLocation coordinate];
        double deltaLatitude;
        double deltaLongitude;
        deltaLatitude = coordinate.latitude - previousCoordinate.latitude;
        deltaLongitude = coordinate.longitude - previousCoordinate.longitude;
        
        // assign delta's to deltaPoint north, south, west, east
        if (deltaLatitude > 0) {
          _deltapoint[0] = [NSNumber numberWithDouble:deltaLatitude]; // if deltaLatitude is positive, move is northwards.
        } else {
          _deltapoint[2] = [NSNumber numberWithDouble:deltaLatitude*-1]; // if deltaLatitude is negative, move is southwards.
        }
        
        if (deltaLongitude > 0) {
          _deltapoint[1] = [NSNumber numberWithDouble:deltaLongitude]; // if deltaLongitude is positive, move is eastwards.
        } else {
          _deltapoint[3] = [NSNumber numberWithDouble:deltaLongitude*-1]; // if deltaLongitude is negative, move is westwards.
        }
        
        // replace the previousLocation with the currentLocation
        _previousLocation = location;
        
        // inform the delegate (hub) that deltaPoint has been updated.
        [self didUpdateDeltapoint];
      }
    }
  }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  // TO BE REFINED!!!
}

-(void) didUpdateDeltapoint {
  [self.delegate didUpdateDeltapoint];
}

-(void) didStopUpdating {
  [self.delegate didStopUpdating];
}
@end
