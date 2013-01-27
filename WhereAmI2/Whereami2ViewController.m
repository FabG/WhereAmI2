//
//  Whereami2ViewController.m
//  WhereAmI2
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import "Whereami2ViewController.h"

@interface Whereami2ViewController ()

@end

@implementation Whereami2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Create location manager object
    locationManager = [[CLLocationManager alloc] init];
    
    //DELEGATION
    // There will be a warning from this line of code if I don't add the <CLLocationManagerDelegate> to
    // declare that Whereami2ViewController conforms to the CLLocationManagerDelegate protocol
    //Set the delegate property of the location manager to be the instance of Whereami2Viewcontroller
    [locationManager setDelegate:self];
    
    // We want all results from the location manager
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    // And we want it to be as accurate as possible
    // regardless of how much time/power it takes
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    
    // Tell our manager to start looking for its location immediately
    // not necessary now with the MKMapView instance that knows ow to find the location
    [locationManager startUpdatingLocation];
    
    // set the showsUserLocation property of an MKMapView to YES to show the user’s location on the map
    [worldView setShowsUserLocation:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// CLLocationManager sends locationManager:didUpdateToLocation:fromLocation:
// to the instance of Whereami2Viewcontroller, so implementing this method here
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
}

//  If the CLLocationManager fails to find its location, It sends a message to its delegate:
// locationManager:didFailWithError:. implementing this method here
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

@end
