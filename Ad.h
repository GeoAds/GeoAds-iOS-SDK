//
//  Ad.h
//  GeoAds+ iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/19/10.
//  Copyright 2010 Viewlity.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Ad : NSObject
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
    NSString *description;
    NSURL *url;
    NSURL *imageUrl;
    NSURL *thumbnailUrl;
    UIImage *image;
    UIImage *thumbnail;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSURL *imageUrl;
@property (nonatomic, retain) NSURL *thumbnailUrl;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *thumbnail;

/* Init an Ad object with data from Ads server. 
 */
- (id)initWithTitle:(NSString *)adTitle 
           subtitle:(NSString *)adSubtitle 
        description:(NSString *)adDescription 
         coordinate:(CLLocationCoordinate2D)adCoordinates 
                url:(NSURL *)URL
           imageUrl:(NSURL *)imageURL 
       thumbnailUrl:(NSURL *)thumbnailURL;

/* Download the thumbnail image from thumbnailUrl. 
 * The thumbnail image will be available through the thumbnail property. 
 */
- (void)downloadThumbnail;

/* Download the ad image from imageUrl. 
 * The ad image will be available through the image property. 
 */
- (void)downloadImage;

@end