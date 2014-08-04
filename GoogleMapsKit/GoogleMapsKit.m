//
//  GoogleMapsKit.m
//  GoogleMapsKitDemo
//
//  Created by Fawkes Wei on 12/14/12.
//  Copyright (c) 2012 fawkeswei. All rights reserved.
//

#import "GoogleMapsKit.h"
#import "NSString+GoogleMapsKit.h"

NSString * const GoogleMapsURLScheme = @"comgooglemaps://?";
NSString * const GoogleMapsCallBackURLScheme = @"comgooglemaps-x-callback://?";

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
    [GoogleMapsKit showMapWithCenter:centerCoordinate zoom:zoom mapMode:mapMode view:view callbackAppName:nil callBackUrlScheme:nil];
}

+ (void)showMapWithCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view callbackAppName:(NSString *)callbackAppName callBackUrlScheme:(NSString *)callBackUrlScheme {
    NSMutableString *urlString = [GoogleMapsKit _parseCommonParamsWithCenter:centerCoordinate zoom:zoom mapMode:mapMode view:view callbackAppName:callbackAppName callBackUrlScheme:callBackUrlScheme];
    
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
    [GoogleMapsKit showMapWithSearchKeyword:keyword withCenter:centerCoordinate zoom:zoom mapMode:mapMode view:view callbackAppName:nil callBackUrlScheme:nil];
}

+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view callbackAppName:(NSString *)callbackAppName callBackUrlScheme:(NSString *)callBackUrlScheme {
    NSMutableString *urlString = [GoogleMapsKit _parseCommonParamsWithCenter:centerCoordinate zoom:zoom mapMode:mapMode view:view callbackAppName:callbackAppName callBackUrlScheme:callBackUrlScheme];
    [urlString appendFormat:@"&q=%@", keyword.urlEncode];
    
    if (urlString) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

+ (void)showMapWithDirectionsForDestinationAddress:(NSString *)daddr {
    [GoogleMapsKit showMapWithDirectionsForDestinationAddress:daddr directionsMode:-1];
}

+ (void)showMapWithDirectionsForDestinationAddress:(NSString *)daddr directionsMode:(GoogleMapsDirectionsMode)directionsMode {
    [GoogleMapsKit showMapWithDirectionsForStartAddress:nil destinationAddress:daddr directionsMode:directionsMode];
}

+ (void)showMapWithDirectionsForStartAddress:(NSString *)saddr destinationAddress:(NSString *)daddr directionsMode:(GoogleMapsDirectionsMode)directionsMode {
    [GoogleMapsKit showMapWithDirectionsForStartAddress:saddr destinationAddress:daddr directionsMode:directionsMode callbackAppName:nil callBackUrlScheme:nil];
}

+ (void)showMapWithDirectionsForStartAddress:(NSString *)saddr destinationAddress:(NSString *)daddr directionsMode:(GoogleMapsDirectionsMode)directionsMode callbackAppName:(NSString *)callbackAppName callBackUrlScheme:(NSString *)callBackUrlScheme {

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

    [GoogleMapsKit _showMapDirectionsWithStart:start destination:destination directionsMode:directionsMode callbackAppName:callbackAppName callBackUrlScheme:callBackUrlScheme];
}

+ (void)showMapWithDirectionsForEndPointCoordinate:(CLLocationCoordinate2D )endCoordinate {
    [GoogleMapsKit showMapWithDirectionsForEndPointCoordinate:endCoordinate directionsMode:-1];
}

+ (void)showMapWithDirectionsForEndPointCoordinate:(CLLocationCoordinate2D)endCoordinate directionsMode:(GoogleMapsDirectionsMode)directionsMode {
    [GoogleMapsKit showMapWithDirectionsForStartingPointCoordinate:kCLLocationCoordinate2DInvalid endPointCoordinate:endCoordinate directionsMode:directionsMode];
}

+ (void)showMapWithDirectionsForStartingPointCoordinate:(CLLocationCoordinate2D)startCoordinate endPointCoordinate:(CLLocationCoordinate2D)endCoordinate directionsMode:(GoogleMapsDirectionsMode)directionsMode {
    [GoogleMapsKit showMapWithDirectionsForStartingPointCoordinate:startCoordinate endPointCoordinate:endCoordinate directionsMode:directionsMode callbackAppName:nil callBackUrlScheme:nil];
}

+ (void)showMapWithDirectionsForStartingPointCoordinate:(CLLocationCoordinate2D)startCoordinate endPointCoordinate:(CLLocationCoordinate2D)endCoordinate directionsMode:(GoogleMapsDirectionsMode)directionsMode callbackAppName:(NSString *)callbackAppName callBackUrlScheme:(NSString *)callBackUrlScheme {
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

    [GoogleMapsKit _showMapDirectionsWithStart:start destination:destination directionsMode:directionsMode callbackAppName:callbackAppName callBackUrlScheme:callBackUrlScheme];
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

+ (void)_showMapDirectionsWithStart:(id)saddr destination:(id)daddr directionsMode:(GoogleMapsDirectionsMode)directionsMode callbackAppName:(NSString *)callbackAppName callBackUrlScheme:(NSString *)callBackUrlScheme {
    NSMutableString *urlString = [NSMutableString stringWithString:GoogleMapsURLScheme];
    if ([callbackAppName length] != 0 && [callBackUrlScheme length] != 0) {
        urlString = [NSMutableString stringWithString:GoogleMapsCallBackURLScheme];
        [urlString appendFormat:@"x-source=%@&x-success=%@", callbackAppName, callBackUrlScheme];
    }
    
    NSMutableArray *args = [NSMutableArray array];

    if ([saddr length] != 0) {
        [args addObject:saddr];
    }

    if ([daddr length] != 0) {
        [args addObject:daddr];
    }

    [args addObject:[NSString stringWithFormat:@"directionsmode=%@", [GoogleMapsKit stringFromGoogleMapsDirectionsMode:directionsMode]]];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[urlString stringByAppendingString:[args componentsJoinedByString:@"&"]]]];
}

+ (NSMutableString *)_parseCommonParamsWithCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view callbackAppName:(NSString *)callbackAppName callBackUrlScheme:(NSString *)callBackUrlScheme {
    NSMutableString *urlString = [NSMutableString stringWithString:GoogleMapsURLScheme];
    if ([callbackAppName length] != 0 && [callBackUrlScheme length] != 0) {
        urlString = [NSMutableString stringWithString:GoogleMapsCallBackURLScheme];
        [urlString appendFormat:@"x-source=%@&x-success=%@", callbackAppName, callBackUrlScheme];
    }
    
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
