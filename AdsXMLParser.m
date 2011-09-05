//
//  AdsXMLParser.m
//  GeoAds+ iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/1/11.
//  Copyright 2011 Viewlity.com. All rights reserved.
//

#import "Ad.h"
#import "AdsXMLParser.h"

@implementation AdsXMLParser

+ (NSArray *)adsArrayFromXML:(NSString *)xml
{
    NSMutableArray *components = (NSMutableArray *)[xml componentsSeparatedByString:@"</ad>"];
    if ([components count] < 2) 
    {
        //The given XML has no ads.
        return nil;
    }
    
    /* The last component is not an Ad. It needs to be removed. */
    [components removeLastObject];
    NSMutableArray *ads = [[NSMutableArray alloc] initWithCapacity:[components count]];
    
    /* Extract data from each Ad tag. */
    for (NSString *adXML in components)
    {
        NSString *title = [self contentOfFirstTagWithName:@"title" 
                                                  fromXML:adXML];
        NSString *subtitle = [self contentOfFirstTagWithName:@"subtitle" 
                                                     fromXML:adXML];
        NSString *description = [self contentOfFirstTagWithName:@"description"
                                                        fromXML:adXML];
        float latitude = [[self contentOfFirstTagWithName:@"latitude" 
                                                  fromXML:adXML] floatValue];
        float longitude = [[self contentOfFirstTagWithName:@"longitude" 
                                                   fromXML:adXML] floatValue];
        NSString *urlString = [self contentOfFirstTagWithName:@"url" 
                                                      fromXML:adXML];
        NSString *imageUrlString = [self contentOfFirstTagWithName:@"image" 
                                                           fromXML:adXML];
        NSString *thumbnailUrlString = [self contentOfFirstTagWithName:@"thumbnail" 
                                                               fromXML:adXML];
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        NSURL *url = [NSURL URLWithString:urlString];
        NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
        NSURL *thumbnailUrl = [NSURL URLWithString:thumbnailUrlString];
        
        /* All data is extracted from Ad tag. 
         * Build the Ad object and add it to the array. */ 
        Ad *ad = [[Ad alloc] initWithTitle:title 
                                  subtitle:subtitle 
                               description:description 
                                coordinate:coordinate 
                                       url:url
                                  imageUrl:imageUrl 
                              thumbnailUrl:thumbnailUrl];
        [ads addObject:ad];
    }
    return (NSArray *)ads;
}

/* Convert special characters like &amp; or &#8217; to unicode characters.
 */
+ (NSString *)convertSpecialCharactersToUnicodeInXML:(NSString *)xml
{
    int i;
    xml = [xml stringByReplacingOccurrencesOfString:@"&amp;" 
                                         withString:@"&"];
    xml = [xml stringByReplacingOccurrencesOfString:@"&apos;" 
                                         withString:@"'"];
    xml = [xml stringByReplacingOccurrencesOfString:@"&quot;" 
                                         withString:@"\""];
    NSMutableArray *xmlComponents = (NSMutableArray *)[xml componentsSeparatedByString:@"&#"];
    for (i=1; i < [xmlComponents count]; i++)
    {
        NSString *xmlPart = [xmlComponents objectAtIndex:i];
        NSMutableArray *unicodeCharAndRest = (NSMutableArray *)[xmlPart componentsSeparatedByString:@";"];
        NSString *unicodeChar = [NSString stringWithFormat:@"%C",[[unicodeCharAndRest objectAtIndex:0] intValue]];
        [unicodeCharAndRest replaceObjectAtIndex:0 withObject:unicodeChar];
        NSString *newXmlPart = [unicodeCharAndRest componentsJoinedByString:@""];
        [xmlComponents replaceObjectAtIndex:i withObject:newXmlPart];
    }
    xml = [xmlComponents componentsJoinedByString:@""];
    return xml;
}

+ (NSString *)contentOfFirstTagWithName:(NSString *)tagName 
                                fromXML:(NSString *)xml
{
	NSArray *components1 = [xml componentsSeparatedByString:[NSString stringWithFormat:@"<%@",tagName]];
	if ([components1 count] < 2) return @"";
	NSArray *components2 = [[components1 objectAtIndex:1] componentsSeparatedByString:[NSString stringWithFormat:@"</%@>",tagName]];
	if ([components2 count] < 1) return @"";
	NSArray *components3 = [[components2 objectAtIndex:0] componentsSeparatedByString:@">"];
	if ([components3 count] < 2) return @"";
	NSString *tagContent = [(NSString *)[components3 objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	return tagContent;
}

@end
