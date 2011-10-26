//
//  AdImageConnect.m
//  GeoAds+ iOS SDK
//
//  Created by Radu-Tudor Ionescu on 7/18/11.
//  Copyright 2011 Viewlity.com. All rights reserved.
//

#import "AdImageConnect.h"

@implementation AdImageConnect

@synthesize url, delegate;

- (id)init
{
    self = [super init];
    if (self) 
	{
        self.url = nil;
        webData = nil;
        self.delegate = nil;
    }
    return self;
}

/* Init an AdImageConnect object with an image/thumbnail url. 
 */
- (id)initWithURL:(NSURL *)URL
{
    self = [self init];
    if (self) 
	{
        self.url = URL;
    }
    return self;
}

- (void)dealloc 
{
    [url release];
    [webData release];
    [super dealloc];
}

/* Request image from a specific url. 
 */
- (BOOL)requestImage
{
    /* If the previous request did finish loading (or did fail)
     * then we can send a new request to the ads server and return YES.
     * else return NO. */
    if (webData != nil) 
    {
        NSLog(@"AdsConnect: Previous image request should finish loading before starting a new request.");
        return NO;
    }
    if (url == nil)
    {
        NSLog(@"AdImageConnect: No url object. You must set an URL to request an image from that URL. ");
        return NO;
    }
    if (delegate == nil)
    {
        NSLog(@"AdImageConnect: No delegate object. You must set a delegate object before sending any image request. ");
        return NO;
    }
    
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
    
    if ([delegate respondsToSelector:@selector(adImageRequestDidFailWithError:forURL:)])
    {
        [delegate adImageRequestDidFailWithError:error
                                          forURL:self.url];
    }
    else
    {
        NSLog(@"AdImageConnect: Your delegate object doesn't respond to (adImageRequestDidFailWithError:forURL:) selector.");
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    /* Extract UIImage from webData. */
    UIImage *result = [UIImage imageWithData:webData];
    
	[connection release];
	[webData release];
	webData = nil;
    
    if ([delegate respondsToSelector:@selector(adImageRequestDidLoad:forURL:)])
    {
        [delegate adImageRequestDidLoad:result 
                                 forURL:self.url];
    }
    else
    {
        NSLog(@"AdImageConnect: Your delegate object doesn't respond to (adImageRequestDidLoad:forURL:) selector.");
    }
}

@end
