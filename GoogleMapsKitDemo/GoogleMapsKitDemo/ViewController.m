//
//  ViewController.m
//  GoogleMapsKitDemo
//
//  Created by Fawkes Wei on 12/14/12.
//  Copyright (c) 2012 fawkeswei. All rights reserved.
//

#import "ViewController.h"
#import "GoogleMapsKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launchGoogleMaps:(id)sender {
    if ([GoogleMapsKit isGoogleMapsInstalled]) {
        [GoogleMapsKit showMapWithCenter:CLLocationCoordinate2DMake(25.0, 121.5)
                                    zoom:14
                                 mapMode:GoogleMapsModeDefault
                                    view:GoogleMapsViewClearAll];
    }
}

- (IBAction)searchGoogleMaps:(id)sender {
    if ([GoogleMapsKit isGoogleMapsInstalled]) {
        [GoogleMapsKit showMapWithSearchKeyword:@"Starbucks"
                                     withCenter:CLLocationCoordinate2DMake(25.0, 121.5)
                                           zoom:15
                                        mapMode:GoogleMapsModeDefault
                                           view:GoogleMapsViewTraffic];
    }
}
@end
