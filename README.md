#GoogleMapsKit ![build_status](https://www.cisimple.com/jobs/u8m5fmtnl7rykh7k7/build_status.png)

Launch native Google Maps for iPhone right from your app.

Find Google Maps custom url documentation [here](https://developers.google.com/maps/documentation/ios/urlscheme) 


#Usage

Test if Google Maps for iPhone installed

	if ([GoogleMapsKit isGoogleMapsInstalled]) {
		// Google Maps Installed!
	}
    	
Launch Google Maps

	[GoogleMapsKit showMapWithCenter:CLLocationCoordinate2DMake(25.0, 121.5)
	                            zoom:14
	                         mapMode:GoogleMapsModeDefault
	                            view:GoogleMapsViewClearAll];

	
Search Google Maps with keyword

	[GoogleMapsKit showMapWithSearchKeyword:@"Starbucks"
	                             withCenter:CLLocationCoordinate2DMake(25.0, 121.5)
	                                   zoom:15
	                                mapMode:GoogleMapsModeDefault
	                                   view:GoogleMapsViewTraffic];

	

See `GoogleMapsKit.h` for more convenience methods.

#Install

Two ways to install

1. Drag `GoogleMapsKit/` folder to your project.
2. Use [Cocoapods](https://github.com/CocoaPods/CocoaPods)

#Todo

Launch Google Maps with directions

#License

Copyright (C) 2013 Fawkes Wei

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
