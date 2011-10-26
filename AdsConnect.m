//
//  AdsConnect.m
//  GeoAds+ iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/1/11.
//  Copyright 2011 Viewlity.com. All rights reserved.
//

#import "AdsXMLParser.h"
#import "AdsConnect.h"

static NSString *kAdsServerURL = @"http://www.geoadsplus.com/ads.xml";  

@implementation AdsConnect

@synthesize appKey, delegate;

- (id)init
{
    self = [super init];
    if (self) 
	{
        self.appKey = nil;
        webData = nil;
        imageService = [[NSMutableDictionary alloc] initWithCapacity:1];
        self.delegate = nil;
    }
    return self;
}

/* Init an AdsConnect object with your generated appKey. 
 */
- (id)initWithAppKey:(NSString *)key
{
    self = [self init];
    if (self) 
	{
        self.appKey = key;
    }
    return self;
}

- (void)dealloc 
{
    [appKey release];
    [webData release];
    [imageService release];
    [super dealloc];
}

/* Request ads from a specific location.
 * The location is given through the <coordinate> parameter.
 * This call will request only one Ad. 
 */
- (BOOL)requestAdsFromLocation:(CLLocationCoordinate2D)coordinate 
{
    /* If the previous request did finish loading (or did fail)
     * then we can send a new request to the ads server and return YES.
     * else return NO. */
    if (webData != nil) 
    {
        NSLog(@"AdsConnect: Previous request should finish loading before starting a new request.");
        return NO;
    }
    if (appKey == nil)
    {
        NSLog(@"AdsConnect: You must set your app key before sending a request using this method.");
        return NO;
    }
    if (delegate == nil)
    {
        NSLog(@"AdsConnect: No delegate object. You must set a delegate object before sending any request. ");
        return NO;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@?udid=%@&app_key=%@&latitude=%f&longitude=%f",
                           kAdsServerURL,
                           [[UIDevice currentDevice] uniqueIdentifier],
                           self.appKey, 
                           coordinate.latitude, 
                           coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url 
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                          timeoutInterval:90];
    [requestObj setHTTPMethod:@"GET"];
    
    NSURLConnection *adsServerConnection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];
    if (adsServerConnection != nil)
    {
        webData = [[NSMutableData data] retain];
        return YES;
    }
    return NO;
}

/* Request ads from a specific location.
 * The location is given through the <coordinate> parameter.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30. 
 * The returned ads will be sorted by "performance" by default. 
 */
- (BOOL)requestAdsFromLocation:(CLLocationCoordinate2D)coordinate 
                         limit:(NSInteger)limit
{
    /* If the previous request did finish loading (or did fail)
     * then we can send a new request to the ads server and return YES.
     * else return NO. */
    if (webData != nil) 
    {
        NSLog(@"AdsConnect: Previous request should finish loading before starting a new request.");
        return NO;
    }
    if (appKey == nil)
    {
        NSLog(@"AdsConnect: You must set your app key before sending a request using this method.");
        return NO;
    }
    if (delegate == nil)
    {
        NSLog(@"AdsConnect: No delegate object. You must set a delegate object before sending any request. ");
        return NO;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@?udid=%@&app_key=%@&latitude=%f&longitude=%f&limit=%d",
                           kAdsServerURL,
                           [[UIDevice currentDevice] uniqueIdentifier],
                           self.appKey, 
                           coordinate.latitude, 
                           coordinate.longitude,
                           limit];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url 
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                          timeoutInterval:90];
    [requestObj setHTTPMethod:@"GET"];
    
    NSURLConnection *adsServerConnection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];
    if (adsServerConnection != nil)
    {
        webData = [[NSMutableData data] retain];
        return YES;
    }
    return NO;
}

/* Request ads from a specific location.
 * The location is given through the <coordinate> parameter.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30. 
 * The returned ads will be sorted by "performance" by default.
 * This call will return Ads from specified <categoryList>.
 */
- (BOOL)requestAdsFromLocation:(CLLocationCoordinate2D)coordinate 
                         limit:(NSInteger)limit
                      category:(NSString *)categoryList
{
    /* If the previous request did finish loading (or did fail)
     * then we can send a new request to the ads server and return YES.
     * else return NO. */
    if (webData != nil) 
    {
        NSLog(@"AdsConnect: Previous request should finish loading before starting a new request.");
        return NO;
    }
    if (appKey == nil)
    {
        NSLog(@"AdsConnect: You must set your app key before sending a request using this method.");
        return NO;
    }
    if (delegate == nil)
    {
        NSLog(@"AdsConnect: No delegate object. You must set a delegate object before sending any request. ");
        return NO;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@?udid=%@&app_key=%@&latitude=%f&longitude=%f&limit=%d&category=%@",
                           kAdsServerURL,
                           [[UIDevice currentDevice] uniqueIdentifier],
                           self.appKey, 
                           coordinate.latitude, 
                           coordinate.longitude,
                           limit,
                           categoryList];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url 
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                          timeoutInterval:90];
    [requestObj setHTTPMethod:@"GET"];
    
    NSURLConnection *adsServerConnection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];
    if (adsServerConnection != nil)
    {
        webData = [[NSMutableData data] retain];
        return YES;
    }
    return NO;
}

/* Request ads from a specific location.
 * The location is given through the <coordinate> parameter.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30.
 * The returned Ads can be sorted by "performance" or by "location". 
 */
- (BOOL)requestAdsFromLocation:(CLLocationCoordinate2D)coordinate 
                         limit:(NSInteger)limit 
                        sortBy:(NSString *)sortOption
{
    /* If the previous request did finish loading (or did fail)
     * then we can send a new request to the ads server and return YES.
     * else return NO. */
    if (webData != nil) 
    {
        NSLog(@"AdsConnect: Previous request should finish loading before starting a new request.");
        return NO;
    }
    if (appKey == nil)
    {
        NSLog(@"AdsConnect: You must set your app key before sending a request using this method.");
        return NO;
    }
    if (delegate == nil)
    {
        NSLog(@"AdsConnect: No delegate object. You must set a delegate object before sending any request. ");
        return NO;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@?udid=%@&app_key=%@&latitude=%f&longitude=%f&limit=%d&sort_by=%@",
                           kAdsServerURL,
                           [[UIDevice currentDevice] uniqueIdentifier],
                           self.appKey, 
                           coordinate.latitude, 
                           coordinate.longitude,
                           limit,
                           sortOption];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url 
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                          timeoutInterval:90];
    [requestObj setHTTPMethod:@"GET"];
    
    NSURLConnection *adsServerConnection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];
    if (adsServerConnection != nil)
    {
        webData = [[NSMutableData data] retain];
        return YES;
    }
    return NO;
}

/* Request ads from a specific location.
 * The location is given through the <coordinate> parameter.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30.
 * The returned Ads can be sorted by "performance" or by "location".
 * This call will return Ads from specified <categoryList>.
 */
- (BOOL)requestAdsFromLocation:(CLLocationCoordinate2D)coordinate 
                         limit:(NSInteger)limit 
                        sortBy:(NSString *)sortOption
                      category:(NSString *)categoryList
{
    /* If the previous request did finish loading (or did fail)
     * then we can send a new request to the ads server and return YES.
     * else return NO. */
    if (webData != nil) 
    {
        NSLog(@"AdsConnect: Previous request should finish loading before starting a new request.");
        return NO;
    }
    if (appKey == nil)
    {
        NSLog(@"AdsConnect: You must set your app key before sending a request using this method.");
        return NO;
    }
    if (delegate == nil)
    {
        NSLog(@"AdsConnect: No delegate object. You must set a delegate object before sending any request. ");
        return NO;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@?udid=%@&app_key=%@&latitude=%f&longitude=%f&limit=%d&sort_by=%@&category=%@",
                           kAdsServerURL,
                           [[UIDevice currentDevice] uniqueIdentifier],
                           self.appKey, 
                           coordinate.latitude, 
                           coordinate.longitude,
                           limit,
                           sortOption,
                           categoryList];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:url 
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                          timeoutInterval:90];
    [requestObj setHTTPMethod:@"GET"];
    
    NSURLConnection *adsServerConnection = [[NSURLConnection alloc] initWithRequest:requestObj delegate:self];
    if (adsServerConnection != nil)
    {
        webData = [[NSMutableData data] retain];
        return YES;
    }
    return NO;
}

/* Request ads from a specific location.
 * The location is given through the <latitude> and <longitude> parameters.
 * This call will request only one Ad. 
 */
- (BOOL)requestAdsFromLatitude:(CLLocationDegrees)latitude 
                     longitude:(CLLocationDegrees)longitude
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return [self requestAdsFromLocation:coordinate];
}

/* Request ads from a specific location. 
 * The location is given through the <latitude> and <longitude> parameters.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30. 
 * The returned ads will be sorted by "performance" by default. 
 */
- (BOOL)requestAdsFromLatitude:(CLLocationDegrees)latitude 
                     longitude:(CLLocationDegrees)longitude 
                         limit:(NSInteger)limit
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return [self requestAdsFromLocation:coordinate 
                                  limit:limit]; 
}

/* Request ads from a specific location. 
 * The location is given through the <latitude> and <longitude> parameters.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30. 
 * The returned ads will be sorted by "performance" by default.
 * This call will return Ads from specified <categoryList>.
 */
- (BOOL)requestAdsFromLatitude:(CLLocationDegrees)latitude 
                     longitude:(CLLocationDegrees)longitude 
                         limit:(NSInteger)limit
                      category:(NSString *)categoryList
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return [self requestAdsFromLocation:coordinate 
                                  limit:limit
                               category:categoryList];
}

/* Request ads from a specific location. 
 * The location is given through the <latitude> and <longitude> parameters.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30.
 * The returned Ads can be sorted by "performance" or by "location". 
 */
- (BOOL)requestAdsFromLatitude:(CLLocationDegrees)latitude 
                     longitude:(CLLocationDegrees)longitude 
                         limit:(NSInteger)limit 
                        sortBy:(NSString *)sortOption
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return [self requestAdsFromLocation:coordinate 
                                  limit:limit
                                 sortBy:sortOption]; 
}

/* Request ads from a specific location. 
 * The location is given through the <latitude> and <longitude> parameters.
 * This call will request up to <limit> Ads. 
 * The <limit> parameter should be a number between 1 and 30.
 * The returned Ads can be sorted by "performance" or by "location".
 * This call will return Ads from specified <categoryList>.
 */
- (BOOL)requestAdsFromLatitude:(CLLocationDegrees)latitude 
                     longitude:(CLLocationDegrees)longitude 
                         limit:(NSInteger)limit 
                        sortBy:(NSString *)sortOption
                      category:(NSString *)categoryList
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    return [self requestAdsFromLocation:coordinate 
                                  limit:limit
                                 sortBy:sortOption
                               category:categoryList];
}

/* Request ad image/thumbnail from url.
 * This method can be used to send multiple image requests.
 */
- (BOOL)requestAdImageFromURL:(NSURL *)url
{
    if ([imageService objectForKey:[url absoluteString]] == nil) 
    {
        AdImageConnect *imageRequest = [[AdImageConnect alloc] initWithURL:url];
        imageRequest.delegate = self;
        [imageRequest requestImage];
        
        [imageService setObject:imageRequest 
                         forKey:[url absoluteString]];
        [imageRequest release];
        return YES;
    }
    return NO;
}

#pragma mark NSURLConnection Load Callbacks

/* Use this for HTTPS: 
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace 
{
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge 
{
	[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
 */

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[connection release];
	[webData release];
	webData = nil;
    
    if ([delegate respondsToSelector:@selector(adsRequestDidFailWithError:)])
    {
        [delegate adsRequestDidFailWithError:error];
    }
    else
    {
        NSLog(@"AdsConnect: Your delegate object doesn't respond to (adsRequestDidFailWithError:) selector.");
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    /* Extract XML from webData. */
	NSString *receivedXML = [[NSString alloc] initWithBytes:[webData mutableBytes] 
													 length:[webData length] 
												   encoding:NSUTF8StringEncoding];
    [connection release];
	[webData release];
	webData = nil;
    
    receivedXML = [AdsXMLParser convertSpecialCharactersToUnicodeInXML:receivedXML];
    //NSLog(@"Received XML : %@", receivedXML);
    
    /* Check for error message from server. */
    NSString *message = [AdsXMLParser contentOfFirstTagWithName:@"message" 
                                                        fromXML:receivedXML];
    if ([message isEqualToString:@""] == NO)
    {
        if ([delegate respondsToSelector:@selector(adsRequestDidLoad:)])
        {
            [delegate adsRequestDidLoad:message];
        }
        else
        {
            NSLog(@"AdsConnect: Your delegate object doesn't respond to (adsRequestDidLoad:) selector.");
        }
    }
    else
    {
        /* Parse the received XML into an array of Ads. */
        id result = [AdsXMLParser adsArrayFromXML:receivedXML];
        
        /* If result array is nil, the server didn't find nearby ads. */
        if (result == nil)
        {
            result = @"There are no ads available for your area. Try again later!";
        }
        if ([delegate respondsToSelector:@selector(adsRequestDidLoad:)])
        {
            [delegate adsRequestDidLoad:result];
        }
        else
        {
            NSLog(@"AdsConnect: Your delegate object doesn't respond to (adsRequestDidLoad:) selector.");
        }
    }
}

# pragma mark AdImageConnect delegate methods

/* Called when an error prevents the request from completing successfully.
 */
- (void)adImageRequestDidFailWithError:(NSError *)error 
                                forURL:(NSURL *)url
{
    /* Remove failed image request. */
    [imageService removeObjectForKey:[url absoluteString]];
    
    if ([delegate respondsToSelector:@selector(adsRequestDidFailWithError:)])
    {
        [delegate adsRequestDidFailWithError:error];
    }
    else
    {
        NSLog(@"AdsConnect: Your delegate object doesn't respond to (adsRequestDidFailWithError:) selector.");
    }
}

/* Called when a request returns and its response has been parsed into an object.
 * The result object may be an image.
 */
- (void)adImageRequestDidLoad:(UIImage *)result 
                       forURL:(NSURL *)url
{
    /* Remove finished image request. */
    [imageService removeObjectForKey:[url absoluteString]];
    
    if ([delegate respondsToSelector:@selector(adsRequestDidLoad:)])
    {
        NSMutableDictionary* dictionary = [[[NSMutableDictionary alloc] initWithCapacity:2] autorelease];
        [dictionary setObject:url 
                       forKey:@"url"];
        [dictionary setObject:result 
                       forKey:@"image"];
        
        [delegate adsRequestDidLoad:(NSDictionary *)dictionary];
    }
    else
    {
        NSLog(@"AdsConnect: Your delegate object doesn't respond to (adsRequestDidLoad:) selector.");
    }
}

@end
