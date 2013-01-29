//
//  Whereami2ViewController.m
//  WhereAmI2
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import "Whereami2ViewController.h"
#import "MapPoint.h"

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
    NSLog(@"New location: %@", newLocation);
    
    // How many seconds ago was this new location created?
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    // CLLocationManagers will return the last found location of the
    // device first, you don't want that data in this case.
    // If this location was made more than 3 minutes ago, ignore it.
    if (t < -180) {
        // This is cached data, you don't want it, keep looking
        return;
    }
    
    [self foundLocation:newLocation];
    self.latlonLabel.text = [NSString stringWithFormat:@"%@", [newLocation description]];
    
}

//  If the CLLocationManager fails to find its location, It sends a message to its delegate:
// locationManager:didFailWithError:. implementing this method here
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
    self.latlonLabel.text = [NSString stringWithFormat:@"Can't find location"];
}

// Implement delegate method of mapview when userlocation is found
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"MKMapview: method sent back to ViewController delegate");
    NSLog(@"MKMapview:User location found");
    
    // Now need to zoom in with a 25mx250m Region around the center point
    // userLocation which we will convert to CLLocationCoordinate2D
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
          
}

// Implement delegate method "textFieldShouldReturn:" to catch the user pressing
// "Done" on the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)txtField
{
    // This method isn't implemented yet - but will be soon.
    [self findLocation];
    
    [txtField resignFirstResponder];
    
    return YES;
}

// The findLocation method will tell the locationManager to start looking for the
// current location. It will also update the user interface so that the user can’t
// re-enter text into the text field and will start the activity indicator spinning.
- (void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

// The foundLocation: method will create an instance of MapPoint and add it to the
// worldView. It will also handle the map’ s zoom and reset the states of the UI
// elements and the locationManager.
- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    
    // Create an instance of MapPoint with the current data
    MapPoint *mp = [[MapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    
    // Add it to the map view
    [worldView addAnnotation:mp];
    
    // Zoom the region to this location
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}
@end
