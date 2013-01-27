//
//  MapPoint.m
//  WhereAmI2
//
//  Created by Fabrice Guillaume on 1/27/13.
//  Copyright (c) 2013 Fabrice Guillaume. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint

// synthetise both properties
@synthesize coordinate, title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self) {
        coordinate = c;
        [self setTitle:t];
    }
    return self;
}



@end
