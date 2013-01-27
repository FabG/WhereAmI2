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

@interface Whereami2ViewController : UIViewController <CLLocationManagerDelegate>
{
    // Model
    CLLocationManager *locationManager;
    
    // Views Instance variables
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
}
@end
