//
//  GoogleMapsKit.m
//  GoogleMapsKitDemo
//
//  Created by Fawkes Wei on 12/14/12.
//  Copyright (c) 2012 fawkeswei. All rights reserved.
//

#import "GoogleMapsKit.h"

#define kCONST_PREFIX @"comgooglemaps://"

@implementation GoogleMapsKit

+ (BOOL)isGoogleMapsInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kCONST_PREFIX]];
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

+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate {
    [GoogleMapsKit showMapWithSearchKeyword:keyword withCenter:centerCoordinate zoom:-1];
}

+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom {
    [GoogleMapsKit showMapWithSearchKeyword:keyword withCenter:centerCoordinate zoom:zoom mapMode:GoogleMapsModeDefault view:GoogleMapsViewClearAll];
}

+ (void)showMapWithSearchKeyword:(NSString *)keyword withCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view {
    
    NSMutableString *urlString = [GoogleMapsKit _parseCommonParamsWithCenter:centerCoordinate zoom:zoom mapMode:mapMode view:view];
    [urlString appendFormat:@"&q=%@", [keyword stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    if (urlString) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
}

#pragma mark - Private Methods

+ (NSMutableString *)_parseCommonParamsWithCenter:(CLLocationCoordinate2D )centerCoordinate zoom:(NSInteger )zoom mapMode:(GoogleMapsMode )mapMode view:(GoogleMapsView )view {
    NSMutableString *urlString = [NSMutableString stringWithString:kCONST_PREFIX];
    
    if (CLLocationCoordinate2DIsValid(centerCoordinate)) {
        [urlString appendFormat:@"?center=%f,%f", centerCoordinate.latitude, centerCoordinate.longitude];
    } else {
        return nil;
    }
    
    if (zoom > 0) {
        [urlString appendFormat:@"&zoom=%d", zoom];
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
