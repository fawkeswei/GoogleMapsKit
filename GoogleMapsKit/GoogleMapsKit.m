//
//  GoogleMapsKit.m
//  GoogleMapsKitDemo
//
//  Created by Fawkes Wei on 12/14/12.
//  Copyright (c) 2012 fawkeswei. All rights reserved.
//

#import "GoogleMapsKit.h"
#import "NSString+GoogleMapsKit.h"

NSString * const GoogleMapsURLScheme = @"comgooglemaps-x-callback://";

@implementation GoogleMapsKit

+ (BOOL)isGoogleMapsInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:GoogleMapsURLScheme]];
}

+ (void)showMapWithCenter:(CLLocationCoordinate2D )centerCoordinate {
    [GoogleMapsKit showMapWithCenter:centerCoordinate zoom:-1];
}

+ (void)showMapWithCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom {
    [GoogleMapsKit showMapWithCenter:centerCoordinate zoom:zoom mapMode:GoogleMapsModeDefault view:GoogleMapsViewClearAll];
}

+ (void)showMapWithCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view {
    NSMutableString *urlString = [GoogleMapsKit _parseCommonParamsWithCenter:centerCoordinate zoom:zoom mapMode:mapMode view:view];
    
    if (urlString) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

+ (void)showMapWithSearchKeyword:(NSString *)keyword {
    [GoogleMapsKit showMapWithSearchKeyword:keyword withCenter:kCLLocationCoordinate2DInvalid zoom:-1];
}

+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate {
    [GoogleMapsKit showMapWithSearchKeyword:keyword withCenter:centerCoordinate zoom:-1];
}

+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom {
    [GoogleMapsKit showMapWithSearchKeyword:keyword withCenter:centerCoordinate zoom:zoom mapMode:GoogleMapsModeDefault view:GoogleMapsViewClearAll];
}

+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view {
    NSMutableString *urlString = [GoogleMapsKit _parseCommonParamsWithCenter:centerCoordinate zoom:zoom mapMode:mapMode view:view];
    [urlString appendFormat:@"&q=%@", keyword.urlEncode];
    
    if (urlString) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

+ (void)showMapWithDirectionsForDestinationAddress:(NSString *)daddr {
    [self showMapWithDirectionsForDestinationAddress:daddr directionsMode:-1];
}

+ (void)showMapWithDirectionsForDestinationAddress:(NSString *)daddr directionsMode:(GoogleMapsDirectionsMode)directionsMode {
    [self showMapWithDirectionsForStartAddress:nil destinationAddress:daddr directionsMode:directionsMode];
}

+ (void)showMapWithDirectionsForStartAddress:(NSString *)saddr destinationAddress:(NSString *)daddr directionsMode:(GoogleMapsDirectionsMode)directionsMode {

    NSString *start = nil;

    NSString *destination = nil;

    if ([saddr length] > 0) {
        start = [NSString stringWithFormat:@"saddr=%@", [saddr urlEncode]];
    }
    else {
        start = @"saddr="; // leave it blank and google maps will use current location
    }

    if ([daddr length] > 0) {
        destination = [NSString stringWithFormat:@"daddr=%@", [daddr urlEncode]];
    }
    else {
        destination = @"";
    }

    [self _showMapDirectionsWithStart:start destination:destination directionsMode:directionsMode];
}

+ (void)showMapWithDirectionsForEndPointCoordinate:(CLLocationCoordinate2D )endCoordinate {
    [self showMapWithDirectionsForEndPointCoordinate:endCoordinate directionsMode:-1];
}

+ (void)showMapWithDirectionsForEndPointCoordinate:(CLLocationCoordinate2D)endCoordinate directionsMode:(GoogleMapsDirectionsMode)directionsMode {
    [self showMapWithDirectionsForStartingPointCoordinate:kCLLocationCoordinate2DInvalid endPointCoordinate:endCoordinate directionsMode:directionsMode];
}

+ (void)showMapWithDirectionsForStartingPointCoordinate:(CLLocationCoordinate2D)startCoordinate endPointCoordinate:(CLLocationCoordinate2D)endCoordinate directionsMode:(GoogleMapsDirectionsMode)directionsMode {
    NSString * start = nil;

    NSString * destination = nil;

    if (CLLocationCoordinate2DIsValid(startCoordinate) && startCoordinate.latitude != 0 && startCoordinate.longitude != 0) {
        start = [NSString stringWithFormat:@"saddr=%f,%f", startCoordinate.latitude, startCoordinate.longitude];
    }
    else {
        start = @"saddr="; // leave it blank and google maps will use current location
    }

    if (CLLocationCoordinate2DIsValid(endCoordinate)) {
        destination = [NSString stringWithFormat:@"daddr=%f,%f", endCoordinate.latitude, endCoordinate.longitude];
    }

    [self _showMapDirectionsWithStart:start destination:destination directionsMode:directionsMode];
}

#pragma mark - Private Methods

+ (NSString *)stringFromGoogleMapsDirectionsMode:(GoogleMapsDirectionsMode)mode {
    switch (mode) {
        case GoogleMapsDirectionsModeDriving: return @"driving";
        case GoogleMapsDirectionsModeTransit: return @"transit";
        case GoogleMapsDirectionsModeWalking: return @"walking";
        case GoogleMapsDirectionsModeBicycling: return @"bicycling";
        default: return @"";
    }
}

+ (void)_showMapDirectionsWithStart:(id)saddr destination:(id)daddr directionsMode:(GoogleMapsDirectionsMode)directionsMode {
    NSMutableArray *args = [NSMutableArray array];

    if ([saddr length] != 0) {
        [args addObject:saddr];
    }

    if ([daddr length] != 0) {
        [args addObject:daddr];
    }

    [args addObject:[NSString stringWithFormat:@"directionsmode=%@", [GoogleMapsKit stringFromGoogleMapsDirectionsMode:directionsMode]]];

    NSString *urlString = [NSString stringWithFormat:@"%@%@", GoogleMapsURLScheme, [args componentsJoinedByString:@"&"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

+ (NSMutableString *)_parseCommonParamsWithCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view {
    NSMutableString *urlString = [NSMutableString stringWithString:GoogleMapsURLScheme];
    
    if (CLLocationCoordinate2DIsValid(centerCoordinate)) {
        [urlString appendFormat:@"center=%f,%f", centerCoordinate.latitude, centerCoordinate.longitude];
    }
    
    if (zoom > 0) {
        [urlString appendFormat:@"&zoom=%@", @(zoom)];
    }
    
    switch (mapMode) {
        case GoogleMapsModeStandard:
            [urlString appendString:@"&mapmode=standard"];
            break;
        case GoogleMapsModeStreetView:
            [urlString appendString:@"&mapmode=streetview"];
            break;
        case GoogleMapsModeDefault:
            break;
        default:
            break;
    }
    
    switch (view) {
        case GoogleMapsViewSatellite:
            [urlString appendString:@"&views=satellite"];
            break;
        case GoogleMapsViewTraffic:
            [urlString appendString:@"&views=traffic"];
            break;
        case GoogleMapsViewTransit:
            [urlString appendString:@"&views=transit"];
            break;
        case GoogleMapsViewClearAll:
            break;
        default:
            break;
    }
    return urlString;
}


@end
