//
//  GoogleMapsKit.h
//  GoogleMapsKitDemo
//
//  Created by Fawkes Wei on 12/14/12.
//  Copyright (c) 2012 fawkeswei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum {
    GoogleMapsViewSatellite,
    GoogleMapsViewTraffic,
	GoogleMapsViewTransit,
    GoogleMapsViewClearAll,
} GoogleMapsView;

typedef enum {
    GoogleMapsModeDefault,
    GoogleMapsModeStandard,
    GoogleMapsModeStreedView,
} GoogleMapsMode;


@interface GoogleMapsKit : NSObject

+ (BOOL)isGoogleMapsInstalled;

+ (void)showMapWithCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view;

+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view;

@end
