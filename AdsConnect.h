//
//  AdsConnect.h
//  GeoAds iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/1/11.
//  Copyright 2011 Viewlity.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "AdImageConnect.h"

/* The AdsConnectDelegate is defined below. This is only a reference. */
@protocol AdsConnectDelegate;

@interface AdsConnect : NSObject  <AdImageConnectDelegate>
{
    NSString *appKey;
    NSMutableData *webData;
    NSMutableDictionary *imageService;
    id<AdsConnectDelegate> delegate;
}

@property (nonatomic, retain) NSString *appKey;
@property (nonatomic, retain) id<AdsConnectDelegate> delegate;

/* Init an AdsConnect object with your generated appKey. 
 */
- (id)initWithAppKey:(NSString *)key;

/* Request ads from a specific location.
 * The location is given through the <coordinate> parameter.
 * This call will request only one Ad. 
 */
- (BOOL)requestAdsFromLocation:(CLLocationCoordinate2D)coordinate;

/* Request ads from a specific location.
 * The location is given through the <coordinate> parameter.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30. 
 * The returned ads will be sorted by "performance" by default. 
 */
- (BOOL)requestAdsFromLocation:(CLLocationCoordinate2D)coordinate 
                         limit:(NSInteger)limit;

/* Request ads from a specific location.
 * The location is given through the <coordinate> parameter.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30.
 * The returned Ads can be sorted by "performance" or by "location". 
 */
- (BOOL)requestAdsFromLocation:(CLLocationCoordinate2D)coordinate 
                         limit:(NSInteger)limit 
                        sortBy:(NSString *)sortOption;

/* Request ads from a specific location.
 * The location is given through the <latitude> and <longitude> parameters.
 * This call will request only one Ad. 
 */
- (BOOL)requestAdsFromLatitude:(CLLocationDegrees)latitude 
                     longitude:(CLLocationDegrees)longitude;

/* Request ads from a specific location. 
 * The location is given through the <latitude> and <longitude> parameters.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30. 
 * The returned ads will be sorted by "performance" by default. 
 */
- (BOOL)requestAdsFromLatitude:(CLLocationDegrees)latitude 
                     longitude:(CLLocationDegrees)longitude 
                         limit:(NSInteger)limit;

/* Request ads from a specific location. 
 * The location is given through the <latitude> and <longitude> parameters.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30.
 * The returned Ads can be sorted by "performance" or by "location". 
 */
- (BOOL)requestAdsFromLatitude:(CLLocationDegrees)latitude 
                     longitude:(CLLocationDegrees)longitude 
                         limit:(NSInteger)limit 
                        sortBy:(NSString *)sortOption;

/* Request ad image/thumbnail from url.
 * This method can be used to send multiple image requests.
 * If there is another request for the same image, this method
 * will return NO and it will not send a new request 
 * until the previous request will have finished.
 */
- (BOOL)requestAdImageFromURL:(NSURL *)url;

@end

@protocol AdsConnectDelegate <NSObject>

/* Called when an error prevents the request from completing successfully.
 */
- (void)adsRequestDidFailWithError:(NSError *)error;

/* Called when a request returns and its response has been parsed into an object.
 * The result object may be an array, a dictionary or a string, depending on the format 
 * of the API response.
 * 1. The result may be an NSArray of ads. 
 * 2. The result may be an NSDictionary containing an NSURL and a UIImage.
 * 3. The result may be an NSString if the server can't return any nearby ad.
 */
- (void)adsRequestDidLoad:(id)result;

@end
