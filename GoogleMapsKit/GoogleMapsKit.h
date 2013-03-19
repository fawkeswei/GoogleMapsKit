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
    GoogleMapsModeStreetView,
} GoogleMapsMode;

typedef enum {
    GoogleMapsDirectionsModeDriving,
    GoogleMapsDirectionsModeTransit,
    GoogleMapsDirectionsModeWalking
} GoogleMapsDirectionsMode;

@interface GoogleMapsKit : NSObject

+ (BOOL)isGoogleMapsInstalled;

+ (void)showMapWithCenter:(CLLocationCoordinate2D )centerCoordinate;
+ (void)showMapWithCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom;
+ (void)showMapWithCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view;

+ (void)showMapWithSearchKeyword:(NSString *)keyword;
+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate;
+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom;
+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view;

+ (void)showMapWithDirectionsForDestinationAddress:(NSString *)daddr;
+ (void)showMapWithDirectionsForDestinationAddress:(NSString *)daddr directionsMode:(GoogleMapsDirectionsMode )directionsMode;
+ (void)showMapWithDirectionsForStartAddress:(NSString *)saddr destinationAddress:(NSString *)daddr directionsMode:(GoogleMapsDirectionsMode )directionsMode;

+ (void)showMapWithDirectionsForEndPointCoordinate:(CLLocationCoordinate2D )endCoordinate;
+ (void)showMapWithDirectionsForEndPointCoordinate:(CLLocationCoordinate2D )endCoordinate directionsMode:(GoogleMapsDirectionsMode )directionsMode;
+ (void)showMapWithDirectionsForStartingPointCoordinate:(CLLocationCoordinate2D )startCoordinate endPointCoordinate:(CLLocationCoordinate2D )endCoordinate directionsMode:(GoogleMapsDirectionsMode )directionsMode;

@end
