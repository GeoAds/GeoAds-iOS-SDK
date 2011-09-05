//
//  AdImageConnect.h
//  GeoAds+ iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/18/11.
//  Copyright 2011 Viewlity.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/* The AdImageConnectDelegate is defined below. This is only a reference. */
@protocol AdImageConnectDelegate;

@interface AdImageConnect : NSObject 
{
    NSURL *url;
    NSMutableData *webData;
    id<AdImageConnectDelegate> delegate;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) id<AdImageConnectDelegate> delegate;

/* Init an AdImageConnect object with an image/thumbnail url. 
 */
- (id)initWithURL:(NSURL *)URL;

/* Request image from url. 
 */
- (BOOL)requestImage;

@end

@protocol AdImageConnectDelegate <NSObject>

/* Called when an error prevents the request from completing successfully.
 */
- (void)adImageRequestDidFailWithError:(NSError *)error 
                                forURL:(NSURL *)url;

/* Called when a request returns and its response has been parsed into an UIImage.
 */
- (void)adImageRequestDidLoad:(UIImage *)result 
                       forURL:(NSURL *)url;

@end
