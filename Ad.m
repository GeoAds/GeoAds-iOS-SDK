//
//  Ad.m
//  GeoAds iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/19/10.
//  Copyright 2010 Viewlity.com. All rights reserved.
//

#import "Ad.h"

@implementation Ad

@synthesize coordinate, title, subtitle, description, url;
@synthesize imageUrl, thumbnailUrl, image, thumbnail;

- (id)init
{
    self = [super init];
    if (self) 
	{
        self.title = nil;
        self.subtitle = nil;
        self.description = nil;
        self.url = nil;
        self.imageUrl = nil;
        self.thumbnailUrl = nil;
        self.image = nil;
        self.thumbnail = nil;
    }
    return self;
}

/* Init an Ad object with data from Ads server. 
 */
- (id)initWithTitle:(NSString *)adTitle 
           subtitle:(NSString *)adSubtitle 
        description:(NSString *)adDescription 
         coordinate:(CLLocationCoordinate2D)adCoordinates 
                url:(NSURL *)URL
           imageUrl:(NSURL *)imageURL 
       thumbnailUrl:(NSURL *)thumbnailURL;
{
    self = [super init];
    if (self) 
	{
        self.title = adTitle;
        self.subtitle = adSubtitle;
        self.description = adDescription;
        self.coordinate = adCoordinates;
        self.url = URL;
        self.imageUrl = imageURL;
        self.thumbnailUrl = thumbnailURL;
        self.image = nil;
        self.thumbnail = nil;
    }
    return self;
}

- (void)dealloc 
{
	[title release];
    [subtitle release];
    [description release];
    [url release];
    [imageUrl release];
    [thumbnailUrl release];
    [image release];
    [thumbnail release];
    [super dealloc];
}

/* Download the thumbnail image from thumbnailUrl. 
 * The thumbnail image will be available through the thumbnail property. 
 */
- (void)downloadThumbnail
{
    if (thumbnailUrl != nil)
    {
        NSData *thumbnailData = [NSData dataWithContentsOfURL:self.thumbnailUrl];
        if (thumbnailData != nil)
            self.thumbnail = [UIImage imageWithData:thumbnailData];
    }
}

/* Download the ad image from imageUrl. 
 * The ad image will be available through the image property. 
 */
- (void)downloadImage
{
    if (imageUrl != nil)
    {
        NSData *imageData = [NSData dataWithContentsOfURL:self.imageUrl];
        if (imageData != nil)
            self.image = [UIImage imageWithData:imageData];
    }
}

@end
