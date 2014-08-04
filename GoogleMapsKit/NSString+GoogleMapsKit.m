//
//  NSString+GoogleMapsKit.m
//  GoogleMapsKitDemo
//
//  Created by Main on 2013-02-15.
//  Copyright (c) 2013 fawkeswei. All rights reserved.
//

#import "NSString+GoogleMapsKit.h"

@implementation NSString (GoogleMapsKit)

//from http://stackoverflow.com/questions/8088473/url-encode-a-nsstring
- (NSString *)urlEncode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end
