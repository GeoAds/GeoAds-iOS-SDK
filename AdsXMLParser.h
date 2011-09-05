//
//  AdsXMLParser.h
//  GeoAds+ iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/1/11.
//  Copyright 2011 Viewlity.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdsXMLParser : NSObject 
{}

/* Parses the given XML and returns an array of Ads. 
 */
+ (NSArray *)adsArrayFromXML:(NSString *)xml;

/* Convert special characters like &amp; or &#8217; to unicode characters.
 */
+ (NSString *)convertSpecialCharactersToUnicodeInXML:(NSString *)xml;

/* Returns the content of a tag from an XML file. 
 */
+ (NSString *)contentOfFirstTagWithName:(NSString *)tagName 
                                fromXML:(NSString *)xml;

@end
