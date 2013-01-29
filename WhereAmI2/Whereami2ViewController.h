//
//  Whereami2ViewController.h
//  WhereAmI2
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

// Conform to CLLocationManagerDelegate, MKMapViewDelegate and UITextFieldDelegate
@interface Whereami2ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    // Model
    CLLocationManager *locationManager;
    
    // Views Instance variables
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
}
@property (weak, nonatomic) IBOutlet UILabel *latlonLabel;

// findLocation will be sent in textFieldShouldReturn
- (void)findLocation;
// foundLocation: will be sent in locationManager:didUpdateToLocation:fromLocation
- (void)foundLocation:(CLLocation *)loc;

@end
