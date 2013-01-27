//
//  MapPoint.h
//  WhereAmI2
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

// declare that MapPoint conforms to MKAnnotation protocol
@interface MapPoint : NSObject  <MKAnnotation>
{
    NSString *title;
    CLLocationCoordinate2D coordinate;
}


// A new designated initializer for instances of MapPoint
- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

// This is a required property from MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

// This is an optional property from MKAnnotation
@property (nonatomic, copy) NSString *title;

@end
